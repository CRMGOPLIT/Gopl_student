import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/bloc/registrationbloc.dart';
import 'package:global_student/model/registrationdetailsmodel.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/view/helper/apiResponseHelper.dart';
import 'package:global_student/view/widget/app_bar.dart';
import 'package:global_student/view/widget/loader.dart';
import 'package:global_student/view/widget/text_field.dart';
import '../../networking/NetworkConstant.dart';
import '../../utils/text_style.dart';
import '../widget/button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? dropdownvalue;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  bool isSelected = false;
  bool loanding = true;

  DdlLocation? dropvalue;
  DdlIntake? dropintake;
  DdlCountryIntrested? dropcountry;

  final _registerkey = GlobalKey<FormState>();

  late HomeDataBloc homeDataBloc;

  List<DdlLocation> ddlLocation = [];
  List<DdlIntake> ddlIntake = [];
  List<DdlCountryIntrested> ddlCountryIntrested = [];

  @override
  initState() {
    homeDataBloc = HomeDataBloc();
    getRegistrationDetails();
    _gethomeData();

    homeDataBloc.postRegistrationStream.listen((event) {
      Navigator.pop(context);
      bool response =
          ApiResponseHelper().handleResponse(event: event, context: context);

      if (response == true && event.data['success'] == '1') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Registration Successfully"),
        ));
        Navigator.pushNamed(context, RoutesName.login);
        // debugger();

        //IF Anything going wrong

        // showDialog<void>(
        //     context: context,
        //     barrierColor: AppColors.PrimaryMainColor,
        //     barrierDismissible: false,
        //     builder: (BuildContext context) {
        //       return ApiErrorDialog(
        //           btnText: "Back To Home",
        //           image: "assets/images/batch.png",
        //           description: event.data['massage'].toString(),
        //           onPressed: () {
        //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //               content: Text(event.data['massage'].toString()),
        //             ));
        //             // Navigator.pop(context);
        //             // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //             //   content: Text(event.data['massage'].toString()),
        //             // ));
        //             // NavigationUtils().navigateOffAll(fileName: HomePage());
        //             return false;
        //           });
        //     });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          duration: const Duration(milliseconds: 1000),
          content: Container(
            padding: const EdgeInsets.all(8),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.9),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Oops Error!',
                        style: TextStyle(fontSize: 18.sp, color: Colors.white),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(event.data['massage'].toString(),
                          style: batchtext1(
                            AppColors.PrimaryWhiteColor,
                          )),
                      //         TextStyle(fontSize: 15.sp, color: Colors.white),
                      //     maxLines: 2,
                      //     overflow: TextOverflow.ellipsis,
                      //   ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
        // showDialog<void>(
        //     context: context,
        //     barrierColor: AppColors.PrimaryMainColor.withOpacity(0.1),
        //     barrierDismissible: false,
        //     builder: (BuildContext context) {
        //       return ApiErrorDialog(
        //           btnText: 'Retry',
        //           image: "assets/images/batch.png",
        //           description: event.data['massage'].toString(),
        //           onPressed: () {
        //             Navigator.pop(context);
        //             //  getMaxAMountLoanDetails();

        //             // Navigator.pushNamed(context, RoutesName.register);
        //           });
        //     });
      }
    });

    // TODO: implement initState
    super.initState();
  }

//Calling Data
  getRegistrationDetails() async {
    homeDataBloc.getRegistrationDetailsStream.listen((event) {
      if (event != null) {
        // debugger();

        RegistrationDetails homeRepoModel = RegistrationDetails.fromJson(event);
        ddlLocation.addAll(homeRepoModel.ddlLocation);
        ddlIntake.addAll(homeRepoModel.ddlIntake);
        ddlCountryIntrested.addAll(homeRepoModel.ddlCountryIntrested);
        setState(() {
          loanding = false;
        });
      }
    });
  }

// Call Api Bloc
  _gethomeData() {
    homeDataBloc.callGetApplicationDetailsApi();
  }

