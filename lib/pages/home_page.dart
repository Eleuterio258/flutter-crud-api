import 'package:flutter/material.dart';
import 'package:flutter_crud_api/helpers/database_helper.dart';
import 'package:flutter_crud_api/helpers/synchronization_data.dart';
import 'package:flutter_crud_api/models/contact.dart';
import 'package:flutter_crud_api/pages/add.dart';
import 'package:flutter_crud_api/pages/details.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future isInternet() async {
    await SynchronizationData.isInternet().then((conection) {
      if (conection) {
        print("object");
      } else {
        Get.snackbar('error', 'Error');
      }
    });
  }

  var db = new DatabaseHelper();
  List contacto;
  bool isLload = false;
  Future contactoList() async {
    contacto = await db.finfAll();
    setState(() {
      isLload = true;
    });
  }

  Future synToMysql() async {
    await SynchronizationData().fechAllsInfo().then((contactoList) async {
      EasyLoading.show(status: "dontt close");
      await SynchronizationData().savetoMysl(contactoList);
      EasyLoading.showSuccess("status");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQLITE"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPage(),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () async {
              await SynchronizationData.isInternet().then(
                (conection) {
                  if (conection) {
                    synToMysql();
                    print("internet available");
                  } else {
                    Get.snackbar('error', 'Error');
                  }
                },
              );
            },
            icon: Icon(Icons.add),
          ),
          /*  IconButton(
            onPressed: () async {
              await SynchronizationData.isInternet().then((conection){ 
                    if (conection)
                      {print("internet available");}
                    else
                      {EasyLoading.show(status: "dontt close");}
                  });},

              icon: Icon(Icons.refresh_sharp),
            
          */
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: FutureBuilder<List>(
          future: db.finfAll(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Contact contact = Contact.fromJson(snapshot.data[index]);
                  return Card(
                    child: ListTile(
                      title: Text(contact.name),
                      subtitle: Text(contact.phone),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContactDetailsPage(
                                contact: contact,
                              ),
                            ));
                      },
                    ),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
