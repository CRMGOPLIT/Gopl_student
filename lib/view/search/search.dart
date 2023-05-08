import 'dart:developer';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/bloc/searchBloc.dart';
import 'package:global_student/model/countrySearchModel.dart';
import 'package:global_student/model/disciplinearea.dart';
import 'package:global_student/model/locationsearchmodel.dart';
import 'package:global_student/model/monthModel.dart';
import 'package:global_student/model/studyareaModel.dart';
import 'package:global_student/networking/networkConstant.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';
import '../../model/universitySearchModel.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: AppBar(
          backgroundColor: AppColors.PrimaryMainColor,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(0),
                bottomLeft: Radius.circular(0)),
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
          title: Text("Search "),
        ),
      ),
      body: Column(
        children: [
          // Text(universitySearchdata[0].name.toString()),
          Container(
            padding: EdgeInsets.all(10),
            // height: 70,
            decoration: BoxDecoration(
              color: AppColors.PrimaryMainColor,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30.h,
                ),
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
                            color: AppColors.hintcolor,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            "Search Courses/University",
                            style: batchtext2(AppColors.hintcolor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      elevation: 1,

                      backgroundColor: AppColors.backgroungcolor,

                      isScrollControlled: true,
                      // gives rounded corner to modal bottom screen
                      // isScrollControlled: false,

                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      context: context,
                      builder: (BuildContext context) {
                        return MyBottomSheet();
                      },
                    );
                  },
                  child: Container(
                    height: 40.h,
                    width: 80.w,
                    //padding: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                        color: AppColors.backgroungcolor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.r),
                            bottomRight: Radius.circular(10.r))),
                    child: Icon(
                      Icons.filter_alt,
                      color: AppColors.PrimaryMainColor,
                      size: 30.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            //mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                  // leading: Text("Master of Science in Computer science With Big Data andArtificial Interlligence"),
                                  title: Text(
                                      'Master of Science in Computer science With Big Data andArtificial Interlligence',
                                      style: batchtext2(
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
                                              style: batchtext1(
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
                                              style: batchtext1(
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
                                          Flexible(
                                            // width: 100.w,
                                            child: Text(
                                              "€ 6450/semester",
                                              style: batchtext1(
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
}

class MyBottomSheet extends StatefulWidget {
  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  String? selectedValue;
  List<String> options = ['Option 1', 'Option 2', 'Option 3'];
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  final List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  bool selected = false;
  bool selectedrequire = false;

  final List<String> items1 = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  List<String> selectedItems = [];
  List<String> selecteduniversity = [];
  List<String> selectedlocation = [];
  List<String> selectedintake = [];
  List<String> selectedstudyarea = [];
  List<String> selecteddisciplinearea = [];

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
                  style: batchtext1(AppColors.PrimaryWhiteColor),
                )
              : Text(
                  _chipsList[i].label,
                  style: batchtext1(AppColors.PrimaryBlackColor),
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
                  style: batchtext1(AppColors.PrimaryWhiteColor),
                )
              : Text(
                  _requirementList[i].label,
                  style: batchtext1(AppColors.PrimaryBlackColor),
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

  bool isSelected = false;

  TabController? _tabController;

  @override
  void initState() {
    searchBloc = SearchBloc();
    super.initState();
    //  _tabController = TabController(vsync: this, length: 3, initialIndex: 0);
    // _tabController!.addListener(_handleTabSelection);
    getdata();
    showYear();

    getSearchCountry();
    getSearchUniversity();
  }

  late SearchBloc searchBloc;
  bool loanding = false;
  List<CountrySearchModel> countrySearchdata = [];
  List<UniversitySearchModel> universitySearchdata = [];
  List<LocationSearchModel> locationSearchdata = [];
  List<StudyAreaSearchModel> studyareaSearchdata = [];
  List<DiscplineareaSearchModel> disciplineareaSearchdata = [];
  TextEditingController textEditingController = TextEditingController();
  List cuntrydata = [];
  List universitydata = [];
  List locationdata = [];
  List studyareadata = [];
  List disciplineareadata = [];
  int? yeardrop;

  MonthModel? dropmonth;

  DurationModel? dropduration;

  getSearchCountry() async {
    searchBloc.getcountrysearchStream.listen((event) {
      if (event != null) {
        cuntrydata = event;

        for (int i = 0; i < cuntrydata.length; i++) {
          CountrySearchModel countrySearchModel =
              CountrySearchModel.fromJson(event[i]);

          countrySearchdata.add(countrySearchModel);

          setState(() {
            loanding = false;

            //print(location);
          });
        }
      }
      searchBloc.getuniversitysearchStream.listen((event) {
        if (event != null) {
          // debugger();
          // print(event);

          universitydata = event;

          log("kejnkjjr" + universitydata.toString());
          //  universitySearchdata.clear();

          for (int i = 0; i < universitydata.length; i++) {
            UniversitySearchModel universitySearchModel =
                UniversitySearchModel.fromJson(event[i]);

            //  debugger();
            //  print(universitySearchdata);
            setState(() {
              universitySearchdata.add(universitySearchModel);

              loanding = false;

              //print(location);
            });
          }
        }
      });
      searchBloc.getlocationsearchStream.listen((event) {
        if (event != null) {
          // debugger();
          // print(event);

          locationdata = event;

          log("kejnkjjr" + locationdata.toString());
          //  universitySearchdata.clear();

          for (int i = 0; i < locationdata.length; i++) {
            LocationSearchModel locationSearchModel =
                LocationSearchModel.fromJson(event[i]);

            //  debugger();
            //  print(universitySearchdata);
            setState(() {
              locationSearchdata.add(locationSearchModel);

              // dropuniversity = universitySearchdata[0];
              loanding = false;

              //print(location);
            });
          }
        }
      });

      searchBloc.getstudyareasearchStream.listen((event) {
        if (event != null) {
          studyareadata = event;

          log("kejnkjjr" + studyareadata.toString());
          //  universitySearchdata.clear();

          for (int i = 0; i < studyareadata.length; i++) {
            StudyAreaSearchModel studyAreaSearchModel =
                StudyAreaSearchModel.fromJson(event[i]);

            //  debugger();
            //  print(universitySearchdata);
            setState(() {
              studyareaSearchdata.add(studyAreaSearchModel);

              // dropuniversity = universitySearchdata[0];
              loanding = false;

              //print(location);
            });
          }
        }
      });
    });
    searchBloc.getdisciplineareasearchStream.listen((event) {
      if (event != null) {
        // debugger();
        // print(event);

        disciplineareadata = event;

        log("kejnkjjr" + disciplineareadata.toString());
        //  universitySearchdata.clear();

        for (int i = 0; i < disciplineareadata.length; i++) {
          DiscplineareaSearchModel discplineareaSearchModel =
              DiscplineareaSearchModel.fromJson(event[i]);

          //  debugger();
          //  print(universitySearchdata);
          setState(() {
            disciplineareaSearchdata.add(discplineareaSearchModel);
            // print(disciplineareaSearchdata[i].name);
            // selecteddisciplinearea = disciplineareaSearchdata[];

            // dropuniversity = universitySearchdata[0];
            loanding = false;

            //print(location);
          });
        }
      }
    });
  }

  getSearchUniversity() {}

  void _handleTabSelection() {
    setState(() {});
  }

  getdata() {
    searchBloc.callGetCountrySearchApi();
    searchBloc.callGetStudyAreaSearchApi();
  }

  getuniverstty() {
    String spselcected = selectedItems.join(",");

    Map<String, dynamic> data = {"countryId": spselcected};
    searchBloc.callGetUniversitySearchApi(data);
  }

  getDisciplineArea() {
    String spdispline = selectedstudyarea.join(",");
    Map<String, dynamic> data = {"Id": spdispline};
    searchBloc.callGetDisciplineSearchApi(data);
  }

  getlocation() {
    String spselcected = selectedItems.join(",");
    String uniselected = selecteduniversity.join(",");
    Map<String, String> locationdropdata = {
      "countryId": spselcected,
      "University": uniselected,
    };
    searchBloc.callGetLocationSearchApi(locationdropdata);
  }

  List yearList = [];

  showYear() {
    int year = DateTime.now().year;
    int yearfrom = year;
    int yearto = year + 2;
    for (int i = yearfrom; i <= yearto; i++) {
      yearList.add(i);
    }
  }

  searchFilter() {
    String spselcected = selectedItems.join(",");
    String uniselected = selecteduniversity.join(",");
    String spdispline = selecteddisciplinearea.join(",");
    String studyarea = selectedstudyarea.join(",");
    String program = chiparray.join(",");
    String intake = selectedintake.join(",");
    String location = selectedlocation.join(",");
    Map<String, String> filterdata = {
      NetworkConstant.filterType: "Advance Search",
      NetworkConstant.pageNumber: 1.toString(),
      NetworkConstant.sortBy: "",
      NetworkConstant.courseName: "",
      NetworkConstant.year: yeardrop.toString(),
      NetworkConstant.intake: intake,
      NetworkConstant.countryId: spselcected,
      NetworkConstant.scholarship: "",
      NetworkConstant.studyArea: studyarea,
      NetworkConstant.disciplineArea: spdispline,
      NetworkConstant.flocation: location,
      NetworkConstant.duration:
          dropduration == null ? "0" : dropduration!.id.toString(),
      NetworkConstant.isIELTS: "",
      NetworkConstant.istOEFL: "",
      NetworkConstant.placement: "",
      NetworkConstant.ispte: "",
      NetworkConstant.issat: "",
      NetworkConstant.isACT: "",
      NetworkConstant.isGRE: "",
      NetworkConstant.isGMAT: "",
      NetworkConstant.deadlineAvailable: "",
      NetworkConstant.fifteenYearsOfEd: "",
      NetworkConstant.eslElp: "",
      NetworkConstant.conditionalOffer: "",
      NetworkConstant.programLevel: program,
      NetworkConstant.universityId: uniselected,
      NetworkConstant.fRequest: "CRM",
      NetworkConstant.crmAccessRequest: "Country Manager",
    };
    searchBloc.callGetFilterSearch(filterdata);
    debugger();
    print(filterdata);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: DefaultTabController(
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
              height: 50,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: TabBar(
                isScrollable: true,
                labelColor: AppColors.PrimaryWhiteColor,
                indicatorColor: AppColors.PrimaryBlackColor,
                unselectedLabelColor: AppColors.PrimaryMainColor,
                padding: EdgeInsets.only(left: 10.r, right: 10.r, bottom: 10.r),
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.PrimaryMainColor

                    // border: Border.all(color: AppColors.PrimaryMainColor)
                    ),
                tabs: const [
                  Tab(
                    child: Text(
                      "Advanced",
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Program Level",
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Requirements",
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
                          Text("Year",
                              style: FieldTextStyle(
                                AppColors.PrimaryBlackColor,
                              )),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField2(
                                isDense: false,
                                isExpanded: true,
                                decoration: InputDecoration(
                                  // enabledBorder: OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(10),
                                  //   // width: 0.0 produces a thin "hairline" border
                                  //   borderSide: BorderSide(
                                  //       color: AppColors.PrimaryMainColor, width: 1.0),
                                  // ),
                                  errorBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: new BorderSide(
                                        color: Colors.red, width: 1.0),
                                  ),
                                  isCollapsed: true,
                                  border: InputBorder.none,
                                ),
                                // validator: (value) {
                                //   if (value == null || value.name.isEmpty) {
                                //     return 'Please Select Qualification';
                                //   }
                                //   return null;
                                // },
                                hint: Text(
                                  'Year',
                                  style: batchtext2(AppColors.hintcolor),
                                ),
                                items: yearList
                                    .map((item) => DropdownMenuItem(
                                          value: item,
                                          child: Text(
                                            item.toString(),
                                            style: batchtext2(
                                                AppColors.PrimaryMainColor),
                                          ),
                                        ))
                                    .toList(growable: false),
                                value: yeardrop,
                                onChanged: (value) {
                                  setState(() {
                                    yeardrop = value as int?;
                                    isSelected = true;
                                    //  selectedSecurity = value!;
                                    // accountTypeValidate = true;
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 55,
                                  // width: 450,
                                  padding: EdgeInsets.all(10.r),
                                ),
                                dropdownStyleData: DropdownStyleData(
                                    // isOverButton: true,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
                                        color: AppColors.backgroungcolor,
                                        border: Border.all()),
                                    maxHeight: 300.h,
                                    // width: 500.w,
                                    elevation: 10),
                                menuItemStyleData: const MenuItemStyleData(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  height: 40,
                                ),
                                // dropdownSearchData: DropdownSearchData(
                                //   searchController: textEditingController,
                                //   searchInnerWidgetHeight: 200.h,
                                //   searchInnerWidget: Container(
                                //     height: 50,
                                //     padding: const EdgeInsets.only(
                                //       top: 8,
                                //       bottom: 4,
                                //       right: 8,
                                //       left: 8,
                                //     ),
                                //     child: TextFormField(
                                //       style: batchtext2(
                                //           AppColors.PrimaryMainColor),
                                //       //expands: true,
                                //       maxLines: 1,
                                //       controller: textEditingController,
                                //       decoration: InputDecoration(
                                //         isDense: true,
                                //         contentPadding:
                                //             const EdgeInsets.symmetric(
                                //           horizontal: 15,
                                //           vertical: 15,
                                //         ),
                                //         hintText: 'Search here...',
                                //         hintStyle: batchtext2(
                                //             AppColors.PrimaryMainColor),
                                //         border: OutlineInputBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(8),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                //   searchMatchFn: (item, searchValue) {
                                //     // final myItem = qualificationlist.firstWhere((element) =>
                                //     //     element.name.toString() == item.value.toString());
                                //     return item.value!
                                //         .toString()
                                //         .toLowerCase()
                                //         .contains(searchValue);
                                //   },
                                // ),
                                onMenuStateChange: (isOpen) {
                                  if (isOpen) {
                                    textEditingController.clear();
                                  }
                                },
                                iconStyleData: IconStyleData(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColors.PrimaryMainColor,
                                  ),
                                  iconSize: 30,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          // ElevatedButton(
                          //   child: const Text('Raised Button'),
                          //   onPressed: () {
                          //     getuniverstty();
                          //   },
                          // ),
                          Text("Country",
                              style: FieldTextStyle(
                                AppColors.PrimaryBlackColor,
                              )),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Text(
                                  'Please Select Country',
                                  style: batchtext2(AppColors.hintcolor),
                                ),
                                items: countrySearchdata.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item.id,
                                    //disable default onTap to avoid closing menu when selecting an item
                                    enabled: false,
                                    child: StatefulBuilder(
                                      builder: (context, menuSetState) {
                                        final _isSelected =
                                            selectedItems.contains(item.id);
                                        return InkWell(
                                          onTap: () {
                                            _isSelected
                                                ? selectedItems.remove(item.id)
                                                : selectedItems.add(item.id);
                                            //This rebuilds the StatefulWidget to update the button's text
                                            setState(() {});
                                            universitySearchdata.clear();
                                            locationSearchdata.clear();
                                            selecteduniversity.clear();
                                            getuniverstty();
                                            // countryid();
                                            //This rebuilds the dropdownMenu Widget to update the check mark
                                            menuSetState(() {
                                              print(selectedItems);
                                            });
                                          },
                                          child: Container(
                                            height: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Row(
                                              children: [
                                                _isSelected
                                                    ? Icon(
                                                        Icons
                                                            .check_box_outlined,
                                                        color: AppColors
                                                            .PrimaryMainColor,
                                                      )
                                                    : Icon(
                                                        Icons
                                                            .check_box_outline_blank,
                                                        color: AppColors
                                                            .PrimaryMainColor,
                                                      ),
                                                const SizedBox(width: 16),
                                                Text(
                                                  item.name,
                                                  style: batchtext2(AppColors
                                                      .PrimaryMainColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }).toList(),
                                //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                                value: selectedItems.isEmpty
                                    ? null
                                    : selectedItems.last,
                                onChanged: (value) {
                                  selectedItems.last = value!;

                                  setState(() {
                                    log("fekwjqnbkjernb;j" +
                                        selectedItems.toString());
                                  });
                                },
                                selectedItemBuilder: (context) {
                                  return countrySearchdata.map(
                                    (item) {
                                      return Container(
                                        alignment: AlignmentDirectional.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          "Selected " +
                                              selectedItems.length.toString(),
                                          style: batchtext2(
                                              AppColors.PrimaryMainColor),
                                          maxLines: 1,
                                        ),
                                      );
                                    },
                                  ).toList();
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 55,
                                  width: 450,
                                  padding: const EdgeInsets.all(10),
                                ),
                                dropdownStyleData: DropdownStyleData(
                                    isOverButton: true,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
                                        color: AppColors.backgroungcolor,
                                        border: Border.all()),
                                    maxHeight: 200.h,
                                    elevation: 10),
                                menuItemStyleData: const MenuItemStyleData(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  height: 40,
                                ),
                                iconStyleData: IconStyleData(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColors.PrimaryMainColor,
                                  ),
                                  iconSize: 30,
                                ),
                              ),
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
                            height: 5.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                isDense: true,

                                hint: Text(
                                  'Please Select University',
                                  style: batchtext2(AppColors.hintcolor),
                                ),
                                items: universitySearchdata.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item.id,
                                    //disable default onTap to avoid closing menu when selecting an item
                                    enabled: false,
                                    child: StatefulBuilder(
                                      builder: (context, menuSetState) {
                                        final _isSelected = selecteduniversity
                                            .contains(item.id);
                                        return InkWell(
                                          onTap: () {
                                            _isSelected
                                                ? selecteduniversity
                                                    .remove(item.id)
                                                : selecteduniversity
                                                    .add(item.id);
                                            //This rebuilds the StatefulWidget to update the button's text
                                            setState(() {});
                                            locationSearchdata.clear();
                                            selectedlocation.clear();
                                            getlocation();
                                            // countryid();
                                            //This rebuilds the dropdownMenu Widget to update the check mark
                                            menuSetState(() {
                                              print(selecteduniversity);
                                            });
                                          },
                                          child: Container(
                                            height: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Row(
                                              children: [
                                                _isSelected
                                                    ? Icon(
                                                        Icons
                                                            .check_box_outlined,
                                                        color: AppColors
                                                            .PrimaryMainColor,
                                                      )
                                                    : Icon(
                                                        Icons
                                                            .check_box_outline_blank,
                                                        color: AppColors
                                                            .PrimaryMainColor,
                                                      ),
                                                const SizedBox(width: 10),
                                                Flexible(
                                                  child: Text(
                                                    item.name,
                                                    maxLines: 2,
                                                    style: batchtext2(AppColors
                                                        .PrimaryMainColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }).toList(),
                                //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                                value: selecteduniversity.isEmpty
                                    ? null
                                    : selecteduniversity.last,
                                onChanged: (value) {
                                  selecteduniversity.last = value!;

                                  setState(() {
                                    log("fekwjqnbkjernb;j" +
                                        selecteduniversity.toString());
                                  });
                                },
                                selectedItemBuilder: (context) {
                                  return universitySearchdata.map(
                                    (item) {
                                      return Container(
                                        alignment: AlignmentDirectional.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          "University " +
                                              selecteduniversity.length
                                                  .toString(),
                                          style: batchtext2(
                                              AppColors.PrimaryMainColor),
                                          maxLines: 1,
                                        ),
                                      );
                                    },
                                  ).toList();
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 55,
                                  width: 450,
                                  padding: const EdgeInsets.all(10),
                                ),
                                dropdownStyleData: DropdownStyleData(
                                    isOverButton: true,
                                    scrollPadding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
                                        color: AppColors.backgroungcolor,
                                        border: Border.all()),
                                    maxHeight: 200.h,
                                    elevation: 10),
                                menuItemStyleData: const MenuItemStyleData(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  height: 40,
                                ),
                                iconStyleData: IconStyleData(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColors.PrimaryMainColor,
                                  ),
                                  iconSize: 30,
                                ),
                              ),
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
                            height: 5.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                isDense: true,

                                hint: Text(
                                  'Please Select Location',
                                  style: batchtext2(AppColors.hintcolor),
                                ),
                                items: locationSearchdata.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item.id,
                                    //disable default onTap to avoid closing menu when selecting an item
                                    enabled: false,
                                    child: StatefulBuilder(
                                      builder: (context, menuSetState) {
                                        final _isSelected =
                                            selectedlocation.contains(item.id);
                                        return InkWell(
                                          onTap: () {
                                            _isSelected
                                                ? selectedlocation
                                                    .remove(item.id)
                                                : selectedlocation.add(item.id);
                                            //This rebuilds the StatefulWidget to update the button's text
                                            setState(() {});

                                            // countryid();
                                            //This rebuilds the dropdownMenu Widget to update the check mark
                                            menuSetState(() {
                                              print(selectedlocation);
                                            });
                                          },
                                          child: Container(
                                            height: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Row(
                                              children: [
                                                _isSelected
                                                    ? Icon(
                                                        Icons
                                                            .check_box_outlined,
                                                        color: AppColors
                                                            .PrimaryMainColor,
                                                      )
                                                    : Icon(
                                                        Icons
                                                            .check_box_outline_blank,
                                                        color: AppColors
                                                            .PrimaryMainColor,
                                                      ),
                                                const SizedBox(width: 10),
                                                Flexible(
                                                  child: Text(
                                                    item.name,
                                                    maxLines: 2,
                                                    style: batchtext2(AppColors
                                                        .PrimaryMainColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }).toList(),
                                //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                                value: selectedlocation.isEmpty
                                    ? null
                                    : selectedlocation.last,
                                onChanged: (value) {
                                  selectedlocation.last = value!;

                                  setState(() {
                                    log("fekwjqnbkjernb;j" +
                                        selectedlocation.toString());
                                  });
                                },
                                selectedItemBuilder: (context) {
                                  return locationSearchdata.map(
                                    (item) {
                                      return Container(
                                        alignment: AlignmentDirectional.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          "Location " +
                                              selectedlocation.length
                                                  .toString(),
                                          style: batchtext2(
                                              AppColors.PrimaryMainColor),
                                          maxLines: 1,
                                        ),
                                      );
                                    },
                                  ).toList();
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 55,
                                  width: 450,
                                  padding: const EdgeInsets.all(10),
                                ),
                                dropdownStyleData: DropdownStyleData(
                                    isOverButton: true,
                                    scrollPadding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
                                        color: AppColors.backgroungcolor,
                                        border: Border.all()),
                                    maxHeight: 200.h,
                                    elevation: 10),
                                menuItemStyleData: const MenuItemStyleData(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  height: 40,
                                ),
                                iconStyleData: IconStyleData(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColors.PrimaryMainColor,
                                  ),
                                  iconSize: 30,
                                ),
                              ),
                            ),
                          ),

                          // Container(
                          //   decoration: BoxDecoration(
                          //       color: Colors.white,
                          //       borderRadius: BorderRadius.circular(10)),
                          //   child: DropdownButtonHideUnderline(
                          //     child: DropdownButtonFormField2(
                          //       isDense: false,
                          //       isExpanded: true,
                          //       decoration: InputDecoration(
                          //         // enabledBorder: OutlineInputBorder(
                          //         //   borderRadius: BorderRadius.circular(10),
                          //         //   // width: 0.0 produces a thin "hairline" border
                          //         //   borderSide: BorderSide(
                          //         //       color: AppColors.PrimaryMainColor, width: 1.0),
                          //         // ),
                          //         // errorBorder: new OutlineInputBorder(
                          //         //   borderRadius: BorderRadius.circular(10),
                          //         //   borderSide:
                          //         //       new BorderSide(color: Colors.red, width: 1.0),
                          //         // ),
                          //         isCollapsed: true,
                          //         border: InputBorder.none,
                          //       ),
                          //       // validator: (value) {
                          //       //   if (value == null ||
                          //       //       value.LocationName.isEmpty) {
                          //       //     return 'Please Select Branch';
                          //       //   }
                          //       //   return null;
                          //       // },
                          //       hint: locationSearchdata.isEmpty &&
                          //               dropuniversity != null
                          //           ? Text(
                          //               "No Data found",
                          //               style: batchtext2(AppColors.hintcolor),
                          //             )
                          //           : Text(
                          //               'Please select Location',
                          //               style: batchtext2(AppColors.hintcolor),
                          //             ),
                          //       items: locationSearchdata
                          //           .map((LocationSearchModel item) =>
                          //               DropdownMenuItem(
                          //                 value: item,
                          //                 child: Text(
                          //                   item.name.toString(),
                          //                   style: batchtext2(
                          //                       AppColors.PrimaryMainColor),
                          //                 ),
                          //               ))
                          //           .toList(),
                          //       value: droplocation,

                          //       onChanged: (LocationSearchModel? value) {
                          //         setState(() {
                          //           // universitySearchdata;

                          //           droplocation = value!;

                          //           log("dnjlkjne" + droplocation!.name);
                          //           isSelected = true;
                          //         });

                          //         //  selectedSecurity = value!;
                          //         // accountTypeValidate = true;
                          //       },
                          //       buttonStyleData: ButtonStyleData(
                          //         height: 55,
                          //         width: 450,
                          //         padding: const EdgeInsets.all(10),
                          //       ),
                          //       dropdownStyleData: DropdownStyleData(
                          //           isOverButton: true,
                          //           decoration: BoxDecoration(
                          //               borderRadius:
                          //                   BorderRadius.circular(10.sp),
                          //               color: AppColors.backgroungcolor,
                          //               border: Border.all()),
                          //           maxHeight: 200.h,
                          //           elevation: 10),
                          //       menuItemStyleData: const MenuItemStyleData(
                          //         padding: EdgeInsets.only(left: 10, right: 10),
                          //         height: 40,
                          //       ),
                          //       iconStyleData: IconStyleData(
                          //         icon: Icon(
                          //           Icons.keyboard_arrow_down,
                          //           color: AppColors.PrimaryMainColor,
                          //         ),
                          //         iconSize: 30,
                          //       ),
                          //     ),
                          //   ),
                          // ),

                          SizedBox(
                            height: 10.h,
                          ),
                          Text("Intake",
                              style: FieldTextStyle(
                                AppColors.PrimaryBlackColor,
                              )),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                isDense: true,

                                hint: Text(
                                  'Please Select Intake',
                                  style: batchtext2(AppColors.hintcolor),
                                ),
                                items: months.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item.id,
                                    //disable default onTap to avoid closing menu when selecting an item
                                    enabled: false,
                                    child: StatefulBuilder(
                                      builder: (context, menuSetState) {
                                        final _isSelected = selectedintake
                                            .contains(item.id.toString());
                                        return InkWell(
                                          onTap: () {
                                            _isSelected
                                                ? selectedintake.remove(item.id)
                                                : selectedintake
                                                    .add(item.id.toString());
                                            //This rebuilds the StatefulWidget to update the button's text
                                            setState(() {});

                                            // countryid();
                                            //This rebuilds the dropdownMenu Widget to update the check mark
                                            menuSetState(() {
                                              print(selectedintake);
                                            });
                                          },
                                          child: Container(
                                            height: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Row(
                                              children: [
                                                _isSelected
                                                    ? Icon(
                                                        Icons
                                                            .check_box_outlined,
                                                        color: AppColors
                                                            .PrimaryMainColor,
                                                      )
                                                    : Icon(
                                                        Icons
                                                            .check_box_outline_blank,
                                                        color: AppColors
                                                            .PrimaryMainColor,
                                                      ),
                                                const SizedBox(width: 10),
                                                Flexible(
                                                  child: Text(
                                                    item.name.toString(),
                                                    maxLines: 2,
                                                    style: batchtext2(AppColors
                                                        .PrimaryMainColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }).toList(),
                                //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                                value: selectedintake.isEmpty
                                    ? null
                                    : selectedintake.last,
                                onChanged: (value) {
                                  selectedintake.last = value!;

                                  setState(() {
                                    log("fekwjqnbkjernb;j" +
                                        selectedintake.toString());
                                  });
                                },
                                selectedItemBuilder: (context) {
                                  return months.map(
                                    (item) {
                                      return Container(
                                        alignment: AlignmentDirectional.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          "Intake " +
                                              selectedintake.length.toString(),
                                          style: batchtext2(
                                              AppColors.PrimaryMainColor),
                                          maxLines: 1,
                                        ),
                                      );
                                    },
                                  ).toList();
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 55,
                                  width: 450,
                                  padding: const EdgeInsets.all(10),
                                ),
                                dropdownStyleData: DropdownStyleData(
                                    isOverButton: true,
                                    scrollPadding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
                                        color: AppColors.backgroungcolor,
                                        border: Border.all()),
                                    maxHeight: 200.h,
                                    elevation: 10),
                                menuItemStyleData: const MenuItemStyleData(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  height: 40,
                                ),
                                iconStyleData: IconStyleData(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColors.PrimaryMainColor,
                                  ),
                                  iconSize: 30,
                                ),
                              ),
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
                            height: 5.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField2(
                                isDense: false,
                                isExpanded: true,
                                decoration: InputDecoration(
                                  // enabledBorder: OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(10),
                                  //   // width: 0.0 produces a thin "hairline" border
                                  //   borderSide: BorderSide(
                                  //       color: AppColors.PrimaryMainColor, width: 1.0),
                                  // ),
                                  // errorBorder: new OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(10),
                                  //   borderSide:
                                  //       new BorderSide(color: Colors.red, width: 1.0),
                                  // ),
                                  isCollapsed: true,
                                  border: InputBorder.none,
                                ),
                                // validator: (value) {
                                //   if (value == null ||
                                //       value.LocationName.isEmpty) {
                                //     return 'Please Select Branch';
                                //   }
                                //   return null;
                                // },
                                hint: Text(
                                  'Please select Duration',
                                  style: batchtext2(AppColors.hintcolor),
                                ),
                                items: duration
                                    .map((item) => DropdownMenuItem(
                                          value: item,
                                          child: Text(
                                            item.name.toString(),
                                            style: batchtext2(
                                                AppColors.PrimaryMainColor),
                                          ),
                                        ))
                                    .toList(),
                                value: dropduration,
                                onChanged: (value) {
                                  setState(() {
                                    dropduration = value!;
                                    isSelected = true;
                                    //  selectedSecurity = value!;
                                    // accountTypeValidate = true;
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 55,
                                  width: 450,
                                  padding: const EdgeInsets.all(10),
                                ),
                                dropdownStyleData: DropdownStyleData(
                                    isOverButton: true,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
                                        color: AppColors.backgroungcolor,
                                        border: Border.all()),
                                    maxHeight: 200.h,
                                    elevation: 10),
                                menuItemStyleData: const MenuItemStyleData(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  height: 40,
                                ),
                                iconStyleData: IconStyleData(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColors.PrimaryMainColor,
                                  ),
                                  iconSize: 30,
                                ),
                              ),
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
                            height: 5.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                isDense: true,

                                hint: Text(
                                  'Please Select Study Area',
                                  style: batchtext2(AppColors.hintcolor),
                                ),
                                items: studyareaSearchdata.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item.id.toString(),
                                    //disable default onTap to avoid closing menu when selecting an item
                                    enabled: false,
                                    child: StatefulBuilder(
                                      builder: (context, menuSetState) {
                                        final _isSelected = selectedstudyarea
                                            .contains(item.id.toString());
                                        return InkWell(
                                          onTap: () {
                                            _isSelected
                                                ? selectedstudyarea
                                                    .remove(item.id.toString())
                                                : selectedstudyarea
                                                    .add(item.id.toString());
                                            //This rebuilds the StatefulWidget to update the button's text
                                            setState(() {});
                                            getDisciplineArea();
                                            disciplineareaSearchdata.clear();
                                            selecteddisciplinearea.clear();

                                            // countryid();
                                            //This rebuilds the dropdownMenu Widget to update the check mark
                                            menuSetState(() {
                                              print(selectedstudyarea);
                                            });
                                          },
                                          child: Container(
                                            height: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Row(
                                              children: [
                                                _isSelected
                                                    ? Icon(
                                                        Icons
                                                            .check_box_outlined,
                                                        color: AppColors
                                                            .PrimaryMainColor,
                                                      )
                                                    : Icon(
                                                        Icons
                                                            .check_box_outline_blank,
                                                        color: AppColors
                                                            .PrimaryMainColor,
                                                      ),
                                                const SizedBox(width: 10),
                                                Flexible(
                                                  child: Text(
                                                    item.name.toString(),
                                                    maxLines: 2,
                                                    style: batchtext2(AppColors
                                                        .PrimaryMainColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }).toList(),
                                //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                                value: selectedstudyarea.isEmpty
                                    ? null
                                    : selectedstudyarea.last,
                                onChanged: (value) {
                                  selectedstudyarea.last = value!;

                                  setState(() {
                                    log("fekwjqnbkjernb;j" +
                                        selectedstudyarea.toString());
                                  });
                                },
                                selectedItemBuilder: (context) {
                                  return studyareaSearchdata.map(
                                    (item) {
                                      return Container(
                                        alignment: AlignmentDirectional.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          "Study Area " +
                                              selectedstudyarea.length
                                                  .toString(),
                                          style: batchtext2(
                                              AppColors.PrimaryMainColor),
                                          maxLines: 1,
                                        ),
                                      );
                                    },
                                  ).toList();
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 55,
                                  width: 450,
                                  padding: const EdgeInsets.all(10),
                                ),
                                dropdownStyleData: DropdownStyleData(
                                    isOverButton: true,
                                    scrollPadding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
                                        color: AppColors.backgroungcolor,
                                        border: Border.all()),
                                    maxHeight: 200.h,
                                    elevation: 10),
                                menuItemStyleData: const MenuItemStyleData(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  height: 40,
                                ),
                                iconStyleData: IconStyleData(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColors.PrimaryMainColor,
                                  ),
                                  iconSize: 30,
                                ),
                              ),
                            ),
                          ),

                          // Container(
                          //   decoration: BoxDecoration(
                          //       color: Colors.white,
                          //       borderRadius: BorderRadius.circular(10)),
                          //   child: DropdownButtonHideUnderline(
                          //     child: DropdownButtonFormField2(
                          //       isDense: false,
                          //       isExpanded: true,
                          //       decoration: InputDecoration(
                          //         isCollapsed: true,
                          //         border: InputBorder.none,
                          //       ),
                          //       // validator: (value) {
                          //       //   if (value == null ||
                          //       //       value.LocationName.isEmpty) {
                          //       //     return 'Please Select Branch';
                          //       //   }
                          //       //   return null;
                          //       // },
                          //       hint: Text(
                          //         'Please select Study Area',
                          //         style: batchtext2(AppColors.hintcolor),
                          //       ),
                          //       items: studyareaSearchdata
                          //           .map((item) => DropdownMenuItem(
                          //                 value: item,
                          //                 child: Text(
                          //                   item.name,
                          //                   style: batchtext2(
                          //                       AppColors.PrimaryMainColor),
                          //                 ),
                          //               ))
                          //           .toList(),
                          //       value: dropstudyarea,
                          //       onChanged: (value) {
                          //         setState(() {
                          //           dropstudyarea = value!;
                          //           isSelected = true;
                          //           //  selectedSecurity = value!;
                          //           // accountTypeValidate = true;
                          //         });
                          //       },
                          //       buttonStyleData: ButtonStyleData(
                          //         height: 55,
                          //         width: 450,
                          //         padding: const EdgeInsets.all(10),
                          //       ),
                          //       dropdownStyleData: DropdownStyleData(
                          //           isOverButton: true,
                          //           decoration: BoxDecoration(
                          //               borderRadius:
                          //                   BorderRadius.circular(10.sp),
                          //               color: AppColors.backgroungcolor,
                          //               border: Border.all()),
                          //           maxHeight: 220.h,
                          //           elevation: 10),
                          //       menuItemStyleData: const MenuItemStyleData(
                          //         padding: EdgeInsets.only(left: 10, right: 10),
                          //         height: 40,
                          //       ),
                          //       iconStyleData: IconStyleData(
                          //         icon: Icon(
                          //           Icons.keyboard_arrow_down,
                          //           color: AppColors.PrimaryMainColor,
                          //         ),
                          //         iconSize: 30,
                          //       ),
                          //     ),
                          //   ),
                          // ),

                          SizedBox(
                            height: 10.h,
                          ),
                          Text("Discipline Area",
                              style: FieldTextStyle(
                                AppColors.PrimaryBlackColor,
                              )),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                isDense: true,

                                hint: Text(
                                  'Please Select Discipline Area',
                                  style: batchtext2(AppColors.hintcolor),
                                ),
                                items: disciplineareaSearchdata.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item.id.toString(),
                                    //disable default onTap to avoid closing menu when selecting an item
                                    enabled: false,
                                    child: StatefulBuilder(
                                      builder: (context, menuSetState) {
                                        final _isSelected =
                                            selecteddisciplinearea
                                                .contains(item.id);
                                        return InkWell(
                                          onTap: () {
                                            _isSelected
                                                ? selecteddisciplinearea
                                                    .remove(item.id)
                                                : selecteddisciplinearea
                                                    .add(item.id);
                                            //This rebuilds the StatefulWidget to update the button's text
                                            setState(() {});
                                            log("fekwjqnbkjernb;j" +
                                                selecteddisciplinearea
                                                    .toString());
                                            // countryid();
                                            //This rebuilds the dropdownMenu Widget to update the check mark
                                            menuSetState(() {
                                              print(selecteddisciplinearea);
                                            });
                                          },
                                          child: Container(
                                            height: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Row(
                                              children: [
                                                _isSelected
                                                    ? Icon(
                                                        Icons
                                                            .check_box_outlined,
                                                        color: AppColors
                                                            .PrimaryMainColor,
                                                      )
                                                    : Icon(
                                                        Icons
                                                            .check_box_outline_blank,
                                                        color: AppColors
                                                            .PrimaryMainColor,
                                                      ),
                                                const SizedBox(width: 10),
                                                Flexible(
                                                  child: Text(
                                                    item.name.toString(),
                                                    maxLines: 2,
                                                    style: batchtext2(AppColors
                                                        .PrimaryMainColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }).toList(),
                                //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                                value: selecteddisciplinearea.isEmpty
                                    ? null
                                    : selecteddisciplinearea.last,
                                onChanged: (value) {
                                  selecteddisciplinearea.last = value!;

                                  setState(() {});
                                },
                                selectedItemBuilder: (context) {
                                  return disciplineareaSearchdata.map(
                                    (item) {
                                      return Container(
                                        alignment: AlignmentDirectional.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          "Discipline Area " +
                                              selecteddisciplinearea.length
                                                  .toString(),
                                          style: batchtext2(
                                              AppColors.PrimaryMainColor),
                                          maxLines: 1,
                                        ),
                                      );
                                    },
                                  ).toList();
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 55,
                                  width: 450,
                                  padding: const EdgeInsets.all(10),
                                ),
                                dropdownStyleData: DropdownStyleData(
                                    isOverButton: true,
                                    scrollPadding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
                                        color: AppColors.backgroungcolor,
                                        border: Border.all()),
                                    maxHeight: 200.h,
                                    elevation: 10),
                                menuItemStyleData: const MenuItemStyleData(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  height: 40,
                                ),
                                iconStyleData: IconStyleData(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColors.PrimaryMainColor,
                                  ),
                                  iconSize: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  StatefulBuilder(
                    builder: (BuildContext context, setState1) {
                      return requireSelect(1, setState1);
                    },
                  ),
                  StatefulBuilder(
                    builder: (BuildContext context, setState1) {
                      return optionSelect(1, setState1);
                    },
                  ),

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
                    searchFilter();
                  },
                  label: const Text("Search")),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}

class ItemModel {
  String label;
  Color color;
  bool isSelected;

  ItemModel(this.label, this.color, this.isSelected);
}
