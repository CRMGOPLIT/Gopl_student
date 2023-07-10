// import 'package:flutter/material.dart';

// class SecondScreen extends StatelessWidget {
//   List temp;
//   SecondScreen({super.key, required this.temp});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//           itemCount: temp.length,
//           itemBuilder: (context, index) {
//             return Builder(builder: (context) {
//               return Card(
//                 child: ListTile(
//                   leading: Text(temp[0].toString()),
//                   subtitle: Text(temp[0].toString()),
//                 ),
//               );
//             });
//           }),
//     );
//   }
// }

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  bool selected = false;
  final List<ItemModel> _chipsList = [
    ItemModel("Android", Colors.green, false),
    ItemModel("Flutter", Colors.blueGrey, false),
    ItemModel("Ios", Colors.deepOrange, false),
    ItemModel("Python", Colors.cyan, false),
    ItemModel("React JS", Colors.teal, false),
  ];

  List chiparray = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Filter Chip Demo"),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              // Image.asset(
              //   "assets/logo.png",
              //   height: 300,
              //   width: 350,
              // ),
              Wrap(
                spacing: 8,
                direction: Axis.horizontal,
                children: filterChipsList(),
              ),
              Text("$chiparray")
            ],
          ),
        ));
  }

  List<Widget> filterChipsList() {
    List<Widget> chips = [];
    for (int i = 0; i < _chipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: FilterChip(
          label: Text(_chipsList[i].label),
          labelStyle: const TextStyle(color: Colors.white, fontSize: 16),
          backgroundColor: _chipsList[i].color,
          selected: _chipsList[i].isSelected,
          onSelected: (bool value) {
            setState(() {
              _chipsList[i].isSelected = value;
              if (chiparray.contains(_chipsList[i].label)) {
                chiparray.remove(_chipsList[i].label);
              } else {
                chiparray.add(_chipsList[i].label);
              }
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}

class ItemModel {
  String label;
  Color color;
  bool isSelected;

  ItemModel(this.label, this.color, this.isSelected);
}
