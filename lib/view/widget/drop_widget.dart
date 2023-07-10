// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:global_student/utils/color.dart';

// class DropDownWidget extends StatefulWidget {
//   final String? dropvalue;

//   final List<DropdownMenuItem<String>>? data;
//   DropDownWidget({super.key, this.dropvalue, required this.data});

//   @override
//   State<DropDownWidget> createState() => _DropDownWidgetState(dropvalue, data);
// }

// class _DropDownWidgetState extends State<DropDownWidget> {
//   String? dropvalue;
//   bool isSelected = true;
//   final List<DropdownMenuItem<String>>? data;

//   _DropDownWidgetState(this.dropvalue, this.data);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 50.h,
//           width: 480.w,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
//           child: DropdownButtonFormField(
//             decoration: InputDecoration(
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.r),
//                 borderSide:
//                     BorderSide(color: AppColors.PrimaryGreyColor, width: 1),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.r),
//                 borderSide: BorderSide(
//                   color: AppColors.PrimaryBlackColor,
//                   width: 1,
//                 ),
//               ),
//             ),
//             value: dropvalue,
//             isExpanded: true,
//             icon: Padding(
//               padding: EdgeInsets.only(right: 10.r),
//               child: Icon(
//                 Icons.keyboard_arrow_down,
//                 size: 30.sp,
//                 color: AppColors.PrimaryBlackColor,
//               ),
//             ),
//             items: [data.toString()].map((String items) {
//               return DropdownMenuItem<String>(
//                 value: items,
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 10.r),
//                   child: Text(items),
//                 ),
//               );
//             }).toList(),
//             onChanged: (String? newValue) {
//               setState(() {
//                 isSelected = true;
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePageData extends StatefulWidget {
  const HomePageData({Key? key}) : super(key: key);

  @override
  State<HomePageData> createState() => _HomePageDataState();
}

class _HomePageDataState extends State<HomePageData> {
  // We will fetch data from this Rest api
  final _baseUrl =
      'http://crmapi.global-opportunities.co.in/Api/SearchCourseMaster/CountryWiseUniversityList';

  // At the beginning, we fetch the first 20 posts
  int _page = 0;
  // you can change this value to fetch more or less posts per page (10, 15, 5, etc)
  final int _limit = 20;

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  // This holds the posts fetched from the server
  List _posts = [];

  // This function will be called when the app launches (see the initState function)
  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res =
          await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));

   
      setState(() {
        _posts = json.decode(res.body);
      });
    } catch (err) {
      if (kDebugMode) {
       
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1
      try {
        final res =
            await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _posts.addAll(fetchedPosts);
          });
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
     
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  // The controller for the ListView
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: _isFirstLoadRunning
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: _posts.length,
                    itemBuilder: (_, index) => Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      child: ListTile(
                        title: Text(_posts[index]['title']),
                        subtitle: Text(_posts[index]['body']),
                      ),
                    ),
                  ),
                ),

                // when the _loadMore function is running
                if (_isLoadMoreRunning == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),

                // When nothing else to load
                if (_hasNextPage == false)
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 40),
                    color: Colors.amber,
                    child: const Center(
                      child: Text('You have fetched all of the content'),
                    ),
                  ),
              ],
            ),
    );
  }
}
