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
