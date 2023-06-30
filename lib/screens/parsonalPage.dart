import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shaarekatkm/screens/input_Org.dart';
import 'package:shaarekatkm/screens/orgPage.dart';
import 'package:shaarekatkm/widgets/app_drawer.dart';

import '../providers/aoth.dart';
import '../providers/userData.dart';

class ParsonalPage extends StatefulWidget {
  const ParsonalPage({Key key}) : super(key: key);

  @override
  State<ParsonalPage> createState() => _ParsonalPageState();
  static const routeName = '/ParsnalPage';
}

class _ParsonalPageState extends State<ParsonalPage> {
  Reference referenceRoot = FirebaseStorage.instance.ref();
  String idUser;
  
   String nameUser = 'محمود احمد';
  String emailUser = 'ahmad@gmail.com';
  bool isCom=false;

  
  getData(String id)async{
     final DatabaseReference ref = FirebaseDatabase.instance.reference();
  final DataSnapshot snapshot = await ref.child('UserData').orderByChild('idUser').equalTo(id).once();

  if (snapshot.value != null) {
    Map<dynamic, dynamic> userData = snapshot.value;
    userData.forEach((key, value) {setState(() {
       nameUser = value['name'];
       emailUser = value['email'];
       imageUrl=value['UrlImage'];
       isCom=value['isCombane'];
      print('اسم المستخدم: $nameUser');
      print('العمر: $emailUser');
    });
      
    });
  } else {
    print('No data available.');
  }

// Additional code if needed

    var Data=Map();
    String cat = Data['idUser'];
   if (cat==idUser) {
     nameUser=Data['name'];
     emailUser=Data['email'];
     imageUrl=Data['UrlImage'];
     print('=============$idUser');
    // print('email${Data['email']}');
     //print(Data['idUser']);
    // print(Data['name']);
   }
  }
   
  @override
  void initState() {
    super.initState();
    idUser=Provider.of<Auth>( context,listen: false).userId;
    String keyUser=Provider.of<UserDatas>(context,listen: false).key;
    print('=====================$idUser');
    getData(idUser);
  }
  
  // List<String> orgName = [
  //   'ابجد',
  //   'موضوع ',
  // ];
  // List<String> orgUnit = ['الثقافة', 'صناعة محتوى '];
  // List<String> orgImage = [
  //   'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/Logo-Abjjad.png/130px-Logo-Abjjad.png',
  //   'https://cdn6.aptoide.com/imgs/b/3/6/b36d2fc648c375ef68342f140a1fe4e2_icon.png',
  // ];

  String imageUrl =
      'https://png.pngtree.com/png-vector/20220709/ourmid/pngtree-businessman-user-avatar-wearing-suit-with-red-tie-png-image_5809521.png';
  
  Query dbRef = FirebaseDatabase.instance.reference().child('combane');

  Widget listCombane(Map combane) {
 //print('idcom${combane['idUser']}');
     if (idUser==combane['idUser']) {
      return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.blue.shade100),
      child: GestureDetector(
        onTap: () {
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
  }else{return Container();}
    }


 
  Future<String> getFullImageUrl(String imagePath) async {
    Reference storageRef = FirebaseStorage.instance.ref().child(imagePath);
    String downloadURL = await storageRef.getDownloadURL();
    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
   // print('==========================');
   //print(idUser);
    bool _islodeng = true;


//rovider.of<UserData>(context).imageUrl;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الصفحة الشخصية',
          style: TextStyle(fontSize: 25, color: Colors.black),
          textAlign: TextAlign.right,
        ),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(15),
        // color: Colors.amber,
        child: Column(
          children: [
            const SizedBox(height: 5),
            Image(
              width: 150,
              height: 150,
              image: NetworkImage(
                   
                  imageUrl
                  

                  ),
            ),
            const SizedBox(height: 5),
            Text(
              nameUser,
              // userData.name,
              style: const TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
             emailUser,
              //userData.email,
              style: const TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
           (isCom)? ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(InpoutOrg.routeName),
              child: const Text(
                'اضافة شركةاو خدمة',
                style: TextStyle(fontSize: 25, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(250, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ):Container(),
            const SizedBox(height: 5),
            Builder(
              builder: (stx) {
                return Expanded(
                  child: FirebaseAnimatedList(
                    query: dbRef,
                    itemBuilder: (
                      BuildContext stx,
                      DataSnapshot snapshot,
                      Animation<double> animation,
                      int index,
                    ) {
                      Map combane = snapshot.value as Map;
                      combane['key'] = snapshot.key;
                      return listCombane(combane);
                    },
                  ),
                );
              }
            ),
            // Expanded(
            //   child: ListView.builder(
            //       itemCount: orgName.length,
            //       itemBuilder: (context, index) {
            //         return Container(
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(20),
            //               color: Colors.blue.shade100),
            //           margin: EdgeInsets.all(5),
            //           child: GestureDetector(
            //             onTap: () => Navigator.of(context)
            //                 .pushNamed(OrgPage.routeName, arguments: index),
            //             child: Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Row(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                     crossAxisAlignment: CrossAxisAlignment.center,
            //                     mainAxisSize: MainAxisSize.max,
            //                     children: [
            //                       Text(orgUnit[index].toString(),
            //                           style: const TextStyle(
            //                               fontWeight: FontWeight.bold,
            //                               fontSize: 15)),
            //                       Text(orgName[index].toString(),
            //                           style: const TextStyle(
            //                               fontWeight: FontWeight.bold,
            //                               fontSize: 20)),
            //                       Image(
            //                         width: 75,
            //                         height: 75,
            //                         image: NetworkImage(
            //                           orgImage[index].toString(),
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         );
            //       }),
            // ),
          ],
        ),
      ),
    );
  }
}

class Data {}
