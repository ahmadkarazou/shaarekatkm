// ignore_for_file: public_member_api_docs, sort_constructors_first
//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shaarekatkm/providers/Organtion.dart';
import 'package:shaarekatkm/screens/updet.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/aoth.dart';
//import 'package:provider/provider.dart';
//import 'package:shaarekatkm/providers/Organtion.dart';

class OrgPage extends StatefulWidget {
  static const routeName = '/OrgPage';

  final dynamic keyData;

  const OrgPage(this.keyData, {Key key}) : super(key: key);
  @override
  State<OrgPage> createState() => _OrgPageState();
}

class _OrgPageState extends State<OrgPage> {
  String nameOrg = 'nameOrg';
  String namberAoth = 'namberAoth';
  String occupation = 'occupation';
  String dscrebshan = 'dscrebshan';
  String linkWebsaed = 'https://www.britishcouncil.jo/english';
  String linkFasebook = 'https://www.britishcouncil.jo/english';
  String idUser = '';
  String user = '';

  String imageUrl =
      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg';

  // Query dbRef = FirebaseDatabase.instance.reference().child('combane/$id');
  int ratinge = 1;
  getData(String id) async {
    final DatabaseReference ref = FirebaseDatabase.instance.reference();
    final DataSnapshot snapshot = await ref.child('combane/$id').once();

    if (snapshot.value != null) {
      setState(() {
        var userData = snapshot.value;
        //  print('اسم المستخدم: $nameUser');
        // print('العمر: $emailUser');
        nameOrg = userData['nameCategre'];
        namberAoth = userData['commNumber'];
        occupation = userData['employment'];
        dscrebshan = userData['description'];
        linkWebsaed = userData['wbeUrl'];
        linkFasebook = userData['faseUrl'];
        imageUrl = userData['imageUrl'];
        idUser = userData['idUser'];
      });
    } else {
      print('No data available.');
    }
  }

  String myData;
  @override
  void initState() {
    super.initState();
    user = Provider.of<Auth>(context, listen: false).userId;
    myData = widget.keyData;
    print('===================$myData');
    getData(myData);
  }

  GlobalKey<ScaffoldState> scaffoldKey =GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var orgRatinge =5;

    return Scaffold(
      key:scaffoldKey,
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(nameOrg),
            background: Hero(
              tag: ' loadedProduct.id',
              child: Image.network(
                imageUrl,
                //loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const SizedBox(height: 10),
              const Text(
                'صحةجميع المعلومات الخاصة بالعمل تقع تحت مسؤولية صاحب العمل ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'رقم السجل التجاري او العمل الحر',
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      namberAoth,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'مجال العمل ',
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      occupation,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'نبذة عن العمل ',
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      dscrebshan,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'منصات التواصل ',
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () => Utils.openLink(url: linkWebsaed),
                            icon: const Icon(
                              Icons.language,
                              size: 40,
                            )),
                        IconButton(
                            onPressed: () => Utils.openLink(url: linkFasebook),
                            icon: const Icon(
                              Icons.facebook,
                              size: 40,
                            ))
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              (user == idUser)
                  ? Container()
                  : Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'تقيم الشركة',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                size: 40,
                                color: (orgRatinge >= 1)
                                    ? Colors.yellow.shade400
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.star,
                                size: 40,
                                color: (orgRatinge >= 2)
                                    ? Colors.yellow.shade400
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.star,
                                size: 40,
                                color: (orgRatinge >= 3)
                                    ? Colors.yellow.shade400
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.star,
                                size: 40,
                                color: (orgRatinge >= 4)
                                    ? Colors.yellow.shade400
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.star,
                                size: 40,
                                color: (orgRatinge >= 5)
                                    ? Colors.yellow.shade400
                                    : Colors.grey,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
              (user == idUser) ? Container() : const SizedBox(height: 10),
              (user == idUser)
                  ? Container()
                  : Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            'اضافة تقيم',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.right,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    ratinge = 1;
                                  });
                                },
                                icon: Icon(
                                  Icons.star,
                                  size: 40,
                                  color: (ratinge >= 1)
                                      ? Colors.yellow.shade400
                                      : Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 5),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    ratinge = 2;
                                  });
                                },
                                icon: Icon(
                                  Icons.star,
                                  size: 40,
                                  color: (ratinge >= 2)
                                      ? Colors.yellow.shade400
                                      : Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 5),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    ratinge = 3;
                                  });
                                },
                                icon: Icon(
                                  Icons.star,
                                  size: 40,
                                  color: (ratinge >= 3)
                                      ? Colors.yellow.shade400
                                      : Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 5),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    ratinge = 4;
                                  });
                                },
                                icon: Icon(
                                  Icons.star,
                                  size: 40,
                                  color: (ratinge >= 4)
                                      ? Colors.yellow.shade400
                                      : Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 5),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    ratinge = 5;
                                  });
                                },
                                icon: Icon(
                                  Icons.star,
                                  size: 40,
                                  color: (ratinge >= 5)
                                      ? Colors.yellow.shade400
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              var snackbar = SnackBar(
                                content: const Text(
                                  "تم التقييم",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Colors.blue.shade50,
                              );
                              scaffoldKey.currentState.showSnackBar(snackbar);
                            },
                            child: const Text('حفظ'),
                          ),
                          const SizedBox(height: 10)
                        ],
                      ),
                    ),
              (user == idUser) ? Container() : const SizedBox(height: 10),
              (user == idUser)
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            'تعديل على المعلومات او حذفها',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.right,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UpdetOrg(myData)));
                                  },
                                  child: const Text('تعديل')),
                              ElevatedButton(
                                  onPressed: () async {
                                    final DatabaseReference ref =
                                        FirebaseDatabase.instance.reference();
                                    await ref.child('combane/$myData').remove();
                                    
                                    var snackbar = SnackBar(
                                content: const Text(
                                  "تم التقييم",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Colors.blue.shade50,
                              );
                              scaffoldKey.currentState.showSnackBar(snackbar);
                              Navigator.pop(context);
                                  },
                                  child: const Text('حذف')),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(height: 10)
                        ],
                      ),
                    )
                  : Container(),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ],
    ));
  }
}

class Utils {
  static Future openLink({@required String url}) => _launchUrl(url);

  static Future _launchUrl(String url) async {
    print(url);
    await launch(url, forceSafariVC: false, forceWebView: false);
  }
}
