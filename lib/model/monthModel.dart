List Month = [
  {"Id": "1", "Name": "january"},
  {"Id": "2", "Name": "feb"},
  {"Id": "3", "Name": "march"},
  {"Id": "4", "Name": "April"},
  {"Id": "5", "Name": "GNM Nursing"},
  {"Id": "6", "Name": "MBA"},
  {"Id": "7", "Name": "MA"},
  {"Id": "8", "Name": "BA"},
  {"Id": "9", "Name": "B.Ed"},
  {"Id": "10", "Name": "B.Com"},
  {"Id": "11", "Name": "BSc"},
  {"Id": "12", "Name": "BCA"}
];

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
