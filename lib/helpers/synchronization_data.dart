import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_crud_api/helpers/database_helper.dart';
import 'package:flutter_crud_api/models/contact.dart';

import 'package:http/http.dart' as http;

class SynchronizationData {
  static Future<bool> isInternet() async {
    var connectivityvResult = await (Connectivity().checkConnectivity());

    if (connectivityvResult == ConnectivityResult.mobile) {
      if (await DataConnectionChecker().hasConnection) {
        print('Mobile data detected & internet connection confirmed.');
        return true;
      } else {
        print('no internet.');
        return false;
      }
    } else if (connectivityvResult == ConnectivityResult.wifi) {
      if (await DataConnectionChecker().hasConnection) {
        print('Wifi data detected & internet connection confirmed.');
        return true;
      } else {
        print('no internet.');
        return false;
      }
    } else {
      print('no  wifi  or mobile from the internet.');
      return false;
    }
  }

  final conn = DatabaseHelper.instance;
  Future<List<Contact>> fechAllsInfo() async {
    final dbClient = await conn.db;
    List<Contact> contactoList = [];
    try {
      final maps = await dbClient.query(DatabaseHelper().tableContact);
      for (var item in maps) {
        contactoList.add(Contact.fromJson(item));
        print(contactoList.length);
      }
    } catch (e) {
      print(e.toString());
    }
    return contactoList;
  }

  Future<List> fechAllCustomsInfo() async {
    final dbClient = await conn.db;
    List contactoList = [];
    try {
      final maps = await dbClient.query(DatabaseHelper().tableContact);
      for (var item in maps) {
        contactoList.add(item);
      }
    } catch (e) {
      print(e.toString());
    }
    return contactoList;
  }

  Future savetoMysl(List<Contact> contactoList) async {
    for (var i = 0; i < contactoList.length; i++) {
      Map<String, dynamic> data = {
        "id": contactoList[i].id.toString(),
        "name": contactoList[i].name,
        "phone": contactoList[i].phone,
        "email": contactoList[i].email,
        "address": contactoList[i].address,
        "description": contactoList[i].description,
      };
      var response = await http.post(
          Uri.parse(
              "http://192.168.43.204/2021/2-FEV/contacto/api/addContacto"),
          body: data);
      if (response.statusCode == 200) {
        print("Saving:Data");
      } else {
        print(response.statusCode);
      }
    }
  }
}
