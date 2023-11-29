class MonthModel {
  String? name;
  String? id;

  MonthModel({
    this.name,
    this.id,
  });
}

List<MonthModel> months = [
  MonthModel(
    id: '1',
    name: 'January',
  ),
  MonthModel(
    id: '2',
    name: 'February ',
  ),
  MonthModel(
    id: '3',
    name: 'March',
  ),
  MonthModel(
    id: '4',
    name: 'April',
  ),
  MonthModel(
    id: '5',
    name: 'May',
  ),
  MonthModel(
    id: '6',
    name: 'June',
  ),
  MonthModel(
    id: '7',
    name: 'July',
  ),
  MonthModel(
    id: '8',
    name: 'August',
  ),
  MonthModel(
    id: '9',
    name: 'September',
  ),
  MonthModel(
    id: '10',
    name: 'October',
  ),
  MonthModel(
    id: '11',
    name: 'Novermber ',
  ),
  MonthModel(
    id: '12',
    name: 'December',
  )
];

class DurationModel {
  String? name;
  String? id;

  DurationModel({
    this.name,
    this.id,
  });
}

List<DurationModel> duration = [
  DurationModel(
    id: '1',
    name: '0 - 1 Years',
  ),
  DurationModel(
    id: '2',
    name: '1 - 2 Years',
  ),
  DurationModel(
    id: '3',
    name: '2 - 3 Years',
  ),
  DurationModel(
    id: '4',
    name: '3 - 4 Years',
  ),
  DurationModel(
    id: '5',
    name: '4 and above Years',
  ),
];

class Timeappointment {
  String? name;
  String? id;

  Timeappointment({
    this.name,
    this.id,
  });
}

List<Timeappointment> timeappointment = [
  Timeappointment(
    id: '9-10',
    name: '9 To 10 AM',
  ),
  Timeappointment(
    id: '10-11',
    name: '10 To 11 AM',
  ),
  Timeappointment(
    id: '11-12',
    name: '11 To 12 AM',
  ),
  Timeappointment(
    id: '12-1',
    name: '12 To 1 PM',
  ),
  Timeappointment(
    id: '1-2',
    name: '1 To 2 PM',
  ),
  Timeappointment(
    id: '2-3',
    name: '2 To 3 PM',
  ),
  Timeappointment(
    id: '3-4',
    name: '3 To 4 PM',
  ),
  Timeappointment(
    id: '4-5',
    name: '4 To 5 PM',
  ),
  Timeappointment(
    id: '5-6',
    name: '5 To 6 PM',
  ),
];

class Actiontype {
  String? name;
  String? id;

  Actiontype({
    this.name,
    this.id,
  });
}

List<Actiontype> actiontype = [
  Actiontype(
    id: '1',
    name: "University Visit",
  ),
  Actiontype(
    id: '2',
    name: "Go Fair",
  ),
  // Actiontype(
  //   id: '3',
  //   name: "Office Walk in",
  // ),
];
