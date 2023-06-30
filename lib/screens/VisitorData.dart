import 'dart:convert';
import 'dart:io';

//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:shaarekatkm/screens/home.dart';

import '../providers/aoth.dart';
import '../providers/userData.dart';

class VisitorData extends StatefulWidget {
  @override
  State<VisitorData> createState() => _VisitorDataState();
}

class _VisitorDataState extends State<VisitorData> {
  // final auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _formKey = GlobalKey();
  bool userIsOrg = isOrg;
  String name = '';
  String email = '';
  String password = '';
  String user = '';
  String numberPhone = '';
  String  urlImage ='';

  bool isChecked = false;
  final _paswordController = TextEditingController();

  File _image;

  static bool get isOrg => null;

  // Future<void> _inputData() async {
  //   const String url =
  //       "https://sharekatcom-default-rtdb.firebaseio.com/Orgintion.json";
  //   http.post(
  //     url,
  //     body: json.encode({
  //       'id': user,
  //       'name': name,
  //       'email': email,
  //       'numberPhone': numberPhone,
  //       'UrlImage': urlImage,
  //     }),
  //   );
  // }
 

  Future<void> _submit() async {
    
    print('=========================================');
    if (!_formKey.currentState.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();
    _formKey.currentState.save();
await _uploadImage();
    try {

      await Provider.of<Auth>(context, listen: false).signUp(email, password);

      user = Provider.of<Auth>(context, listen: false).userId;

      await Provider.of<UserDatas>(context, listen: false).addData(
        idUser: user,
        email: email,
        name: name,
        numberPhone: numberPhone,
        imageUrl: urlImage,
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        Home.routeName,
        (route) => false,
      );

      // var userP =Provider.of<UserData>(context);
      // userP.email=email;
      // userP.name=name;
      // userP.numberPhone=numberPhone;
      // userP.urlImage=urlImage;

    } on HttpException catch (error) {
      var errorMessage = 'Authentcation failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address.';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }

      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('okay!'),
          )
        ],
      ),
    );
  }

  Future getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'انشاء حساب جديد ',
          style: TextStyle(fontSize: 25, color: Colors.black),
          textAlign: TextAlign.right,
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                 const SizedBox(height: 10),
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
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'الاسم الكامل',
                    counterStyle: TextStyle(color: Colors.blue),
                    labelStyle: TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  keyboardType: TextInputType.text,
                  style: const TextStyle(fontSize: 20, color: Colors.blue),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'يرجا ادخال الاسم ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'رقم الهاتف',
                    counterStyle: TextStyle(color: Colors.blue),
                    labelStyle: TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    numberPhone = value;
                  },
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 20, color: Colors.blue),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'يرجا ادخال رقم الهاتف';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'البريد الالكتروني',
                    counterStyle: TextStyle(color: Colors.blue),
                    labelStyle: TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    email = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(fontSize: 20, color: Colors.blue),
                  validator: (value) {
                    if (value.isEmpty ||
                        !value.contains('@') ||
                        !value.contains('.')) {
                      return 'القيم المدخلة ليست عنوان بريد إلكتروني صحيح';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: _paswordController,
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: const InputDecoration(
                    labelText: 'كلمة المرور',
                    counterStyle: TextStyle(color: Colors.blue),
                    labelStyle: TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    password = value;
                  },
                  keyboardType: TextInputType.text,
                  style: const TextStyle(fontSize: 20, color: Colors.blue),
                  validator: (value) {
                    if (value.isEmpty || value.length < 8) {
                      return 'يرجى توفير قيمة صحيحة.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: const InputDecoration(
                    labelText: 'التاكد كلمة المرور',
                    counterStyle: TextStyle(color: Colors.blue),
                    labelStyle: TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  style: const TextStyle(fontSize: 20, color: Colors.blue),
                  validator: (value) {
                    if (value != _paswordController.text) {
                      return 'كلمات المرور غير متطابقة!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: _submit,
                      child: const Text(
                        'انشاء حساب',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(200, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
