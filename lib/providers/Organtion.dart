import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shaarekatkm/screens/input_Org.dart';

class Organtion {
  final String id;
  final String idUser;
  final String nameCombane;
  final String employment;
  final String description;
  final String commNumber;
  final String imageUrl;
  final String webUrl;
  final String fesUrl;

  final String category;

  Organtion(
      {this.id,
      this.nameCombane,
      this.description,
      this.commNumber,
      this.imageUrl,
      this.fesUrl,
      this.webUrl,
      this.category,
      this.employment,
      this.idUser});
}

class Organtions with ChangeNotifier {
  List<Organtion> organtionList = [];
  String authToken = '';
  String id;
  //Products(this.authToken, this.productsList);
  getData(String authTok, List<Organtion> products) {
    authToken = authTok;
    organtionList = products;
    notifyListeners();
  }
//   Future<void> getIetim(id)async{
//    String url = "https://sharekatcom-default-rtdb.firebaseio.com/combane/$id.json";
//    try {
// final http.Response res=await http.get(url);
// final extractedData=json.decode(res.body,);
//    } catch (e) {
//    }
//   }

  Future<void> fetchData() async {
    const url = "https://sharekatcom-default-rtdb.firebaseio.com/product.json";
    try {
      final http.Response res = await http.get(url);
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      extractedData.forEach((prodId, prodData) {
        final prodIndex =
            organtionList.indexWhere((element) => element.id == prodId);
        if (prodIndex >= 0) {
          organtionList[prodIndex] = Organtion(
              id: prodId,
              employment: prodData['employment'],
              idUser: prodData['idUser'],
              nameCombane: prodData['nameCombane'],
              description: prodData['description'],
              commNumber: prodData['commNumber'],
              imageUrl: prodData['imageUrl'],
              webUrl: prodData['webUrl'],
              fesUrl: prodData['fesUrl'],
              category: prodData['category']);
        } else {
          organtionList.add(Organtion(
              id: prodId,
              idUser: prodData['idUser'],
              nameCombane: prodData['nameCombane'],
              description: prodData['description'],
              commNumber: prodData['commNumber'],
              imageUrl: prodData['imageUrl'],
              webUrl: prodData['webUrl'],
              fesUrl: prodData['fesUrl'],
              category: prodData['category']));
        }
      });

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateData(String id) async {
    final url =
        "https://sharekatcom-default-rtdb.firebaseio.com/combane/$id.json";

    final prodIndex = organtionList.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      await http.patch(Uri.parse(url),
          body: json.encode({
            "title": "new title 4",
            "description": "new description 2",
            "price": 199.8,
            "imageUrl":
                "https://cdn.pixabay.com/photo/2015/06/19/21/24/the-road-815297__340.jpg",
          }));

      organtionList[prodIndex] = Organtion(
        id: id,
        nameCombane: "new title 4",
        description: "new description 2",
        commNumber: 22222.toString(),
        imageUrl:
            "https://cdn.pixabay.com/photo/2015/06/19/21/24/the-road-815297__340.jpg",
      );

      notifyListeners();
    } else {
      print("...");
    }
  }

  Future<void> add(
      {String id,
      String idUser,
      String nameCategre,
      String employment,
      String description,
      String commNumber,
      String imageUrl,
      String wbeUrl,
      String faseUrl,
      String category}) async {
    const url = "https://sharekatcom-default-rtdb.firebaseio.com/combane.json";
    try {
      http.Response res = await http.post(url,
          body: json.encode({
            "id": id,
            "idUser": idUser,
            "employment": employment,
            "nameCategre": nameCategre,
            "description": description,
            "commNumber": commNumber,
            "imageUrl": imageUrl,
            "wbeUrl": wbeUrl,
            "faseUrl": faseUrl,
            "dropdownValue": category
          }));
      print(json.decode(res.body));

      organtionList.add(Organtion(
        id: json.decode(res.body)['name'],
        employment: employment,
        nameCombane: nameCategre,
        description: description,
        commNumber: commNumber,
        imageUrl: imageUrl,
        webUrl: wbeUrl,
        fesUrl: faseUrl,
        category: category,
      ));
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  

  Future<void> delete(String id) async {
    final url =
        "https://sharekatcom-default-rtdb.firebaseio.com/combane/$id.json";

    final prodIndex = organtionList.indexWhere((element) => element.id == id);
    Organtion prodItem = organtionList[prodIndex];
    organtionList.removeAt(prodIndex);
    notifyListeners();

    var res = await http.delete(Uri.parse(url));
    if (res.statusCode >= 400) {
      organtionList.insert(prodIndex, prodItem);
      notifyListeners();
      print("Could not deleted item");
    } else {
      prodItem = null;
      print("Item deleted");
    }
  }
}
