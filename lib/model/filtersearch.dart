// To parse this JSON data, do
//
//     final filterSeach = filterSeachFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FilterSeach filterSeachFromJson(String str) =>
    FilterSeach.fromJson(json.decode(str));

String filterSeachToJson(FilterSeach data) => json.encode(data.toJson());

class FilterSeach {
  List<ObjCourse> objCourse;

  FilterSeach({
    required this.objCourse,
  });

  factory FilterSeach.fromJson(Map<String, dynamic> json) => FilterSeach(
        objCourse: List<ObjCourse>.from(
            json["objCourse"].map((x) => ObjCourse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "objCourse": List<dynamic>.from(objCourse.map((x) => x.toJson())),
      };
}

class ObjCourse {
  int fCourseDetailId;
  String fAccess;
  int fCountryId;
  String fCountryName;
  int fUniversityId;
  String fUniversity;
  String fProgram;
  double fDuration;
  String fDurationName;
  String fStartYear;
  String fEndYear;
  String fIntake;
  String fProgramLevel;
  String fStudyArea;
  String fDisciplineArea;
  double fApplicationFee;
  double fTuitionFee;
  String fApplicationMode;
  String fApplicationDeadline;
  String fCourseUrl;
  String fCampus;
  String fRemark;
  String fIelts;
  String fIsRequirdIelts;
  String fToeflIbt;
  String fIsRequirdToeflIbt;
  String fPte;
  String fPteLessThan;
  String fIsRequirdPte;
  String fSat;
  String fDat;
  String fIeltsMore;
  String fToeflMore;
  String fIsRequirdSat;
  String fAct;
  String fIsRequirdAct;
  String fWith15YearsOfEducation;
  String fGre;
  String fIsRequirdGre;
  String fBacklogs;
  String fIsRequirdBacklogs;
  String fGmat;
  String fIsRequirdGmat;
  String fIsScholarshipAvailable;
  String fScholarshipDetails;
  String fEslElpAvailable;
  String fDisplayOrder;
  bool fIsStatus;
  bool fIsApprove;
  bool fIsDelete;
  bool fIsReject;
  int userId;
  String fromDate;
  String toDate;
  int fUpdatedBy;
  DateTime fUpdateOnDate;
  String ranking;
  int count;
  int fProgramId;
  String fAddress;
  String fUniversityLogo;
  FGlobalOpsRanking fGlobalOpsRanking;
  String fNationalRank;
  String fUniversityUrl;
  String fUniversityRemarks;
  String fRequirements;
  String fIeltsLessThan;
  String fToeflIbtLessThan;
  String fEntryRequirements;
  String fDet;
  int fStudentId;
  String fFristName;
  String fIsPlacement;
  String fCurrency;
  double fMoreThanApplicationFee;
  String fTermTuitionFee;
  String fApplicationLink;
  String fIncentive;
  String fExpenditureFee;
  String lastUpdatedBy;
  String approveBy;
  String fLocation;
  String expectableBoard;
  String rejectedComment;
  String fConditionalStatus;
  String logo;

  ObjCourse({
    required this.fCourseDetailId,
    required this.fAccess,
    required this.fCountryId,
    required this.fCountryName,
    required this.fUniversityId,
    required this.fUniversity,
    required this.fProgram,
    required this.fDuration,
    required this.fDurationName,
    required this.fStartYear,
    required this.fEndYear,
    required this.fIntake,
    required this.fProgramLevel,
    required this.fStudyArea,
    required this.fDisciplineArea,
    required this.fApplicationFee,
    required this.fTuitionFee,
    required this.fApplicationMode,
    required this.fApplicationDeadline,
    required this.fCourseUrl,
    required this.fCampus,
    required this.fRemark,
    required this.fIelts,
    required this.fIsRequirdIelts,
    required this.fToeflIbt,
    required this.fIsRequirdToeflIbt,
    required this.fPte,
    required this.fPteLessThan,
    required this.fIsRequirdPte,
    required this.fSat,
    required this.fDat,
    required this.fIeltsMore,
    required this.fToeflMore,
    required this.fIsRequirdSat,
    required this.fAct,
    required this.fIsRequirdAct,
    required this.fWith15YearsOfEducation,
    required this.fGre,
    required this.fIsRequirdGre,
    required this.fBacklogs,
    required this.fIsRequirdBacklogs,
    required this.fGmat,
    required this.fIsRequirdGmat,
    required this.fIsScholarshipAvailable,
    required this.fScholarshipDetails,
    required this.fEslElpAvailable,
    required this.fDisplayOrder,
    required this.fIsStatus,
    required this.fIsApprove,
    required this.fIsDelete,
    required this.fIsReject,
    required this.userId,
    required this.fromDate,
    required this.toDate,
    required this.fUpdatedBy,
    required this.fUpdateOnDate,
    required this.ranking,
    required this.count,
    required this.fProgramId,
    required this.fAddress,
    required this.fUniversityLogo,
    required this.fGlobalOpsRanking,
    required this.fNationalRank,
    required this.fUniversityUrl,
    required this.fUniversityRemarks,
    required this.fRequirements,
    required this.fIeltsLessThan,
    required this.fToeflIbtLessThan,
    required this.fEntryRequirements,
    required this.fDet,
    required this.fStudentId,
    required this.fFristName,
    required this.fIsPlacement,
    required this.fCurrency,
    required this.fMoreThanApplicationFee,
    required this.fTermTuitionFee,
    required this.fApplicationLink,
    required this.fIncentive,
    required this.fExpenditureFee,
    required this.lastUpdatedBy,
    required this.approveBy,
    required this.fLocation,
    required this.expectableBoard,
    required this.rejectedComment,
    required this.fConditionalStatus,
    required this.logo,
  });

  factory ObjCourse.fromJson(Map<String, dynamic> json) => ObjCourse(
        fCourseDetailId: json["f_Course_Detail_Id"],
        fAccess: json["f_access"].toString(),
        fCountryId: json["f_CountryId"],
        fCountryName: json["f_Country_Name"]!,
        fUniversityId: json["f_UniversityId"],
        fUniversity: json["f_University"].toString(),
        fProgram: json["f_Program"].toString(),
        fDuration: json["f_Duration"],
        fDurationName: json["f_Duration_Name"],
        fStartYear: json["f_Start_Year"].toString(),
        fEndYear: json["f_End_Year"].toString(),
        fIntake: json["f_Intake"].toString(),
        fProgramLevel: json["f_Program_Level"].toString(),
        fStudyArea: json["f_Study_Area"].toString(),
        fDisciplineArea: json["f_Discipline_Area"].toString(),
        fApplicationFee: json["f_Application_Fee"],
        fTuitionFee: json["f_Tuition_Fee"],
        fApplicationMode: json["f_Application_Mode"].toString(),
        fApplicationDeadline: json["f_Application_Deadline"].toString(),
        fCourseUrl: json["f_Course_URL"].toString(),
        fCampus: json["f_Campus"].toString(),
        fRemark: json["f_Remark"].toString(),
        fIelts: json["f_IELTS"].toString(),
        fIsRequirdIelts: json["f_Is_Requird_IELTS"].toString(),
        fToeflIbt: json["f_TOEFL_IBT"].toString(),
        fIsRequirdToeflIbt: json["f_Is_Requird_TOEFL_IBT"].toString(),
        fPte: json["f_PTE"].toString(),
        fPteLessThan: json["f_PTE_Less_Than"].toString(),
        fIsRequirdPte: json["f_Is_Requird_PTE"].toString(),
        fSat: json["f_SAT"].toString(),
        fDat: json["f_Dat"].toString(),
        fIeltsMore: json["f_IELTS_More"].toString(),
        fToeflMore: json["f_TOEFL_More"].toString(),
        fIsRequirdSat: json["f_Is_Requird_SAT"].toString(),
        fAct: json["f_ACT"].toString(),
        fIsRequirdAct: json["f_Is_Requird_ACT"].toString(),
        fWith15YearsOfEducation:
            json["f_With_15_Years_of_Education"].toString(),
        fGre: json["f_GRE"].toString(),
        fIsRequirdGre: json["f_Is_Requird_GRE"].toString(),
        fBacklogs: json["f_BACKLOGS"].toString(),
        fIsRequirdBacklogs: json["f_Is_Requird_BACKLOGS"].toString(),
        fGmat: json["f_GMAT"].toString(),
        fIsRequirdGmat: json["f_Is_Requird_GMAT"].toString(),
        fIsScholarshipAvailable: json["f_Is_Scholarship_Available"].toString(),
        fScholarshipDetails: json["f_Scholarship_Details"].toString(),
        fEslElpAvailable: json["f_ESL_ELP_Available"].toString(),
        fDisplayOrder: json["f_Display_Order"].toString(),
        fIsStatus: json["f_Is_Status"],
        fIsApprove: json["f_Is_Approve"],
        fIsDelete: json["f_Is_Delete"],
        fIsReject: json["f_Is_Reject"],
        userId: json["user_id"],
        fromDate: json["FromDate"].toString(),
        toDate: json["ToDate"].toString(),
        fUpdatedBy: json["f_Updated_By"],
        fUpdateOnDate: DateTime.parse(json["f_Update_On_Date"]),
        ranking: json["Ranking"].toString(),
        count: json["Count"],
        fProgramId: json["f_Program_Id"],
        fAddress: json["f_address"].toString(),
        fUniversityLogo: json["f_university_Logo"].toString(),
        fGlobalOpsRanking:
            fGlobalOpsRankingValues.map[json["f_Global_OPS_Ranking"]]!,
        fNationalRank: json["f_National_Rank"].toString(),
        fUniversityUrl: json["f_University_URL"].toString(),
        fUniversityRemarks: json["f_University_Remarks"].toString(),
        fRequirements: json["f_Requirements"].toString(),
        fIeltsLessThan: json["f_IELTS_Less_Than"].toString(),
        fToeflIbtLessThan: json["f_TOEFL_IBT_Less_Than"].toString(),
        fEntryRequirements: json["f_Entry_Requirements"].toString(),
        fDet: json["f_DET"].toString(),
        fStudentId: json["f_Student_Id"],
        fFristName: json["f_FristName"].toString(),
        fIsPlacement: json["f_Is_Placement"].toString(),
        fCurrency: json["f_Currency"],
        fMoreThanApplicationFee: json["f_More_Than_Application_Fee"],
        fTermTuitionFee: json["f_Term_Tuition_Fee"],
        fApplicationLink: json["f_Application_Link"].toString(),
        fIncentive: json["f_Incentive"].toString(),
        fExpenditureFee: json["f_Expenditure_fee"].toString(),
        lastUpdatedBy: json["LastUpdated_By"].toString(),
        approveBy: json["ApproveBy"].toString(),
        fLocation: fLocationValues.map[json["f_Location"]].toString(),
        expectableBoard: json["ExpectableBoard"].toString(),
        rejectedComment: json["RejectedComment"].toString(),
        fConditionalStatus: json["f_ConditionalStatus"].toString(),
        logo: json["Logo"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "f_Course_Detail_Id": fCourseDetailId,
        "f_access": fAccess,
        "f_CountryId": fCountryId,
        "f_Country_Name": fCountryNameValues.reverse[fCountryName],
        "f_UniversityId": fUniversityId,
        "f_University": fUniversity,
        "f_Program": fProgram,
        "f_Duration": fDuration,
        "f_Duration_Name": fDurationNameValues.reverse[fDurationName],
        "f_Start_Year": fStartYear,
        "f_End_Year": fEndYear,
        "f_Intake": fIntake,
        "f_Program_Level": fProgramLevel,
        "f_Study_Area": fStudyArea,
        "f_Discipline_Area": fDisciplineArea,
        "f_Application_Fee": fApplicationFee,
        "f_Tuition_Fee": fTuitionFee,
        "f_Application_Mode": fApplicationMode,
        "f_Application_Deadline": fApplicationDeadline,
        "f_Course_URL": fCourseUrl,
        "f_Campus": fCampus,
        "f_Remark": fRemark,
        "f_IELTS": fIelts,
        "f_Is_Requird_IELTS": fIsRequirdIelts,
        "f_TOEFL_IBT": fToeflIbt,
        "f_Is_Requird_TOEFL_IBT": fIsRequirdToeflIbt,
        "f_PTE": fPte,
        "f_PTE_Less_Than": fPteLessThan,
        "f_Is_Requird_PTE": fIsRequirdPte,
        "f_SAT": fSat,
        "f_Dat": fDat,
        "f_IELTS_More": fIeltsMore,
        "f_TOEFL_More": fToeflMore,
        "f_Is_Requird_SAT": fIsRequirdSat,
        "f_ACT": fAct,
        "f_Is_Requird_ACT": fIsRequirdAct,
        "f_With_15_Years_of_Education": fWith15YearsOfEducation,
        "f_GRE": fGre,
        "f_Is_Requird_GRE": fIsRequirdGre,
        "f_BACKLOGS": fBacklogs,
        "f_Is_Requird_BACKLOGS": fIsRequirdBacklogs,
        "f_GMAT": fGmat,
        "f_Is_Requird_GMAT": fIsRequirdGmat,
        "f_Is_Scholarship_Available": fIsScholarshipAvailable,
        "f_Scholarship_Details": fScholarshipDetails,
        "f_ESL_ELP_Available": fEslElpAvailable,
        "f_Display_Order": fDisplayOrder,
        "f_Is_Status": fIsStatus,
        "f_Is_Approve": fIsApprove,
        "f_Is_Delete": fIsDelete,
        "f_Is_Reject": fIsReject,
        "user_id": userId,
        "FromDate": fromDate,
        "ToDate": toDate,
        "f_Updated_By": fUpdatedBy,
        "f_Update_On_Date": fUpdateOnDate.toIso8601String(),
        "Ranking": ranking,
        "Count": count,
        "f_Program_Id": fProgramId,
        "f_address": fAddress,
        "f_university_Logo": fUniversityLogo,
        "f_Global_OPS_Ranking":
            fGlobalOpsRankingValues.reverse[fGlobalOpsRanking],
        "f_National_Rank": fNationalRank,
        "f_University_URL": fUniversityUrl,
        "f_University_Remarks": fUniversityRemarks,
        "f_Requirements": fRequirements,
        "f_IELTS_Less_Than": fIeltsLessThan,
        "f_TOEFL_IBT_Less_Than": fToeflIbtLessThan,
        "f_Entry_Requirements": fEntryRequirements,
        "f_DET": fDet,
        "f_Student_Id": fStudentId,
        "f_FristName": fFristName,
        "f_Is_Placement": fIsPlacement,
        "f_Currency": fCurrencyValues.reverse[fCurrency],
        "f_More_Than_Application_Fee": fMoreThanApplicationFee,
        "f_Term_Tuition_Fee": fTermTuitionFeeValues.reverse[fTermTuitionFee],
        "f_Application_Link": fApplicationLink,
        "f_Incentive": fIncentive,
        "f_Expenditure_fee": fExpenditureFee,
        "LastUpdated_By": lastUpdatedBy,
        "ApproveBy": approveBy,
        "f_Location": fLocationValues.reverse[fLocation],
        "ExpectableBoard": expectableBoard,
        "RejectedComment": rejectedComment,
        "f_ConditionalStatus": fConditionalStatus,
        "Logo": logo,
      };
}

enum FCountryName { AUSTRALIA }

final fCountryNameValues = EnumValues({"Australia": FCountryName.AUSTRALIA});

enum FCurrency { AUD }

final fCurrencyValues = EnumValues({"AUD\u0024": FCurrency.AUD});

enum FDurationName { THE_4_YEAR, THE_5_YEAR, THE_3_YEAR }

final fDurationNameValues = EnumValues({
  "3 Year": FDurationName.THE_3_YEAR,
  "4 Year": FDurationName.THE_4_YEAR,
  "5 Year": FDurationName.THE_5_YEAR
});

enum FGlobalOpsRanking { C, B, A }

final fGlobalOpsRankingValues = EnumValues({
  "A": FGlobalOpsRanking.A,
  "B": FGlobalOpsRanking.B,
  "C": FGlobalOpsRanking.C
});

enum FLocation { QUEENSLAND, MELBOURNE, SYDNEY }

final fLocationValues = EnumValues({
  "Melbourne": FLocation.MELBOURNE,
  "Queensland": FLocation.QUEENSLAND,
  "Sydney": FLocation.SYDNEY
});

enum FTermTuitionFee { YEAR }

final fTermTuitionFeeValues = EnumValues({"year": FTermTuitionFee.YEAR});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
