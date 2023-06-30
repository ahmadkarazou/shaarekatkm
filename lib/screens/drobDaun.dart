import 'package:flutter/material.dart';
 
List<String> list = <String>[
  'كل الفئات',
  'السيارت',
  'العقارات',
  'الجمال والصحة',
  'المنزل',
  'خدمات الاعمال',
  'الحفلات',
  'اطعمة ومشروبات',
  'هدايا',
  'التعليم',
  'الكترونيات',
  'اخري',
];
class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({Key key}) : super(key: key);

  @override
  State<DropdownButtonExample> createState() => DropdownButtonExampleState();
}

class DropdownButtonExampleState extends State<DropdownButtonExample> {
 
 String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      borderRadius: BorderRadius.circular(20),
      value: dropdownValue,
      icon: const Icon(Icons.arrow_forward_ios_sharp),
      isExpanded: true,
      elevation: 16,
      style: const TextStyle(color: Colors.blue, fontSize: 20),
      underline: Container(
        color: Colors.blue,
      ),
      onChanged: (String value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}