import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  bool selected = false;
  bool selectedrequire = false;

  bool selectindex = false;
  final List<ItemModel> _chipsList = [
    ItemModel("UG", AppColors.PrimaryWhiteColor, false),
    ItemModel("Twinning Programmes (UG)", AppColors.PrimaryWhiteColor, false),
    ItemModel("Foundation", AppColors.PrimaryWhiteColor, false),
    ItemModel("Short Term Programs", AppColors.PrimaryWhiteColor, false),
    ItemModel("High School (11th-12th)", AppColors.PrimaryWhiteColor, false),
    ItemModel("Pathway Programs", AppColors.PrimaryWhiteColor, false),
    ItemModel("PG Diploma/Certificate", AppColors.PrimaryWhiteColor, false),
    ItemModel("PHD", AppColors.PrimaryWhiteColor, false),
    ItemModel("PG", AppColors.PrimaryWhiteColor, false),
    ItemModel("Twinning Programmes (PG)", AppColors.PrimaryWhiteColor, false),
    ItemModel("UG Diploma/ Certificate/ Associate  Degreee",
        AppColors.PrimaryWhiteColor, false),
    ItemModel("UG+PG (Accelerated) Degree", AppColors.PrimaryWhiteColor, false),
  ];

  final List<ItemModel> _requirementList = [
    ItemModel("IELTS", AppColors.PrimaryWhiteColor, false),
    ItemModel("ACT", AppColors.PrimaryWhiteColor, false),
    ItemModel("TOEFL iBT", AppColors.PrimaryWhiteColor, false),
    ItemModel("GRE", AppColors.PrimaryWhiteColor, false),
    ItemModel("PTE", AppColors.PrimaryWhiteColor, false),
    ItemModel("GMAT", AppColors.PrimaryWhiteColor, false),
    ItemModel("SAT", AppColors.PrimaryWhiteColor, false),
    ItemModel("Without GRE", AppColors.PrimaryWhiteColor, false),
    ItemModel("Without SAT", AppColors.PrimaryWhiteColor, false),
    ItemModel("without GMAT", AppColors.PrimaryWhiteColor, false),
    ItemModel("Without ACT", AppColors.PrimaryWhiteColor, false),
    ItemModel("Without IELTS", AppColors.PrimaryWhiteColor, false),
    ItemModel("Placement", AppColors.PrimaryWhiteColor, false),
    ItemModel("Without Placement", AppColors.PrimaryWhiteColor, false),
    ItemModel("Conditional", AppColors.PrimaryWhiteColor, false),
    ItemModel("Without Conditional", AppColors.PrimaryWhiteColor, false),
    ItemModel("Deadline Available", AppColors.PrimaryWhiteColor, false),
    ItemModel("Scholarship Available", AppColors.PrimaryWhiteColor, false),
    ItemModel("with 15 Years Of Education", AppColors.PrimaryWhiteColor, false),
  ];

  List chiparray = [];
  List requirement = [];

  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  bool isSelected = false;

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3, initialIndex: 0);
    _tabController!.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: AppBar(
        backgroundColor: AppColors.PrimaryMainColor,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pushNamed(context, RoutesName.courseSearch);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.PrimaryWhiteColor,
            size: 20.sp,
          ),
        ),
        // centerTitle: true,

        title: Row(
          children: [
            Container(
              height: 40.h,
              width: 220.w,
              decoration: BoxDecoration(
                  color: AppColors.PrimaryWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      bottomLeft: Radius.circular(10.r))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      Icon(
                        Icons.search,
                        color: AppColors.PrimaryMainColor,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        "Search Courses/University",
                        style: TextRegular(AppColors.PrimaryMainColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  bottomDialog(context);
                });
              },
              child: Container(
                height: 40.h,
                width: 50.w,
                padding: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                    color: AppColors.PrimaryWhiteColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.r),
                        bottomRight: Radius.circular(10.r))),
                child: Icon(
                  Icons.filter_alt,
                  color: AppColors.PrimaryMainColor,
                  size: 40.sp,
                ),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 6,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.courseDetails);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            //mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                  // leading: Text("Master of Science in Computer science With Big Data andArtificial Interlligence"),
                                  title: Text(
                                      'Master of Science in Computer science With Big Data andArtificial Interlligence',
                                      style: Text2Regular(
                                          AppColors.PrimaryBlackColor)),
                                  subtitle: Column(
                                    children: [
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "assets/images/uicon1.png",
                                            height: 40.h,
                                            width: 40.w,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          SizedBox(
                                            width: 230.w,
                                            child: Text(
                                              "SRH Berlin University of Applied science",
                                              style: TextRegular(
                                                  AppColors.PrimaryBlackColor),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          // Icon(Icons.map),
                                          Image.asset(
                                            "assets/images/worldmap.png",
                                            height: 30.h,
                                            width: 30.w,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          SizedBox(
                                            width: 100.w,
                                            child: Text(
                                              "Germany, Berlin",
                                              style: TextRegular(
                                                  AppColors.PrimaryBlackColor),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Image.asset(
                                            "assets/images/rupee.png",
                                            height: 30.h,
                                            width: 30.w,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          SizedBox(
                                            width: 100.w,
                                            child: Text(
                                              "€ 6450/semester",
                                              style: TextRegular(
                                                  AppColors.PrimaryBlackColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  List<Widget> filterChipsList(index, StateSetter setState) {
    List<Widget> chips = [];
    for (int i = 0; i < _chipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: FilterChip(
          elevation: 6,
          autofocus: true,
          checkmarkColor: AppColors.PrimaryWhiteColor,
          selectedColor: AppColors.PrimaryMainColor,
          disabledColor: AppColors.PrimaryBlackColor,
          label: _chipsList[i].isSelected
              ? Text(
                  _chipsList[i].label,
                  style: TextRegular(AppColors.PrimaryWhiteColor),
                )
              : Text(
                  _chipsList[i].label,
                  style: TextRegular(AppColors.PrimaryBlackColor),
                ),
          labelStyle: const TextStyle(color: Colors.white, fontSize: 16),
          backgroundColor:
              selected ? AppColors.PrimaryMainColor : _chipsList[i].color,
          selected: _chipsList[i].isSelected,
          onSelected: (bool value) {
            setState(() {
              _chipsList[i].isSelected = value;
              if (chiparray.contains(_chipsList[i].label)) {
                chiparray.remove(_chipsList[i].label);
              } else {
                chiparray.add(_chipsList[i].label);
              }
              //  optionSelect();
              print(chiparray);
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }

  List<Widget> requireChipsList(index, StateSetter setState) {
    List<Widget> chips = [];
    for (int i = 0; i < _requirementList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: FilterChip(
          elevation: 6,
          autofocus: true,
          checkmarkColor: AppColors.PrimaryWhiteColor,
          selectedColor: AppColors.PrimaryMainColor,
          disabledColor: AppColors.PrimaryBlackColor,
          label: _requirementList[i].isSelected
              ? Text(
                  _requirementList[i].label,
                  style: TextRegular(AppColors.PrimaryWhiteColor),
                )
              : Text(
                  _requirementList[i].label,
                  style: TextRegular(AppColors.PrimaryBlackColor),
                ),
          labelStyle: const TextStyle(color: Colors.white, fontSize: 16),
          backgroundColor:
              selected ? AppColors.PrimaryMainColor : _requirementList[i].color,
          selected: _requirementList[i].isSelected,
          onSelected: (bool value) {
            setState(() {
              _requirementList[i].isSelected = value;
              if (requirement.contains(_requirementList[i].label)) {
                requirement.remove(_requirementList[i].label);
              } else {
                requirement.add(_requirementList[i].label);
              }
              //  optionSelect();
              print(requirement);
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }

  optionSelect(index, StateSetter setState) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 8,
        direction: Axis.horizontal,
        children: requireChipsList(index, setState),
      ),
    );
  }

  requireSelect(index, StateSetter setState) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 8,
        direction: Axis.horizontal,
        children: filterChipsList(index, setState),
      ),
    );
  }

  bottomDialog(index) {
    return showModalBottomSheet(
      elevation: 1,

      backgroundColor: AppColors.backgroungcolor,

      // isScrollControlled: true,
      // gives rounded corner to modal bottom screen
      // isScrollControlled: false,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: FadeIn(
                    curve: Curves.elasticInOut,
                    duration: const Duration(seconds: 2),
                    child: Text("Advanced Search",
                        style: FieldTextStyle(
                          AppColors.PrimaryBlackColor,
                        )),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 2.h,
                    width: 380.w,
                    decoration: BoxDecoration(
                      color: AppColors.PrimaryMainColor,
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppColors.backgroungcolor,
                      borderRadius: BorderRadius.circular(20)),
                  child: TabBar(
                    isScrollable: true,
                    // labelColor:
                    //    AppColors.PrimaryWhiteColor, //<-- selected text color
                    // unselectedLabelColor: AppColors.PrimaryWhiteColor,

                    labelColor: Colors.red,
                    // indicatorColor: AppColors.PrimaryMainColor,
                    // unselectedLabelColor: Colors.red,
                    //indicatorWeight: 2.h,

                    padding: EdgeInsets.only(left: 10.r, right: 10.r),

                    //indicatorSize: TabBarIndicatorSize.label,

                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.PrimaryMainColor,
                      // border: Border.all(color: AppColors.PrimaryMainColor)
                    ),
                    tabs: <Widget>[
                      Tab(
                        child: Text(
                          "Advanced",
                          style: Text2Regular(_tabController?.index == 0
                              ? AppColors.PrimaryWhiteColor
                              : AppColors.PrimaryMainColor),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Program Level",
                          style: Text2Regular(AppColors.PrimaryMainColor),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Requirements",
                          style: Text2Regular(AppColors.PrimaryMainColor),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15.sp),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Country",
                                  style: FieldTextStyle(
                                    AppColors.PrimaryBlackColor,
                                  )),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                height: 50.h,
                                width: 480.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: AppColors.PrimaryWhiteColor),
                                child: DropdownButtonFormField(
                                  style: TextStyle(
                                      color: AppColors.PrimaryMainColor,
                                      fontWeight: FontWeight.w600),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                          color: AppColors.PrimaryGreyColor,
                                          width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                        color: AppColors.PrimaryBlackColor,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  value: dropdownvalue,
                                  isExpanded: true,
                                  icon: Padding(
                                    padding: EdgeInsets.only(right: 10.r),
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 30.sp,
                                      color: AppColors.PrimaryMainColor,
                                    ),
                                  ),
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.r),
                                        child: Text(items),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      isSelected = true;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text("University",
                                  style: FieldTextStyle(
                                    AppColors.PrimaryBlackColor,
                                  )),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                height: 50.h,
                                width: 480.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: AppColors.PrimaryWhiteColor),
                                child: DropdownButtonFormField(
                                  style: TextStyle(
                                      color: AppColors.PrimaryMainColor,
                                      fontWeight: FontWeight.w600),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                          color: AppColors.PrimaryGreyColor,
                                          width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                        color: AppColors.PrimaryBlackColor,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  value: dropdownvalue,
                                  isExpanded: true,
                                  icon: Padding(
                                    padding: EdgeInsets.only(right: 10.r),
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 30.sp,
                                      color: AppColors.PrimaryMainColor,
                                    ),
                                  ),
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.r),
                                        child: Text(items),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      isSelected = true;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text("Location",
                                  style: FieldTextStyle(
                                    AppColors.PrimaryBlackColor,
                                  )),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                height: 50.h,
                                width: 480.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: AppColors.PrimaryWhiteColor),
                                child: DropdownButtonFormField(
                                  style: TextStyle(
                                      color: AppColors.PrimaryMainColor,
                                      fontWeight: FontWeight.w600),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                          color: AppColors.PrimaryGreyColor,
                                          width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                        color: AppColors.PrimaryBlackColor,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  value: dropdownvalue,
                                  isExpanded: true,
                                  icon: Padding(
                                    padding: EdgeInsets.only(right: 10.r),
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 30.sp,
                                      color: AppColors.PrimaryMainColor,
                                    ),
                                  ),
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.r),
                                        child: Text(items),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      isSelected = true;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text("Intake",
                                  style: FieldTextStyle(
                                    AppColors.PrimaryBlackColor,
                                  )),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                height: 50.h,
                                width: 480.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: AppColors.PrimaryWhiteColor),
                                child: DropdownButtonFormField(
                                  style: TextStyle(
                                      color: AppColors.PrimaryMainColor,
                                      fontWeight: FontWeight.w600),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                          color: AppColors.PrimaryGreyColor,
                                          width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                        color: AppColors.PrimaryBlackColor,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  value: dropdownvalue,
                                  isExpanded: true,
                                  icon: Padding(
                                    padding: EdgeInsets.only(right: 10.r),
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 30.sp,
                                      color: AppColors.PrimaryMainColor,
                                    ),
                                  ),
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.r),
                                        child: Text(items),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      isSelected = true;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text("Duration",
                                  style: FieldTextStyle(
                                    AppColors.PrimaryBlackColor,
                                  )),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                height: 50.h,
                                width: 480.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: AppColors.PrimaryWhiteColor),
                                child: DropdownButtonFormField(
                                  style: TextStyle(
                                      color: AppColors.PrimaryMainColor,
                                      fontWeight: FontWeight.w600),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                          color: AppColors.PrimaryGreyColor,
                                          width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                        color: AppColors.PrimaryBlackColor,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  value: dropdownvalue,
                                  isExpanded: true,
                                  icon: Padding(
                                    padding: EdgeInsets.only(right: 10.r),
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 30.sp,
                                      color: AppColors.PrimaryMainColor,
                                    ),
                                  ),
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.r),
                                        child: Text(items),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      isSelected = true;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text("Study Area",
                                  style: FieldTextStyle(
                                    AppColors.PrimaryBlackColor,
                                  )),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                height: 50.h,
                                width: 480.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: AppColors.PrimaryWhiteColor),
                                child: DropdownButtonFormField(
                                  style: TextStyle(
                                      color: AppColors.PrimaryMainColor,
                                      fontWeight: FontWeight.w600),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                          color: AppColors.PrimaryGreyColor,
                                          width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                        color: AppColors.PrimaryBlackColor,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  value: dropdownvalue,
                                  isExpanded: true,
                                  icon: Padding(
                                    padding: EdgeInsets.only(right: 10.r),
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 30.sp,
                                      color: AppColors.PrimaryMainColor,
                                    ),
                                  ),
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.r),
                                        child: Text(items),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      isSelected = true;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text("Discipline Area",
                                  style: FieldTextStyle(
                                    AppColors.PrimaryBlackColor,
                                  )),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                height: 50.h,
                                width: 480.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: AppColors.PrimaryWhiteColor),
                                child: DropdownButtonFormField(
                                  style: TextStyle(
                                      color: AppColors.PrimaryMainColor,
                                      fontWeight: FontWeight.w600),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                          color: AppColors.PrimaryGreyColor,
                                          width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                        color: AppColors.PrimaryBlackColor,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  value: dropdownvalue,
                                  isExpanded: true,
                                  icon: Padding(
                                    padding: EdgeInsets.only(right: 10.r),
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 30.sp,
                                      color: AppColors.PrimaryMainColor,
                                    ),
                                  ),
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.r),
                                        child: Text(items),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      isSelected = true;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      requireSelect(index, setState),
                      optionSelect(index, setState),

                      // Wrap(
                      //   spacing: 8,
                      //   direction: Axis.horizontal,
                      //   children: filterChipsList(index, setState),
                      // ),

                      // setState(){

                      // }
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: FloatingActionButton.extended(
                      elevation: 0,

                      // foregroundColor: Colors.transparent,
                      backgroundColor: AppColors.PrimaryMainColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      label: const Text("Search")),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          );
        });
        // Container(
        //   height: 800.h,
        //   decoration: BoxDecoration(
        //       //color: Colors.amber,
        //       borderRadius: BorderRadius.only(
        //           topRight: Radius.circular(10.r),
        //           topLeft: Radius.circular(10.r))),
        //   child: Column(
        //     children: [
        //       SizedBox(
        //         height: 10.h,
        //       ),
        //       Container(
        //         height: 5.h,
        //         width: 250.w,
        //         decoration: BoxDecoration(
        //           color: AppColors.PrimaryMainColor,
        //           borderRadius: BorderRadius.circular(10.sp),
        //         ),
        //       ),
        //       SizedBox(
        //         height: 20.h,
        //       ),
        //       InkWell(
        //         onTap: () {
        //           // optionSelect();
        //         },
        //         child: Container(
        //           height: 60.h,
        //           width: 250.w,
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(10.sp),
        //               border: Border.all(color: AppColors.PrimaryMainColor)),
        //           child: ListTile(
        //               leading: Text(
        //                 "Advanced Search",
        //                 style: OtpText(AppColors.PrimaryMainColor),
        //               ),
        //               trailing: Icon(
        //                 Icons.keyboard_arrow_down,
        //                 color: AppColors.PrimaryMainColor,
        //                 size: 25.sp,
        //               )),
        //         ),
        //       ),
        //       SizedBox(
        //         height: 20.h,
        //       ),
        //       Container(
        //         height: 60.h,
        //         width: 250.w,
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(10.sp),
        //             border: Border.all(color: AppColors.PrimaryMainColor)),
        //         child: ListTile(
        //             leading: Text(
        //               "Program Level",
        //               style: OtpText(AppColors.PrimaryMainColor),
        //             ),
        //             trailing: Icon(
        //               Icons.keyboard_arrow_down,
        //               color: AppColors.PrimaryMainColor,
        //               size: 25.sp,
        //             )),
        //       ),
        //       SizedBox(
        //         height: 20.h,
        //       ),
        //       Container(
        //         height: 60.h,
        //         width: 250.w,
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(10.sp),
        //             border: Border.all(color: AppColors.PrimaryMainColor)),
        //         child: ListTile(
        //             leading: Text(
        //               "Requirements",
        //               style: OtpText(AppColors.PrimaryMainColor),
        //             ),
        //             trailing: Icon(
        //               Icons.keyboard_arrow_down,
        //               color: AppColors.PrimaryMainColor,
        //               size: 25.sp,
        //             )),
        //       ),
        //       // Container(
        //       //   child: Wrap(
        //       //     spacing: 8,
        //       //     direction: Axis.horizontal,
        //       //     children: filterChipsList(),
        //       //   ),
        //       // ),
        //     ],
        //   ),
        // );
      },
    );
  }
}

class ItemModel {
  String label;
  Color color;
  bool isSelected;

  ItemModel(this.label, this.color, this.isSelected);
}
