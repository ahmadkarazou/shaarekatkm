import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shaarekatkm/providers/Organtion.dart';
import 'package:shaarekatkm/providers/userData.dart';
import 'package:shaarekatkm/screens/parsonalPage.dart';

import '../providers/aoth.dart';
import 'drobDaun.dart';

class InpoutOrg extends StatefulWidget {
  const InpoutOrg({Key key}) : super(key: key);

  @override
  State<InpoutOrg> createState() => _InpoutOrgState();
  static const routeName = '/InputOrg';
}

String category = list.first;

class _InpoutOrgState extends State<InpoutOrg> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String nameCategre = '';
  String employment = '';
  String details = '';
  String commercialNumber = '';
  String urlImage = '';
  String urlWop = '';
  String urlfase = '';

  File _image;
  Future getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    await _uploadImage;
    setState(() {
      _image = File(pickedFile.path);
      print(_image.path);
    });
  }

  Future<void> _uploadImage() async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('image');
    Reference referenceImageToUpload = referenceDirImage.child(uniqueFileName);

    await referenceImageToUpload.putFile(File(_image.path));
    urlImage = await referenceImageToUpload.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    String idUser = Provider.of<Auth>(context, listen: false).userId;
    print(idUser);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'معلومات الشركة',
          style: TextStyle(fontSize: 25, color: Colors.black),
          textAlign: TextAlign.right,
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              // color: Colors.amber,
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: getImage,
                      child: const Text(
                        'اختر صورة',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(200, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      )),
                  const SizedBox(height: 15),
                  _image == null
                      ? const Text(
                          'لم يتم اختيار صورة بعد.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        )
                      : Image.file(
                          _image,
                          height: 200,
                        ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'اسم الشركة',
                      counterStyle: TextStyle(color: Colors.blue),
                      labelStyle: TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all((Radius.circular(20.0))),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    onSaved: (valeu) {
                      nameCategre = valeu;
                    },
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 20, color: Colors.blue),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'لم يتم ادخال اسم الشركة';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'مجال العمل',
                      counterStyle: TextStyle(color: Colors.blue),
                      labelStyle: TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    onSaved: (valeu) {
                      employment = valeu;
                    },
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 20, color: Colors.blue),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'لم يتم ادخال مجال العمل';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'تفاصيل المنتج او الخدمة',
                      counterStyle: TextStyle(color: Colors.blue),
                      labelStyle: TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    onSaved: (valeu) {
                      details = valeu;
                    },
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 20, color: Colors.blue),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'لم يتم ادخال التفاصيل ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'رقم السجل التجاري او وثيقت العمل الحر',
                      counterStyle: TextStyle(color: Colors.blue),
                      labelStyle: TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    onSaved: (valeu) {
                      commercialNumber = valeu;
                    },
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 20, color: Colors.blue),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'لم يتم ادخال رقم الوثيقة';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'رابط الموقع',
                      counterStyle: TextStyle(color: Colors.blue),
                      labelStyle: TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    onSaved: (valeu) {
                      urlWop = valeu;
                    },
                    keyboardType: TextInputType.url,
                    style: const TextStyle(fontSize: 20, color: Colors.blue),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'لم يتم ادخال رابط الموقع';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'رابط الفيس بوك',
                      counterStyle: TextStyle(color: Colors.blue),
                      labelStyle: TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    onSaved: (valeu) {
                      urlfase = valeu;
                    },
                    keyboardType: TextInputType.url,
                    style: const TextStyle(fontSize: 20, color: Colors.blue),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'لم يتم ادخال رابط الفيس بوك';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),
                  const DropdownButtonExample(),
                  // category=DropdownButtonExampleState.;
                  const SizedBox(height: 20),
                  Consumer<Organtions>(
                    builder: (ctx, value, _) => ElevatedButton(
                      onPressed: () async {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }

                        FocusScope.of(context).unfocus();
                        _formKey.currentState.save();

                        await _uploadImage();
                        value
                            .add(
                                id: DateTime.now().toString(),
                                idUser: idUser,
                                nameCategre: nameCategre,
                                employment: employment,
                                description: details,
                                commNumber: commercialNumber,
                                imageUrl: urlImage,
                                wbeUrl: urlWop,
                                faseUrl: urlfase,
                                category: category)
                            .catchError((_) {
                          return showDialog<Null>(
                            context: context,
                            builder: (innerContext) => AlertDialog(
                              title: const Text("An error occurred!"),
                              content: const Text('Something went wrong.'),
                              actions: [
                                FlatButton(
                                    child: const Text("Okay"),
                                    onPressed: () =>
                                        Navigator.of(innerContext).pop())
                              ],
                            ),
                          );
                        });
                        Navigator.pop(context);
                        // .then((_) {
                        //   setState(() {
                        //     _isLoading = false;
                        //   });
                        //   Navigator.pop(context);
                        // });
                      },
                      child: const Text(
                        'حفظ',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(200, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
