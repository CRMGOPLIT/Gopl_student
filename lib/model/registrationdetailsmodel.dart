class RegistrationDetails {
  RegistrationDetails({
    required this.ddlCourseIntrested,
    required this.ddlIntake,
    required this.ddlCountryIntrested,
    required this.ddlLocation,
    required this.ddlState,
  });
  late final List<DdlCourseIntrested> ddlCourseIntrested;
  late final List<DdlIntake> ddlIntake;
  late final List<DdlCountryIntrested> ddlCountryIntrested;
  late final List<DdlLocation> ddlLocation;
  late final List<DdlState> ddlState;

  RegistrationDetails.fromJson(Map<String, dynamic> json) {
    ddlCourseIntrested = List.from(json['ddlCourseIntrested'])
        .map((e) => DdlCourseIntrested.fromJson(e))
        .toList();
    ddlIntake =
        List.from(json['ddlIntake']).map((e) => DdlIntake.fromJson(e)).toList();
    ddlCountryIntrested = List.from(json['ddlCountryIntrested'])
        .map((e) => DdlCountryIntrested.fromJson(e))
        .toList();
    ddlLocation = List.from(json['ddlLocation'])
        .map((e) => DdlLocation.fromJson(e))
        .toList();
    ddlState =
        List.from(json['ddlState']).map((e) => DdlState.fromJson(e)).toList();
  }

  get body => null;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ddlCourseIntrested'] =
        ddlCourseIntrested.map((e) => e.toJson()).toList();
    data['ddlIntake'] = ddlIntake.map((e) => e.toJson()).toList();
    data['ddlCountryIntrested'] =
        ddlCountryIntrested.map((e) => e.toJson()).toList();
    data['ddlLocation'] = ddlLocation.map((e) => e.toJson()).toList();
    data['ddlState'] = ddlState.map((e) => e.toJson()).toList();
    return data;
  }
}

class DdlCourseIntrested {
  DdlCourseIntrested({
    required this.CourseIntrestedId,
    required this.CourseIntrestedName,
  });
  late final String CourseIntrestedId;
  late final String CourseIntrestedName;

  DdlCourseIntrested.fromJson(Map<String, dynamic> json) {
    CourseIntrestedId = json['CourseIntrestedId'];
    CourseIntrestedName = json['CourseIntrestedName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['CourseIntrestedId'] = CourseIntrestedId;
    _data['CourseIntrestedName'] = CourseIntrestedName;
    return _data;
  }
}

class DdlIntake {
  DdlIntake({
    required this.IntakeId,
    required this.IntakeName,
  });
  late final String IntakeId;
  late final String IntakeName;

  DdlIntake.fromJson(Map<String, dynamic> json) {
    IntakeId = json['IntakeId'];
    IntakeName = json['IntakeName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['IntakeId'] = IntakeId;
    _data['IntakeName'] = IntakeName;
    return _data;
  }
}

class DdlCountryIntrested {
  DdlCountryIntrested({
    required this.IntrestedCountryId,
    required this.IntrestedCountryName,
  });
  late final String IntrestedCountryId;
  late final String IntrestedCountryName;

  DdlCountryIntrested.fromJson(Map<String, dynamic> json) {
    IntrestedCountryId = json['IntrestedCountryId'];
    IntrestedCountryName = json['IntrestedCountryName'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['IntrestedCountryId'] = IntrestedCountryId;
    data['IntrestedCountryName'] = IntrestedCountryName;
    return data;
  }
}

class DdlLocation {
  DdlLocation({
    required this.LocationId,
    required this.LocationName,
  });
  late final String LocationId;
  late final String LocationName;

  DdlLocation.fromJson(Map<String, dynamic> json) {
    LocationId = json['LocationId'];
    LocationName = json['LocationName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['LocationId'] = LocationId;
    _data['LocationName'] = LocationName;
    return _data;
  }
}

class DdlState {
  DdlState({
    required this.StateId,
    required this.StateName,
  });
  late final String StateId;
  late final String StateName;

  DdlState.fromJson(Map<String, dynamic> json) {
    StateId = json['StateId'];
    StateName = json['StateName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StateId'] = StateId;
    _data['StateName'] = StateName;
    return _data;
  }
}
