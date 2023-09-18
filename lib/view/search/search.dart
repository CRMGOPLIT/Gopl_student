import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/bloc/searchBloc.dart';
import 'package:global_student/model/countrySearchModel.dart';
import 'package:global_student/model/disciplinearea.dart';
import 'package:global_student/model/filtersearch.dart';
import 'package:global_student/model/locationsearchmodel.dart';
import 'package:global_student/model/monthModel.dart';
import 'package:global_student/model/studyareaModel.dart';
import 'package:global_student/networking/networkConstant.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/course_details/course_details.dart';
import 'package:global_student/view/helper/apiResponseHelper.dart';
import 'package:global_student/view/widget/loader.dart';
import '../../model/universitySearchModel.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  late SearchBloc searchBloc;
  List<ObjCourse> objCourse = [];
  bool isloadingmore = false;
  bool showloader = true;
  int page = 1;
  bool loading = true;
  bool hasmore = true;
  bool imgshow = true;

  final scrollController = ScrollController();
  final _filtersearch = GlobalKey<FormState>();

  @override
  void initState() {
    searchBloc = SearchBloc();
    getBranchDetails();
    scrollController.addListener(_scrollListener);
    getdata();
    showYear();
    getSearchCountry();
    super.initState();
  }

  getBranchDetails() async {
    searchBloc.getfiltersearchStream.listen((event) {
      showloader ? Navigator.pop(context) : "";
      bool response =
          ApiResponseHelper().handleResponse(event: event, context: context);
      if (response == true) {
        FilterSeach filterSeach = FilterSeach.fromJson(event.data);
        if (filterSeach.objCourse.isNotEmpty) {
          objCourse.addAll(filterSeach.objCourse);
        } else {
          setState(() {
            hasmore = false;
          });
        }
      }
      if (objCourse.isEmpty) {
        hasmore = false;
      }
      isloadingmore = false;
      setState(() {
        loading = false;
        showloader = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: AppColors.PrimaryMainColor,
          elevation: 0,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(0),
                bottomLeft: Radius.circular(0)),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesName.courseSearch,
                (routes) => false,
              );
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColors.PrimaryWhiteColor,
              size: 20.sp,
            ),
          ),
          title: Text(
            "Search ",
            style: btntext(AppColors.PrimaryWhiteColor),
          ),
        ),
      ),
      body: Form(
        key: _filtersearch,
        child: Column(
          children: [
            ExpansionTileCard(
              borderRadius: const BorderRadius.all(Radius.circular(0.0)),
              expandedColor: AppColors.backgroungcolor,
              baseColor: AppColors.PrimaryMainColor,
              key: cardA,
              trailing: Container(
                height: 40.h,
                width: 60.w,
                decoration: BoxDecoration(
                    color: AppColors.PrimaryWhiteColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.r),
                        bottomRight: Radius.circular(10.r))),
                child: Icon(
                  Icons.filter_alt,
                  color: AppColors.PrimaryMainColor,
                  size: 30.sp,
                ),
              ),
              title: Container(
                height: 40.h,
                width: 250.w,
                decoration: BoxDecoration(
                    color: AppColors.PrimaryWhiteColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        bottomLeft: Radius.circular(10.r))),
                child: Center(
                  child: Text(
                    "Filter Your Search ",
                    style: batchtext2(AppColors.hintcolor),
                  ),
                ),
              ),
              children: <Widget>[
                const Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: screenSize.height * 0.7,
                    child: DefaultTabController(
                        length: 3,
                        initialIndex: 0,
                        child: StatefulBuilder(
                          builder: (BuildContext context, setState1) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Container(
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: TabBar(
                                    isScrollable: true,
                                    labelColor: AppColors.PrimaryWhiteColor,
                                    indicatorColor: AppColors.PrimaryBlackColor,
                                    unselectedLabelColor:
                                        AppColors.PrimaryMainColor,
                                    padding: EdgeInsets.only(
                                        left: 10.r, right: 10.r, bottom: 10.r),
                                    indicator: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50).r,
                                        color: AppColors.PrimaryMainColor),
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
                                Expanded(
                                  child: TabBarView(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(15.sp),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButtonFormField2(
                                                    isDense: false,
                                                    isExpanded: true,
                                                    decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: AppColors
                                                                    .hintcolor,
                                                                width: 1.0),
                                                      ),
                                                      isCollapsed: true,
                                                      border: InputBorder.none,
                                                    ),
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return 'Please Select year';
                                                      }
                                                      return null;
                                                    },
                                                    hint: Text(
                                                      'Year',
                                                      style: batchtext2(
                                                          AppColors.hintcolor),
                                                    ),
                                                    items: yearList
                                                        .map((item) =>
                                                            DropdownMenuItem(
                                                              value: item,
                                                              child: Text(
                                                                item.toString(),
                                                                style: batchtext2(
                                                                    AppColors
                                                                        .PrimaryMainColor),
                                                              ),
                                                            ))
                                                        .toList(
                                                            growable: false),
                                                    value: yeardrop,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        yeardrop =
                                                            value as int?;
                                                        isSelected = true;
                                                      });
                                                    },
                                                    buttonStyleData:
                                                        ButtonStyleData(
                                                      height: 55.h,
                                                      padding:
                                                          EdgeInsets.all(10.r),
                                                    ),
                                                    dropdownStyleData: DropdownStyleData(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.sp),
                                                            color: AppColors
                                                                .backgroungcolor,
                                                            border:
                                                                Border.all()),
                                                        maxHeight: 300.h,
                                                        elevation: 10),
                                                    menuItemStyleData:
                                                        MenuItemStyleData(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              right: 10),
                                                      height: 40.h,
                                                    ),
                                                    onMenuStateChange:
                                                        (isOpen) {
                                                      if (isOpen) {
                                                        textEditingController
                                                            .clear();
                                                      }
                                                    },
                                                    iconStyleData:
                                                        const IconStyleData(
                                                      icon: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: AppColors
                                                            .PrimaryMainColor,
                                                      ),
                                                      iconSize: 30,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButtonFormField2(
                                                    isDense: false,
                                                    isExpanded: true,
                                                    decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: AppColors
                                                                    .hintcolor,
                                                                width: 1.0),
                                                      ),
                                                      isCollapsed: true,
                                                      border: InputBorder.none,
                                                    ),
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return 'Please Select country';
                                                      }
                                                      return null;
                                                    },
                                                    hint: Text(
                                                      'Please Select Country',
                                                      style: batchtext2(
                                                          AppColors.hintcolor),
                                                    ),
                                                    items: countrySearchdata
                                                        .map((item) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: item.id,
                                                        enabled: false,
                                                        child: StatefulBuilder(
                                                          builder: (context,
                                                              menuSetState) {
                                                            final isSelected =
                                                                selectedItems
                                                                    .contains(
                                                                        item.id);
                                                            return InkWell(
                                                              onTap: () {
                                                                isSelected
                                                                    ? selectedItems
                                                                        .remove(item
                                                                            .id)
                                                                    : selectedItems
                                                                        .add(item
                                                                            .id);

                                                                setState(() {});
                                                                universitySearchdata
                                                                    .clear();
                                                                locationSearchdata
                                                                    .clear();
                                                                selecteduniversity
                                                                    .clear();
                                                                getuniverstty();
                                                                menuSetState(
                                                                    () {});
                                                              },
                                                              child: Container(
                                                                height: double
                                                                    .infinity,
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16.0),
                                                                child: Row(
                                                                  children: [
                                                                    isSelected
                                                                        ? const Icon(
                                                                            Icons.check_box_outlined,
                                                                            color:
                                                                                AppColors.PrimaryMainColor,
                                                                          )
                                                                        : const Icon(
                                                                            Icons.check_box_outline_blank,
                                                                            color:
                                                                                AppColors.PrimaryMainColor,
                                                                          ),
                                                                    const SizedBox(
                                                                        width:
                                                                            16),
                                                                    Text(
                                                                      item.name,
                                                                      style: batchtext2(
                                                                          AppColors
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
                                                    value: selectedItems.isEmpty
                                                        ? null
                                                        : selectedItems.last,
                                                    onChanged: (value) {
                                                      selectedItems.last =
                                                          value!;

                                                      setState(() {});
                                                    },
                                                    selectedItemBuilder:
                                                        (context) {
                                                      return countrySearchdata
                                                          .map(
                                                        (item) {
                                                          return Container(
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .center,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16.0),
                                                            child: Text(
                                                              "Selected ${selectedItems.length}",
                                                              style: batchtext2(
                                                                  AppColors
                                                                      .PrimaryMainColor),
                                                              maxLines: 1,
                                                            ),
                                                          );
                                                        },
                                                      ).toList();
                                                    },
                                                    buttonStyleData:
                                                        ButtonStyleData(
                                                      height: 55.h,
                                                      width: 450,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                    ),
                                                    dropdownStyleData: DropdownStyleData(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.sp),
                                                            color: AppColors
                                                                .backgroungcolor,
                                                            border:
                                                                Border.all()),
                                                        maxHeight: 300.h,
                                                        elevation: 10),
                                                    menuItemStyleData:
                                                        const MenuItemStyleData(
                                                      padding: EdgeInsets.only(
                                                          left: 10, right: 10),
                                                      height: 40,
                                                    ),
                                                    iconStyleData:
                                                        const IconStyleData(
                                                      icon: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: AppColors
                                                            .PrimaryMainColor,
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButtonFormField2(
                                                    decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: AppColors
                                                                    .hintcolor,
                                                                width: 1.0),
                                                      ),
                                                      isCollapsed: true,
                                                      border: InputBorder.none,
                                                    ),
                                                    isExpanded: true,
                                                    isDense: true,
                                                    hint: Text(
                                                      'Please Select University',
                                                      style: batchtext2(
                                                          AppColors.hintcolor),
                                                    ),
                                                    items: universitySearchdata
                                                        .map((item) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: item.id,
                                                        enabled: false,
                                                        child: StatefulBuilder(
                                                          builder: (context,
                                                              menuSetState) {
                                                            final isSelected0 =
                                                                selecteduniversity
                                                                    .contains(
                                                                        item.id);
                                                            return InkWell(
                                                              onTap: () {
                                                                isSelected0
                                                                    ? selecteduniversity
                                                                        .remove(item
                                                                            .id)
                                                                    : selecteduniversity
                                                                        .add(item
                                                                            .id);

                                                                setState(() {});
                                                                locationSearchdata
                                                                    .clear();
                                                                selectedlocation
                                                                    .clear();
                                                                getlocation();
                                                                menuSetState(
                                                                    () {});
                                                              },
                                                              child: Container(
                                                                height: double
                                                                    .infinity,
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16.0),
                                                                child: Row(
                                                                  children: [
                                                                    isSelected0
                                                                        ? const Icon(
                                                                            Icons.check_box_outlined,
                                                                            color:
                                                                                AppColors.PrimaryMainColor,
                                                                          )
                                                                        : const Icon(
                                                                            Icons.check_box_outline_blank,
                                                                            color:
                                                                                AppColors.PrimaryMainColor,
                                                                          ),
                                                                    const SizedBox(
                                                                        width:
                                                                            10),
                                                                    Flexible(
                                                                      child:
                                                                          Text(
                                                                        item.name,
                                                                        maxLines:
                                                                            2,
                                                                        style: batchtext2(
                                                                            AppColors.PrimaryMainColor),
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
                                                    value: selecteduniversity
                                                            .isEmpty
                                                        ? null
                                                        : selecteduniversity
                                                            .last,
                                                    onChanged: (value) {
                                                      selecteduniversity.last =
                                                          value!;

                                                      setState(() {});
                                                    },
                                                    selectedItemBuilder:
                                                        (context) {
                                                      return universitySearchdata
                                                          .map(
                                                        (item) {
                                                          return Container(
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .center,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16.0),
                                                            child: Text(
                                                              "University ${selecteduniversity.length}",
                                                              style: batchtext2(
                                                                  AppColors
                                                                      .PrimaryMainColor),
                                                              maxLines: 1,
                                                            ),
                                                          );
                                                        },
                                                      ).toList();
                                                    },
                                                    buttonStyleData:
                                                        ButtonStyleData(
                                                      height: 55.h,
                                                      width: 450,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                    ),
                                                    dropdownStyleData: DropdownStyleData(
                                                        isOverButton: true,
                                                        scrollPadding:
                                                            const EdgeInsets
                                                                    .all(10)
                                                                .w,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.sp),
                                                            color: AppColors
                                                                .backgroungcolor,
                                                            border:
                                                                Border.all()),
                                                        maxHeight: 200.h,
                                                        elevation: 10),
                                                    menuItemStyleData:
                                                        const MenuItemStyleData(
                                                      padding: EdgeInsets.only(
                                                          left: 10, right: 10),
                                                      height: 40,
                                                    ),
                                                    iconStyleData:
                                                        const IconStyleData(
                                                      icon: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: AppColors
                                                            .PrimaryMainColor,
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButtonFormField2(
                                                    decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: AppColors
                                                                    .hintcolor,
                                                                width: 1.0),
                                                      ),
                                                      isCollapsed: true,
                                                      border: InputBorder.none,
                                                    ),
                                                    isExpanded: true,
                                                    isDense: true,
                                                    hint: Text(
                                                      'Please Select Location',
                                                      style: batchtext2(
                                                          AppColors.hintcolor),
                                                    ),
                                                    items: locationSearchdata
                                                        .map((item) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: item.id,
                                                        enabled: false,
                                                        child: StatefulBuilder(
                                                          builder: (context,
                                                              menuSetState) {
                                                            final isSelected1 =
                                                                selectedlocation
                                                                    .contains(
                                                                        item.id);
                                                            return InkWell(
                                                              onTap: () {
                                                                isSelected1
                                                                    ? selectedlocation
                                                                        .remove(item
                                                                            .id)
                                                                    : selectedlocation
                                                                        .add(item
                                                                            .id);

                                                                setState(() {});

                                                                // countryid();
                                                                //This rebuilds the dropdownMenu Widget to update the check mark
                                                                menuSetState(
                                                                    () {});
                                                              },
                                                              child: Container(
                                                                height: double
                                                                    .infinity,
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16.0),
                                                                child: Row(
                                                                  children: [
                                                                    isSelected1
                                                                        ? const Icon(
                                                                            Icons.check_box_outlined,
                                                                            color:
                                                                                AppColors.PrimaryMainColor,
                                                                          )
                                                                        : const Icon(
                                                                            Icons.check_box_outline_blank,
                                                                            color:
                                                                                AppColors.PrimaryMainColor,
                                                                          ),
                                                                    const SizedBox(
                                                                        width:
                                                                            10),
                                                                    Flexible(
                                                                      child:
                                                                          Text(
                                                                        item.name,
                                                                        maxLines:
                                                                            2,
                                                                        style: batchtext2(
                                                                            AppColors.PrimaryMainColor),
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
                                                    value: selectedlocation
                                                            .isEmpty
                                                        ? null
                                                        : selectedlocation.last,
                                                    onChanged: (value) {
                                                      selectedlocation.last =
                                                          value!;

                                                      setState(() {});
                                                    },
                                                    selectedItemBuilder:
                                                        (context) {
                                                      return locationSearchdata
                                                          .map(
                                                        (item) {
                                                          return Container(
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .center,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16.0),
                                                            child: Text(
                                                              "Location ${selectedlocation.length}",
                                                              style: batchtext2(
                                                                  AppColors
                                                                      .PrimaryMainColor),
                                                              maxLines: 1,
                                                            ),
                                                          );
                                                        },
                                                      ).toList();
                                                    },
                                                    buttonStyleData:
                                                        ButtonStyleData(
                                                      height: 55.h,
                                                      width: 450,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                    ),
                                                    dropdownStyleData: DropdownStyleData(
                                                        isOverButton: true,
                                                        scrollPadding:
                                                            const EdgeInsets
                                                                    .all(10)
                                                                .w,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.sp),
                                                            color: AppColors
                                                                .backgroungcolor,
                                                            border:
                                                                Border.all()),
                                                        maxHeight: 200.h,
                                                        elevation: 10),
                                                    menuItemStyleData:
                                                        const MenuItemStyleData(
                                                      padding: EdgeInsets.only(
                                                          left: 10, right: 10),
                                                      height: 40,
                                                    ),
                                                    iconStyleData:
                                                        const IconStyleData(
                                                      icon: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: AppColors
                                                            .PrimaryMainColor,
                                                      ),
                                                      iconSize: 30,
                                                    ),
                                                  ),
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
                                                height: 5.h,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButtonFormField2(
                                                    decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: AppColors
                                                                    .hintcolor,
                                                                width: 1.0),
                                                      ),
                                                      isCollapsed: true,
                                                      border: InputBorder.none,
                                                    ),
                                                    isExpanded: true,
                                                    isDense: true,
                                                    hint: Text(
                                                      'Please Select Intake',
                                                      style: batchtext2(
                                                          AppColors.hintcolor),
                                                    ),
                                                    items: months.map((item) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: item.id,
                                                        enabled: false,
                                                        child: StatefulBuilder(
                                                          builder: (context,
                                                              menuSetState) {
                                                            final isSelected2 =
                                                                selectedintake
                                                                    .contains(item
                                                                        .id
                                                                        .toString());
                                                            return InkWell(
                                                              onTap: () {
                                                                isSelected2
                                                                    ? selectedintake
                                                                        .remove(item
                                                                            .id)
                                                                    : selectedintake
                                                                        .add(item
                                                                            .id
                                                                            .toString());

                                                                setState(() {});
                                                                menuSetState(
                                                                    () {});
                                                              },
                                                              child: Container(
                                                                height: double
                                                                    .infinity,
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16.0),
                                                                child: Row(
                                                                  children: [
                                                                    isSelected2
                                                                        ? const Icon(
                                                                            Icons.check_box_outlined,
                                                                            color:
                                                                                AppColors.PrimaryMainColor,
                                                                          )
                                                                        : const Icon(
                                                                            Icons.check_box_outline_blank,
                                                                            color:
                                                                                AppColors.PrimaryMainColor,
                                                                          ),
                                                                    const SizedBox(
                                                                        width:
                                                                            10),
                                                                    Flexible(
                                                                      child:
                                                                          Text(
                                                                        item.name
                                                                            .toString(),
                                                                        maxLines:
                                                                            2,
                                                                        style: batchtext2(
                                                                            AppColors.PrimaryMainColor),
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
                                                    value: selectedintake
                                                            .isEmpty
                                                        ? null
                                                        : selectedintake.last,
                                                    onChanged: (value) {
                                                      selectedintake.last =
                                                          value!;

                                                      setState(() {});
                                                    },
                                                    selectedItemBuilder:
                                                        (context) {
                                                      return months.map(
                                                        (item) {
                                                          return Container(
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .center,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16.0),
                                                            child: Text(
                                                              "Intake ${selectedintake.length}",
                                                              style: batchtext2(
                                                                  AppColors
                                                                      .PrimaryMainColor),
                                                              maxLines: 1,
                                                            ),
                                                          );
                                                        },
                                                      ).toList();
                                                    },
                                                    buttonStyleData:
                                                        ButtonStyleData(
                                                      height: 55.h,
                                                      width: 450.w,
                                                      padding:
                                                          EdgeInsets.all(10.r),
                                                    ),
                                                    dropdownStyleData: DropdownStyleData(
                                                        isOverButton: true,
                                                        scrollPadding:
                                                            const EdgeInsets
                                                                    .all(10)
                                                                .w,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.sp),
                                                            color: AppColors
                                                                .backgroungcolor,
                                                            border:
                                                                Border.all()),
                                                        maxHeight: 200.h,
                                                        elevation: 10),
                                                    menuItemStyleData:
                                                        MenuItemStyleData(
                                                      padding:
                                                          const EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10)
                                                              .r,
                                                      height: 40.h,
                                                    ),
                                                    iconStyleData:
                                                        const IconStyleData(
                                                      icon: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: AppColors
                                                            .PrimaryMainColor,
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButtonFormField2(
                                                    isDense: false,
                                                    isExpanded: true,
                                                    decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: AppColors
                                                                    .hintcolor,
                                                                width: 1.0),
                                                      ),
                                                      isCollapsed: true,
                                                      border: InputBorder.none,
                                                    ),
                                                    hint: Text(
                                                      'Please select Duration',
                                                      style: batchtext2(
                                                          AppColors.hintcolor),
                                                    ),
                                                    items: duration
                                                        .map((item) =>
                                                            DropdownMenuItem(
                                                              value: item,
                                                              child: Text(
                                                                item.name
                                                                    .toString(),
                                                                style: batchtext2(
                                                                    AppColors
                                                                        .PrimaryMainColor),
                                                              ),
                                                            ))
                                                        .toList(),
                                                    value: dropduration,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        dropduration = value!;
                                                        isSelected = true;
                                                      });
                                                    },
                                                    buttonStyleData:
                                                        ButtonStyleData(
                                                      height: 55.h,
                                                      width: 450.w,
                                                      padding:
                                                          EdgeInsets.all(10.r),
                                                    ),
                                                    dropdownStyleData: DropdownStyleData(
                                                        isOverButton: true,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.sp),
                                                            color: AppColors
                                                                .backgroungcolor,
                                                            border:
                                                                Border.all()),
                                                        maxHeight: 200.h,
                                                        elevation: 10),
                                                    menuItemStyleData:
                                                        MenuItemStyleData(
                                                      padding:
                                                          const EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10)
                                                              .r,
                                                      height: 40.h,
                                                    ),
                                                    iconStyleData:
                                                        const IconStyleData(
                                                      icon: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: AppColors
                                                            .PrimaryMainColor,
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r)),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButtonFormField2(
                                                    decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: AppColors
                                                                    .hintcolor,
                                                                width: 1.0),
                                                      ),
                                                      isCollapsed: true,
                                                      border: InputBorder.none,
                                                    ),
                                                    isExpanded: true,
                                                    isDense: true,
                                                    hint: Text(
                                                      'Please Select Study Area',
                                                      style: batchtext2(
                                                          AppColors.hintcolor),
                                                    ),
                                                    items: studyareaSearchdata
                                                        .map((item) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value:
                                                            item.id.toString(),
                                                        enabled: false,
                                                        child: StatefulBuilder(
                                                          builder: (context,
                                                              menuSetState) {
                                                            final isSelected3 =
                                                                selectedstudyarea
                                                                    .contains(item
                                                                        .id
                                                                        .toString());
                                                            return InkWell(
                                                              onTap: () {
                                                                isSelected3
                                                                    ? selectedstudyarea
                                                                        .remove(item
                                                                            .id
                                                                            .toString())
                                                                    : selectedstudyarea
                                                                        .add(item
                                                                            .id
                                                                            .toString());

                                                                setState(() {});
                                                                getDisciplineArea();
                                                                disciplineareaSearchdata
                                                                    .clear();
                                                                selecteddisciplinearea
                                                                    .clear();

                                                                menuSetState(
                                                                    () {});
                                                              },
                                                              child: Container(
                                                                height: double
                                                                    .infinity,
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16.0),
                                                                child: Row(
                                                                  children: [
                                                                    isSelected3
                                                                        ? const Icon(
                                                                            Icons.check_box_outlined,
                                                                            color:
                                                                                AppColors.PrimaryMainColor,
                                                                          )
                                                                        : const Icon(
                                                                            Icons.check_box_outline_blank,
                                                                            color:
                                                                                AppColors.PrimaryMainColor,
                                                                          ),
                                                                    const SizedBox(
                                                                        width:
                                                                            10),
                                                                    Flexible(
                                                                      child:
                                                                          Text(
                                                                        item.name
                                                                            .toString(),
                                                                        maxLines:
                                                                            2,
                                                                        style: batchtext2(
                                                                            AppColors.PrimaryMainColor),
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
                                                    value: selectedstudyarea
                                                            .isEmpty
                                                        ? null
                                                        : selectedstudyarea
                                                            .last,
                                                    onChanged: (value) {
                                                      selectedstudyarea.last =
                                                          value!;

                                                      setState(() {});
                                                    },
                                                    selectedItemBuilder:
                                                        (context) {
                                                      return studyareaSearchdata
                                                          .map(
                                                        (item) {
                                                          return Container(
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .center,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16.0),
                                                            child: Text(
                                                              "Study Area ${selectedstudyarea.length}",
                                                              style: batchtext2(
                                                                  AppColors
                                                                      .PrimaryMainColor),
                                                              maxLines: 1,
                                                            ),
                                                          );
                                                        },
                                                      ).toList();
                                                    },
                                                    buttonStyleData:
                                                        ButtonStyleData(
                                                      height: 55.h,
                                                      width: 450.w,
                                                      padding:
                                                          EdgeInsets.all(10.r),
                                                    ),
                                                    dropdownStyleData: DropdownStyleData(
                                                        isOverButton: true,
                                                        scrollPadding:
                                                            const EdgeInsets
                                                                    .all(10)
                                                                .w,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.sp),
                                                            color: AppColors
                                                                .backgroungcolor,
                                                            border:
                                                                Border.all()),
                                                        maxHeight: 200.h,
                                                        elevation: 10),
                                                    menuItemStyleData:
                                                        const MenuItemStyleData(
                                                      padding: EdgeInsets.only(
                                                          left: 10, right: 10),
                                                      height: 40,
                                                    ),
                                                    iconStyleData:
                                                        const IconStyleData(
                                                      icon: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: AppColors
                                                            .PrimaryMainColor,
                                                      ),
                                                      iconSize: 30,
                                                    ),
                                                  ),
                                                ),
                                              ),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButtonFormField2(
                                                    decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: AppColors
                                                                    .hintcolor,
                                                                width: 1.0),
                                                      ),
                                                      isCollapsed: true,
                                                      border: InputBorder.none,
                                                    ),
                                                    isExpanded: true,
                                                    isDense: true,
                                                    hint: Text(
                                                      'Please Select Discipline Area',
                                                      style: batchtext2(
                                                          AppColors.hintcolor),
                                                    ),
                                                    items:
                                                        disciplineareaSearchdata
                                                            .map((item) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value:
                                                            item.id.toString(),
                                                        enabled: false,
                                                        child: StatefulBuilder(
                                                          builder: (context,
                                                              menuSetState) {
                                                            final isSelected4 =
                                                                selecteddisciplinearea
                                                                    .contains(
                                                                        item.id);
                                                            return InkWell(
                                                              onTap: () {
                                                                isSelected4
                                                                    ? selecteddisciplinearea
                                                                        .remove(item
                                                                            .id)
                                                                    : selecteddisciplinearea
                                                                        .add(item
                                                                            .id);

                                                                setState(() {});

                                                                menuSetState(
                                                                    () {});
                                                              },
                                                              child: Container(
                                                                height: double
                                                                    .infinity,
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16.0),
                                                                child: Row(
                                                                  children: [
                                                                    isSelected4
                                                                        ? const Icon(
                                                                            Icons.check_box_outlined,
                                                                            color:
                                                                                AppColors.PrimaryMainColor,
                                                                          )
                                                                        : const Icon(
                                                                            Icons.check_box_outline_blank,
                                                                            color:
                                                                                AppColors.PrimaryMainColor,
                                                                          ),
                                                                    SizedBox(
                                                                        width: 10
                                                                            .w),
                                                                    Flexible(
                                                                      child:
                                                                          Text(
                                                                        item.name
                                                                            .toString(),
                                                                        maxLines:
                                                                            2,
                                                                        style: batchtext2(
                                                                            AppColors.PrimaryMainColor),
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
                                                    value: selecteddisciplinearea
                                                            .isEmpty
                                                        ? null
                                                        : selecteddisciplinearea
                                                            .last,
                                                    onChanged: (value) {
                                                      selecteddisciplinearea
                                                          .last = value!;

                                                      setState(() {});
                                                    },
                                                    selectedItemBuilder:
                                                        (context) {
                                                      return disciplineareaSearchdata
                                                          .map(
                                                        (item) {
                                                          return Container(
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .center,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16.0),
                                                            child: Text(
                                                              "Discipline Area ${selecteddisciplinearea.length}",
                                                              style: batchtext2(
                                                                  AppColors
                                                                      .PrimaryMainColor),
                                                              maxLines: 1,
                                                            ),
                                                          );
                                                        },
                                                      ).toList();
                                                    },
                                                    buttonStyleData:
                                                        ButtonStyleData(
                                                      height: 55.h,
                                                      width: 450.w,
                                                      padding:
                                                          EdgeInsets.all(10.r),
                                                    ),
                                                    dropdownStyleData: DropdownStyleData(
                                                        isOverButton: true,
                                                        scrollPadding:
                                                            const EdgeInsets
                                                                    .all(10)
                                                                .w,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.sp),
                                                            color: AppColors
                                                                .backgroungcolor,
                                                            border:
                                                                Border.all()),
                                                        maxHeight: 200.h,
                                                        elevation: 10),
                                                    menuItemStyleData:
                                                        MenuItemStyleData(
                                                      padding:
                                                          const EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10)
                                                              .r,
                                                      height: 40.h,
                                                    ),
                                                    iconStyleData:
                                                        const IconStyleData(
                                                      icon: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: AppColors
                                                            .PrimaryMainColor,
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
                                        builder:
                                            (BuildContext context, setState1) {
                                          return requireSelect(1, setState1);
                                        },
                                      ),
                                      StatefulBuilder(
                                        builder:
                                            (BuildContext context, setState1) {
                                          return optionSelect(1, setState1);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                ButtonBar(
                                  alignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    TextButton(
                                        style: flatButtonStyle,
                                        onPressed: () {
                                          cardA.currentState?.collapse();
                                          setState(
                                            () {
                                              hasmore = true;
                                              objCourse.clear();
                                              showloader = true;
                                            },
                                          );
                                          if (_filtersearch.currentState!
                                              .validate()) {
                                            searchFilter();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                "Please select year and Country",
                                                style: batchtext2(AppColors
                                                    .PrimaryWhiteColor),
                                              ),
                                            ));
                                          }
                                        },
                                        child: Container(
                                            height: 40.h,
                                            width: 100.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.sp),
                                                color:
                                                    AppColors.PrimaryMainColor),
                                            child: Center(
                                              child: Text(
                                                "Search",
                                                style: batchtext2(AppColors
                                                    .PrimaryWhiteColor),
                                              ),
                                            ))),
                                  ],
                                ),
                              ],
                            );
                          },
                        )),
                  ),
                ),
                const ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  buttonHeight: 52.0,
                  buttonMinWidth: 90.0,
                  children: <Widget>[],
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  controller: scrollController,
                  itemCount: hasmore ? objCourse.length : objCourse.length + 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index < objCourse.length) {
                      return InkWell(
                        onTap: () {
                          Get.to(
                            () => const CourseDetails(),
                            arguments: [
                              objCourse[index].fCourseDetailId,
                            ],
                          );
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
                                children: [
                                  ListTile(
                                      title: Text(
                                          objCourse[index].fProgram.toString(),
                                          style: batchtext2(
                                              AppColors.PrimaryMainColor)),
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
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                child: Image.network(
                                                  objCourse[index]
                                                      .logo
                                                      .toString(),
                                                  loadingBuilder: (context,
                                                          child,
                                                          loadingProgress) =>
                                                      (loadingProgress ==
                                                                  null ||
                                                              objCourse[index]
                                                                      .logo
                                                                      .toString() ==
                                                                  "")
                                                          ? child
                                                          : CircularProgressIndicator(
                                                              strokeWidth: 2.w,
                                                              color: AppColors
                                                                  .PrimaryMainColor,
                                                            ),
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Container(
                                                    height: 40.h,
                                                    width: 40.w,
                                                    color: AppColors
                                                        .PrimaryWhiteColor,
                                                    child: Center(
                                                      child: Image.asset(
                                                        "assets/images/uicon1.png",
                                                        height: 40.h,
                                                        width: 40.w,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  height: 40.h,
                                                  width: 40.w,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              SizedBox(
                                                width: screenSize.width * 0.6,
                                                child: Text(
                                                  objCourse[index]
                                                      .fUniversity
                                                      .toString(),
                                                  maxLines: 1,
                                                  style: batchtext2(AppColors
                                                      .PrimaryBlackColor),
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
                                                width: 90.w,
                                                child: Text(
                                                  objCourse[index]
                                                      .fCountryName
                                                      .toString(),
                                                  style: batchtext1(AppColors
                                                      .PrimaryBlackColor),
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
                                                child: Text(
                                                  "${objCourse[index].fCurrency} ${objCourse[index].fTuitionFee.toString().split(".")[0]}/${objCourse[index].fTermTuitionFee}",
                                                  textAlign: TextAlign.center,
                                                  style: batchtext1(AppColors
                                                      .PrimaryBlackColor),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center(
                          child: Text(
                        "No data Found ",
                        style: batchtext2(AppColors.PrimaryMainColor),
                      ));
                    }
                  }),
            ),
            if (isloadingmore)
              Padding(
                padding: const EdgeInsets.all(10).w,
                child: CircularProgressIndicator(
                  color: AppColors.PrimaryMainColor,
                  strokeWidth: 2.w,
                ),
              )
          ],
        ),
      ),
    );
  }

  Future<void> _scrollListener() async {
    String spselcected = selectedItems.join(",");
    if (yeardrop != null && spselcected.isNotEmpty) {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        page = page + 1;
        setState(() {
          isloadingmore = false;
        });

        await searchFilter();
        setState(() {
          isloadingmore = true;
        });
      }
    }
  }

  String? selectedValue;

  bool selected = false;
  bool selectedrequire = false;

  List<String> selectedItems = [];
  List<String> selecteduniversity = [];
  List<String> selectedlocation = [];
  List<String> selectedintake = [];
  List<String> selectedstudyarea = [];
  List<String> selecteddisciplinearea = [];

  bool selectindex = false;
  final List<ItemModelwithValue> _chipsList = [
    ItemModelwithValue("UG", AppColors.PrimaryWhiteColor, false, "3"),
    ItemModelwithValue(
        "Twinning Programmes (UG)", AppColors.PrimaryWhiteColor, false, "11"),
    ItemModelwithValue("Foundation", AppColors.PrimaryWhiteColor, false, "8"),
    ItemModelwithValue(
        "Short Term Programs", AppColors.PrimaryWhiteColor, false, "9"),
    ItemModelwithValue(
        "High School (11th-12th)", AppColors.PrimaryWhiteColor, false, "1"),
    ItemModelwithValue(
        "Pathway Programs", AppColors.PrimaryWhiteColor, false, "10"),
    ItemModelwithValue(
        "PG Diploma/Certificate", AppColors.PrimaryWhiteColor, false, "4"),
    ItemModelwithValue("PHD", AppColors.PrimaryWhiteColor, false, "7"),
    ItemModelwithValue("PG", AppColors.PrimaryWhiteColor, false, "5"),
    ItemModelwithValue(
        "Twinning Programmes (PG)", AppColors.PrimaryWhiteColor, false, "12"),
    ItemModelwithValue("UG Diploma/ Certificate/ Associate  Degreee",
        AppColors.PrimaryWhiteColor, false, "2"),
    ItemModelwithValue(
        "UG+PG (Accelerated) Degree", AppColors.PrimaryWhiteColor, false, "6"),
  ];

  final List<ItemModelwithValue> _requirementList = [
    ItemModelwithValue("IELTS", AppColors.PrimaryWhiteColor, false, "1"),
    ItemModelwithValue("ACT", AppColors.PrimaryWhiteColor, false, "1"),
    ItemModelwithValue("TOEFL iBT", AppColors.PrimaryWhiteColor, false, "1"),
    ItemModelwithValue("GRE", AppColors.PrimaryWhiteColor, false, "1"),
    ItemModelwithValue("PTE", AppColors.PrimaryWhiteColor, false, "1"),
    ItemModelwithValue("GMAT", AppColors.PrimaryWhiteColor, false, "1"),
    ItemModelwithValue("SAT", AppColors.PrimaryWhiteColor, false, "1"),
    ItemModelwithValue("Without GRE", AppColors.PrimaryWhiteColor, false, "0"),
    ItemModelwithValue("Without SAT", AppColors.PrimaryWhiteColor, false, "0"),
    ItemModelwithValue("without GMAT", AppColors.PrimaryWhiteColor, false, "0"),
    ItemModelwithValue("Without ACT", AppColors.PrimaryWhiteColor, false, "0"),
    ItemModelwithValue(
        "Without IELTS", AppColors.PrimaryWhiteColor, false, "0"),
    ItemModelwithValue("Placement", AppColors.PrimaryWhiteColor, false, "1"),
    ItemModelwithValue(
        "Without Placement", AppColors.PrimaryWhiteColor, false, "0"),
    ItemModelwithValue("Conditional", AppColors.PrimaryWhiteColor, false, "1"),
    ItemModelwithValue(
        "Without Conditional", AppColors.PrimaryWhiteColor, false, "0"),
    ItemModelwithValue(
        "Deadline Available", AppColors.PrimaryWhiteColor, false, "yes"),
    ItemModelwithValue(
        "Scholarship Available", AppColors.PrimaryWhiteColor, false, "1"),
    ItemModelwithValue("with 15 Years Of Education",
        AppColors.PrimaryWhiteColor, false, "yes"),
  ];

  List chiparray = [];
  List requirement = [];
  List<Widget> filterChipsList(index, StateSetter setState) {
    List<Widget> chips = [];
    for (int i = 0; i < _chipsList.length; i++) {
      Widget item = Padding(
        padding: EdgeInsets.only(left: 10.r, right: 5.r, top: 5.r),
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
              if (chiparray.contains(_chipsList[i].valuefilter)) {
                chiparray.remove(_chipsList[i].valuefilter);
              } else {
                chiparray.add(_chipsList[i].valuefilter);
              }
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
        padding: EdgeInsets.only(left: 10.r, right: 5.r, top: 5.r),
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
                requirement.add(_requirementList[i].label.toString());
              }
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
          });
        }
      }
      searchBloc.getuniversitysearchStream.listen((event) {
        if (event != null) {
          universitydata = event;
          for (int i = 0; i < universitydata.length; i++) {
            UniversitySearchModel universitySearchModel =
                UniversitySearchModel.fromJson(event[i]);
            universitySearchdata.add(universitySearchModel);
            setState(() {
              loanding = false;
            });
          }
        }
      });
      searchBloc.getlocationsearchStream.listen((event) {
        if (event != null) {
          locationdata = event;
          for (int i = 0; i < locationdata.length; i++) {
            LocationSearchModel locationSearchModel =
                LocationSearchModel.fromJson(event[i]);
            setState(() {
              locationSearchdata.add(locationSearchModel);
              loanding = false;
            });
          }
        }
      });

      searchBloc.getstudyareasearchStream.listen((event) {
        if (event != null) {
          studyareadata = event;
          for (int i = 0; i < studyareadata.length; i++) {
            StudyAreaSearchModel studyAreaSearchModel =
                StudyAreaSearchModel.fromJson(event[i]);
            setState(() {
              studyareaSearchdata.add(studyAreaSearchModel);
              loanding = false;
            });
          }
        }
      });
    });
    searchBloc.getdisciplineareasearchStream.listen((event) {
      if (event != null) {
        disciplineareadata = event;
        for (int i = 0; i < disciplineareadata.length; i++) {
          DiscplineareaSearchModel discplineareaSearchModel =
              DiscplineareaSearchModel.fromJson(event[i]);

          setState(() {
            disciplineareaSearchdata.add(discplineareaSearchModel);

            loanding = false;
          });
        }
      }
    });
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

  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  searchFilter() {
    if (showloader) {
      NetworkDialogLoading.showLoadingDialog(context, _keyLoader);
    }
    String spselcected = selectedItems.join(",");
    String uniselected = selecteduniversity.join(",");
    String spdispline = selecteddisciplinearea.join(",");
    String studyarea = selectedstudyarea.join(",");
    String program = chiparray.join(",");
    String intake = selectedintake.join(",");
    String location = selectedlocation.join(",");
    Map<String, String> filterdata = {
      NetworkConstant.filterType: "Advance Search",
      NetworkConstant.pageNumber: page.toString(),
      NetworkConstant.sortBy: "",
      NetworkConstant.courseName: "",
      NetworkConstant.year: yeardrop == null ? "" : yeardrop.toString(),
      NetworkConstant.intake: intake,
      NetworkConstant.countryId: spselcected,
      NetworkConstant.scholarship: _requirementList[17].isSelected ? "1" : "",
      NetworkConstant.studyArea: studyarea,
      NetworkConstant.disciplineArea: spdispline,
      NetworkConstant.flocation: location,
      NetworkConstant.duration:
          dropduration == null ? "0" : dropduration!.id.toString(),
      NetworkConstant.isIELTS: _requirementList[0].isSelected
          ? "1"
          : _requirementList[11].isSelected
              ? "0"
              : "",
      NetworkConstant.istOEFL: _requirementList[2].isSelected ? "1" : "",
      NetworkConstant.placement: _requirementList[12].isSelected
          ? "1"
          : _requirementList[13].isSelected
              ? "0"
              : "",
      NetworkConstant.ispte: _requirementList[4].isSelected ? "1" : "",
      NetworkConstant.issat: _requirementList[6].isSelected
          ? "1"
          : _requirementList[8].isSelected
              ? "0"
              : "",
      NetworkConstant.isACT: _requirementList[1].isSelected
          ? "1"
          : _requirementList[10].isSelected
              ? "0"
              : "",
      NetworkConstant.isGRE: _requirementList[3].isSelected
          ? "1"
          : _requirementList[7].isSelected
              ? "0"
              : "",
      NetworkConstant.isGMAT: _requirementList[5].isSelected
          ? "1"
          : _requirementList[9].isSelected
              ? "0"
              : "",
      NetworkConstant.deadlineAvailable:
          _requirementList[16].isSelected ? "yes" : "",
      NetworkConstant.fifteenYearsOfEd:
          _requirementList[18].isSelected ? "yes" : "",
      NetworkConstant.eslElp: _requirementList[0].isSelected ? "1" : "",
      NetworkConstant.conditionalOffer: _requirementList[14].isSelected
          ? "1"
          : _requirementList[15].isSelected
              ? "0"
              : "",
      NetworkConstant.programLevel: program,
      NetworkConstant.universityId: uniselected,
      NetworkConstant.fRequest: "CRM",
      NetworkConstant.crmAccessRequest: "Country Manager",
    };
    searchBloc.callGetFilterSearch(filterdata);
  }
}

class ItemModel {
  String label;
  Color color;
  bool isSelected;
  ItemModel(this.label, this.color, this.isSelected);
}

class ItemModelwithValue {
  String label;
  Color color;
  bool isSelected;
  String valuefilter;

  ItemModelwithValue(this.label, this.color, this.isSelected, this.valuefilter);
}
