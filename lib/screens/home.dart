

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shaarekatkm/screens/orgPage.dart';
import 'package:shaarekatkm/widgets/app_drawer.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
  static const routeName = '/Home';
}

String category = list.first; String falter = category;

class _HomeState extends State<Home> {
  Query dbRef = FirebaseDatabase.instance.reference().child('combane');
  Widget listCombane(Map combane) {
    String cat = combane['dropdownValue'];
    print('cat $cat');
    print('category$category');
    String falter = category;

    if (falter == cat||falter=='كل الفئات') {
      return Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue.shade100),
        child: GestureDetector(
          onTap: () {
            print('==============${combane['key']}');
            return Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  OrgPage(combane['key'])));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          combane['nameCategre'],
                          style: const TextStyle(fontSize: 25),
                        ),
                        Text(
                          combane['dropdownValue'],
                          style: const TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                    Image(
                      width: 100,
                      height: 100,
                      image: NetworkImage(
                         combane['imageUrl']),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'asset/image/logo.png',
          width: 100,
          height: 100,
        ),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: Container(
        height: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'البحث في مجال',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const DropdownButtonExample(),
            ElevatedButton(
              onPressed: () {setState(() {
                falter = category;

              });},
              child: Text(
                'بحث',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(220, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FirebaseAnimatedList(
                query: dbRef,
                itemBuilder: (
                  BuildContext context,
                  DataSnapshot snapshot,
                  Animation<double> animation,
                  int index,
                ) {
                  Map combane = snapshot.value as Map;
                  combane['key'] = snapshot.key;
                  return listCombane(combane);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//  ElevatedButton(
//               onPressed: () {},
//               child: Text(
//                 'حساب زائر',
//                 style: TextStyle(fontSize: 30, color: Colors.black),
//               ),
//               style: ElevatedButton.styleFrom(
//                 fixedSize: const Size(300, 150),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             )

List<String> list = <String>[
  'كل الفئات',
  'السيارت',
  'العقارات',
  'الجمال والصحة',
  'المنزل',
  'خدمات الاعمال',
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
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      borderRadius: BorderRadius.circular(20),
      value: category,
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
          category = value;
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
