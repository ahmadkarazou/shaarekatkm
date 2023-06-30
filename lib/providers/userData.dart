import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserData {
  final bool isOrg;
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  UserData({
    this.isOrg,
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
  });
}

class UserDatas with ChangeNotifier {
  bool _isCombane;
  String email = '';
  String name = '';
  String password = '';
  String user = '';
  String numberPhone = '';
  String imageUrl = '';
  List<UserData> productsList = [];
  String authToken = '';
  String idUserData='';
  
  //Products(this.authToken, this.productsList);
  getData(String authTok, List<UserData> products) {
    authToken = authTok;
    productsList = products;
    notifyListeners();
  }
  // Future<void> fetchData() async {
  //   final url =
  //       "https://auth1-6f5f5-default-rtdb.firebaseio.com/product.json?auth=$authToken";
  //   try {
  //     final http.Response res = await http.get(Uri.parse(url));
  //     final extractedData = json.decode(res.body) as Map<String, dynamic>;
  //     extractedData.forEach((prodId, prodData) {
  //       final prodIndex =
  //           productsList.indexWhere((element) => element.id == prodId);
  //       if (prodIndex >= 0) {
  //         productsList[prodIndex] = UserData(
  //           id: prodId,
  //           title: prodData['title'],
  //           description: prodData['description'],
  //           price: prodData['price'],
  //           imageUrl: prodData['imageUrl'],
  //         );
  //       } else {
  //         productsList.add(UserData(
  //           id: prodId,

  //           title: prodData['title'],
  //           description: prodData['description'],
  //           price: prodData['price'],
  //           imageUrl: prodData['imageUrl'],
  //         ));
  //       }
  //     });

  //     notifyListeners();
  //   } catch (error) {
  //     print(error);
  //   }
  // }
  Future<void> setIsCombane(bool isCombane) async {
     _isCombane=isCombane;
    notifyListeners();
  }
  bool get isCombane {
    return _isCombane;
  }
String get image {
    return imageUrl;
  }
String get nameUser {
    return name;
  }
 String get key{
  return idUserData;
 }

Future<void> addData({
  String idUser,
  String name,
  String numberPhone,
  String email,
  String imageUrl,
}) async {
  const String url = "https://sharekatcom-default-rtdb.firebaseio.com/UserData.json";

  try {
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({
        'isCombane': _isCombane,
        'idUser': idUser,
        'name': name,
        'email': email,
        'numberPhone': numberPhone,
        'UrlImage': imageUrl,
      }),
    );
print(json.decode(response.body));
idUserData=json.decode(response.body);
  } catch (error) {
    print(error);
  }
}

// Future<void> fetchData() async {
//   const String url = "https://sharekatcom-default-rtdb.firebaseio.com/UserData.json";

//   try {
//     final response = await http.get(Uri.parse(url));

    
//       final data = json.decode(response.body);
//       // Process the fetched data as needed
     
//   } catch (error) {
//     print(error);
//   }
// }

  // Future<void> add(
  //     {String idUser,
  //     String name,
  //     String numberPhone,
  //     String email,
  //     String imageUrl}) async {
  //   const String url =
  //       "https://sharekatcom-default-rtdb.firebaseio.com/UserData.json";
  //   try {
  //     http.Response res = await http.post(
  //     url,
  //     body: json.encode({
  //       'isCombane':_isCombane,
  //       'idUser':idUser,
  //       'name': name,
  //       'email': email,
  //       'numberPhone': numberPhone,
  //       'UrlImage': imageUrl,
  //     }),
  //   );
    //  print(json.decode(res.body));

      // productsList.add(UserData(
      //   id: json.decode(res.body)['name'],
      //   title: title,
      //   description: description,
      //   price: price,
      //   imageUrl: imageUrl,
      // ));
    //   notifyListeners();
    // } catch (error) {
    //   print(error);
    // }
 // }
}