//post Data

  void callGetPromotersDetailsApi() {
    NetworkDialog.showLoadingDialog(context, _keyLoader);
    Map<String, String> data = {
      NetworkConstant.NAME: _nameController.text,
      NetworkConstant.EMAIL: _emailController.text,
      NetworkConstant.MOBILE: _mobileController.text,
      NetworkConstant.BRANCH: dropvalue!.LocationId,
      NetworkConstant.INTAKE: dropintake!.IntakeId,
      NetworkConstant.COUNTRY: dropcountry!.IntrestedCountryId,
    };
    homeDataBloc.callPostRegistration(data);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h), // here the desired height
        child: AppBarCustom(
          title: "Registration",
          onpress: () {
            Navigator.pushNamed(context, RoutesName.login);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              // image: DecorationImage(
              //     fit: BoxFit.cover,
              //     image: AssetImage(
              //       "assets/images/bgreg.jpeg",
              //     ))
              ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _registerkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormWidget(
                    hint: "Enter Your name",
                    title: "Enter Name",
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Name';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r"[a-zA-Z]+|\s"),
                      )
                    ],
                    // validate: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter some text';
                    //   }
                    //   return null;
                    // },
                  ),
                  TextFormWidget(
                    hint: "Enter Your Email id",
                    title: "Email Id",
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Your email';
                      }
                      return null;
                    },
                  ),
                  TextFormWidget(
                      hint: "Enter Your Mobile Number",
                      title: "Mobile Number",
                      controller: _mobileController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length != 10) {
                          return 'Please enter valid Phone Number 10 digit';
                        } else if (value.isNotEmpty) {
                          //bool mobileValid = RegExp(r"^(?:\+88||01)?(?:\d{10}|\d{13})$").hasMatch(value);

                          bool mobileValid =
                              RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                  .hasMatch(value);
                          return mobileValid ? null : "Invalid mobile";
                        }
                        return null;
                      },
                      // validator: (value) {
                      //   if (value!.isEmpty ||
                      //       !RegExp(r"^[0-9]").hasMatch(value)) {
                      //     return 'Enter a valid phone';
                      //   }
                      //   return null;
                      // },
                      inputFormatters: [
                        FilteringTextInputFormatter(RegExp("[0-9]"),
                            allow: true),
                      ]),

                  // Text("State",
                  //     style: FieldTextStyle(
                  //       AppColors.PrimaryBlackColor,
                  //     )),
                  // Container(
                  //   height: 50.h,
                  //   width: 480.w,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10.r)),
                  //   child: DropdownButtonFormField(
                  //     style: TextStyle(
                  //         color: AppColors.PrimaryMainColor,
                  //         fontWeight: FontWeight.w600),
                  //     decoration: InputDecoration(
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10.r),
                  //         borderSide: BorderSide(
                  //             color: AppColors.PrimaryGreyColor, width: 1),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10.r),
                  //         borderSide: BorderSide(
                  //           color: AppColors.PrimaryBlackColor,
                  //           width: 1,
                  //         ),
                  //       ),
                  //     ),
                  //     value: dropdownvalue,
                  //     isExpanded: true,
                  //     icon: Padding(
                  //       padding: EdgeInsets.only(right: 10.r),
                  //       child: Icon(
                  //         Icons.keyboard_arrow_down,
                  //         size: 30.sp,
                  //         color: AppColors.PrimaryMainColor,
                  //       ),
                  //     ),
                  //     items: items.map((String items) {
                  //       return DropdownMenuItem(
                  //         value: items,
                  //         child: Padding(
                  //           padding: EdgeInsets.only(left: 10.r),
                  //           child: Text(items),
                  //         ),
                  //       );
                  //     }).toList(),
                  //     onChanged: (String? newValue) {
                  //       setState(() {
                  //         isSelected = true;
                  //       });
                  //     },
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  Text("Closest Branch",
                      style: FieldTextStyle(
                        AppColors.PrimaryBlackColor,
                      )),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField2(
                        isDense: false,
                        isExpanded: true,
                        decoration: const InputDecoration(
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
                        validator: (value) {
                          if (value == null || value.LocationName.isEmpty) {
                            return 'Please Select Branch';
                          }
                          return null;
                        },
                        hint: Text(
                          'Please select branch',
                          style: batchtext2(AppColors.hintcolor),
                        ),
                        items: ddlLocation
                            .map((DdlLocation item) =>
                                DropdownMenuItem<DdlLocation>(
                                  value: item,
                                  child: Text(
                                    item.LocationName,
                                    style:
                                        batchtext2(AppColors.PrimaryMainColor),
                                  ),
                                ))
                            .toList(),
                        value: dropvalue,
                        onChanged: (DdlLocation? value) {
                          setState(() {
                            dropvalue = value;
                            isSelected = true;
                            //  selectedSecurity = value!;
                            // accountTypeValidate = true;
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          height: 55,
                          width: 450,
                          padding: EdgeInsets.all(10),
                        ),
                        dropdownStyleData: DropdownStyleData(
                            isOverButton: true,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                color: AppColors.backgroungcolor,
                                border: Border.all()),
                            maxHeight: 200.h,
                            elevation: 10),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          height: 40,
                        ),
                        iconStyleData: const IconStyleData(
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
                  //   height: 50.h,
                  //   width: 480.w,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10.r)),
                  //   child: DropdownButtonFormField(
                  //     style: TextStyle(
                  //         color: AppColors.PrimaryMainColor,
                  //         fontWeight: FontWeight.w600),
                  //     decoration: InputDecoration(
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10.r),
                  //         borderSide: BorderSide(
                  //             color: AppColors.PrimaryGreyColor, width: 1),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10.r),
                  //         borderSide: BorderSide(
                  //           color: AppColors.PrimaryBlackColor,
                  //           width: 1,
                  //         ),
                  //       ),
                  //     ),
                  //     value: dropdownvalue,
                  //     isExpanded: true,
                  //     icon: Padding(
                  //       padding: EdgeInsets.only(right: 10.r),
                  //       child: Icon(
                  //         Icons.keyboard_arrow_down,
                  //         size: 30.sp,
                  //         color: AppColors.PrimaryMainColor,
                  //       ),
                  //     ),
                  //     items: items.map((String items) {
                  //       return DropdownMenuItem(
                  //         value: items,
                  //         child: Padding(
                  //           padding: EdgeInsets.only(left: 10.r),
                  //           child: Text(items),
                  //         ),
                  //       );
                  //     }).toList(),
                  //     onChanged: (String? newValue) {
                  //       setState(() {
                  //         isSelected = true;
                  //       });
                  //     },
                  //   ),
                  // ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text("University Intake",
                      style: FieldTextStyle(
                        AppColors.PrimaryBlackColor,
                      )),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField2(
                        isDense: false,
                        isExpanded: true,
                        decoration: const InputDecoration(
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
                        validator: (value) {
                          if (value == null || value.IntakeName.isEmpty) {
                            return 'Please Select Intake';
                          }
                          return null;
                        },
                        // customButton: Container(
                        //   height: 50,
                        //   width: 360,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       border: Border.all()
                        //       // image: const DecorationImage(
                        //       //   image: NetworkImage(
                        //       //     'https://cdn.pixabay.com/photo/2020/05/11/06/20/city-5156636_960_720.jpg',
                        //       //   ),
                        //       //   fit: BoxFit.cover,
                        //       // ),
                        //       ),
                        // ),
                        // icon: Container(),

                        //iconStyleData: ,
                        hint: Text(
                          'Please select Intake',
                          style: batchtext2(AppColors.hintcolor),
                        ),
                        items: ddlIntake
                            .map((DdlIntake? item) =>
                                DropdownMenuItem<DdlIntake>(
                                  value: item,
                                  child: Text(
                                    item!.IntakeName.toString(),
                                    style:
                                        batchtext2(AppColors.PrimaryMainColor),
                                  ),
                                ))
                            .toList(),
                        value: dropintake,
                        onChanged: (DdlIntake? value) {
                          setState(() {
                            dropintake = value!;
                            isSelected = true;
                            //  selectedSecurity = value!;
                            // accountTypeValidate = true;
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          height: 55,
                          width: 450,
                          padding: EdgeInsets.all(10),
                          // decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(10.sp),
                          //     border: Border.all(
                          //         color: AppColors.PrimaryMainColor))
                        ),
                        dropdownStyleData: DropdownStyleData(
                            isOverButton: true,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                color: AppColors.backgroungcolor,
                                border: Border.all()),
                            maxHeight: 200.h,
                            elevation: 10),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          height: 40,
                        ),
                        iconStyleData: const IconStyleData(
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
                  //   height: 50.h,
                  //   width: 480.w,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(50.r)),
                  //   child: DropdownButtonFormField(
                  //     style: TextStyle(
                  //         color: AppColors.PrimaryMainColor,
                  //         fontWeight: FontWeight.w600),
                  //     decoration: InputDecoration(
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10.r),
                  //         borderSide: BorderSide(
                  //             color: AppColors.PrimaryGreyColor, width: 1),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10.r),
                  //         borderSide: BorderSide(
                  //           color: AppColors.PrimaryBlackColor,
                  //           width: 1,
                  //         ),
                  //       ),
                  //     ),
                  //     value: dropdownvalue,
                  //     isExpanded: true,
                  //     icon: Padding(
                  //       padding: EdgeInsets.only(right: 10.r),
                  //       child: Icon(
                  //         Icons.keyboard_arrow_down,
                  //         size: 30.sp,
                  //         color: AppColors.PrimaryMainColor,
                  //       ),
                  //     ),
                  //     items: items.map((String items) {
                  //       return DropdownMenuItem(
                  //         value: items,
                  //         child: Padding(
                  //           padding: EdgeInsets.only(left: 10.r),
                  //           child: Text(items),
                  //         ),
                  //       );
                  //     }).toList(),
                  //     onChanged: (String? newValue) {
                  //       setState(() {
                  //         isSelected = true;
                  //       });
                  //     },
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  // Text("Course interested",
                  //     style: FieldTextStyle(
                  //       AppColors.PrimaryBlackColor,
                  //     )),
                  // Container(
                  //   height: 50.h,
                  //   width: 480.w,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10.r)),
                  //   child: DropdownButtonFormField(
                  //     style: TextStyle(
                  //         color: AppColors.PrimaryMainColor,
                  //         fontWeight: FontWeight.w600),
                  //     decoration: InputDecoration(
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10.r),
                  //         borderSide: BorderSide(
                  //             color: AppColors.PrimaryGreyColor, width: 1),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10.r),
                  //         borderSide: BorderSide(
                  //           color: AppColors.PrimaryBlackColor,
                  //           width: 1,
                  //         ),
                  //       ),
                  //     ),
                  //     value: dropdownvalue,
                  //     isExpanded: true,
                  //     icon: Padding(
                  //       padding: EdgeInsets.only(right: 10.r),
                  //       child: Icon(
                  //         Icons.keyboard_arrow_down,
                  //         size: 30.sp,
                  //         color: AppColors.PrimaryMainColor,
                  //       ),
                  //     ),
                  //     items: items.map((String items) {
                  //       return DropdownMenuItem(
                  //         value: items,
                  //         child: Padding(
                  //           padding: EdgeInsets.only(left: 10.r),
                  //           child: Text(items),
                  //         ),
                  //       );
                  //     }).toList(),
                  //     onChanged: (String? newValue) {
                  //       setState(() {
                  //         isSelected = true;
                  //       });
                  //     },
                  //   ),
                  // ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text("Country",
                      style: FieldTextStyle(
                        AppColors.PrimaryBlackColor,
                      )),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonFormField2(
                      isDense: false,
                      isExpanded: true,
                      decoration: const InputDecoration(
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
                      validator: (value) {
                        if (value == null ||
                            value.IntrestedCountryName.isEmpty) {
                          return 'Please Select Country';
                        }
                        return null;
                      },
                      // isExpanded: false,
                      //alignment: Alignment.center,
                      // customButton: Container(
                      //   height: 50,
                      //   width: 360,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       border: Border.all()
                      //       // image: const DecorationImage(
                      //       //   image: NetworkImage(
                      //       //     'https://cdn.pixabay.com/photo/2020/05/11/06/20/city-5156636_960_720.jpg',
                      //       //   ),
                      //       //   fit: BoxFit.cover,
                      //       // ),
                      //       ),
                      // ),
                      // icon: Container(),
                      // isExpanded: true,
                      //iconStyleData: ,
                      hint: Text(
                        'Please select country',
                        style: batchtext2(AppColors.hintcolor),
                      ),
                      items: ddlCountryIntrested
                          .map((item) => DropdownMenuItem<DdlCountryIntrested>(
                                value: item,
                                child: Text(
                                  item.IntrestedCountryName,
                                  style: batchtext2(AppColors.PrimaryMainColor),
                                ),
                              ))
                          .toList(),
                      value: dropcountry,
                      onChanged: (DdlCountryIntrested? value) {
                        setState(() {
                          dropcountry = value;
                          isSelected = true;
                          //  selectedSecurity = value!;
                          // accountTypeValidate = true;
                        });
                      },
                      buttonStyleData: const ButtonStyleData(
                        height: 55,
                        width: 450,
                        padding: EdgeInsets.all(10),
                      ),
                      dropdownStyleData: DropdownStyleData(
                          isOverButton: true,
                          openInterval: const Interval(0.25, 0.5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.sp),
                              color: AppColors.backgroungcolor,
                              border: Border.all()),
                          maxHeight: 130.h,
                          elevation: 10),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        height: 40,
                      ),
                      // dropdownSearchData: DropdownSearchData(
                      // //  searchController: textEditingController,
                      //   searchInnerWidgetHeight: 50,
                      //   searchInnerWidget: Container(
                      //     height: 50,
                      //     padding: const EdgeInsets.only(
                      //       top: 8,
                      //       bottom: 4,
                      //       right: 8,
                      //       left: 8,
                      //     ),
                      //     child: TextFormField(
                      //       expands: true,
                      //       maxLines: null,
                      //       // controller: "",
                      //       decoration: InputDecoration(
                      //         isDense: true,
                      //         contentPadding: const EdgeInsets.symmetric(
                      //           horizontal: 10,
                      //           vertical: 8,
                      //         ),
                      //         hintText: 'Search for an item...',
                      //         hintStyle: const TextStyle(fontSize: 12),
                      //         border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(8),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      //   searchMatchFn: (item, searchValue) {
                      //     return (items.value.toString().contains(searchValue));
                      //   },
                      // ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.PrimaryMainColor,
                        ),
                        iconSize: 30,
                      ),
                    ),
                  ),
                  // Container(
                  //   height: 50.h,
                  //   width: 480.w,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10.r)),
                  //   child: DropdownButtonFormField(
                  //     style: TextStyle(
                  //         color: AppColors.PrimaryMainColor,
                  //         fontWeight: FontWeight.w600),
                  //     decoration: InputDecoration(
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10.r),
                  //         borderSide: BorderSide(
                  //             color: AppColors.PrimaryGreyColor, width: 1),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10.r),
                  //         borderSide: BorderSide(
                  //           color: AppColors.PrimaryBlackColor,
                  //           width: 1,
                  //         ),
                  //       ),
                  //     ),
                  //     value: dropdownvalue,
                  //     isExpanded: true,
                  //     icon: Padding(
                  //       padding: EdgeInsets.only(right: 10.r),
                  //       child: Icon(
                  //         Icons.keyboard_arrow_down,
                  //         size: 30.sp,
                  //         color: AppColors.PrimaryMainColor,
                  //       ),
                  //     ),
                  //     items: items.map((String items) {
                  //       return DropdownMenuItem(
                  //         value: items,
                  //         child: Padding(
                  //           padding: EdgeInsets.only(left: 10.r),
                  //           child: Text(items),
                  //         ),
                  //       );
                  //     }).toList(),
                  //     onChanged: (String? newValue) {
                  //       setState(() {
                  //         isSelected = true;
                  //       });
                  //     },
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // ButtonPrimary(title: "submit", onPressed: () {})

                  // Container(
                  //   height: 400,
                  //   color: AppColors.PrimaryMainColor,
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            // image: DecorationImage(
            //     fit: BoxFit.cover,
            //     image: AssetImage(
            //       "assets/images/bgreg.jpeg",
            //     ))
            ),
        child: BottomAppBar(
            elevation: 0.0,
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(bottom: 15.r, left: 15.r, right: 15.r),
              child: ButtonPrimary(
                title: "Submit",
                onPressed: () {
                  // callGetPromotersDetailsApi();
                  if (_registerkey.currentState!.validate() &&
                      dropvalue != null &&
                      dropintake != null &&
                      dropcountry != null) {
                    callGetPromotersDetailsApi();
                    // use the email provided here
                  }
                  //  else {
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //     content: Text("Please select Value "),
                  //   ));
                  // }
                },
              ),
            )),
      ),
    );
  }
}
