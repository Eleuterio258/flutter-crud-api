import 'package:flutter/material.dart';
import 'package:flutter_crud_api/helpers/database_helper.dart';
import 'package:flutter_crud_api/main.dart';
import 'package:flutter_crud_api/models/contact.dart';
import 'package:flutter_crud_api/pages/home_page.dart';
class AddPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AddPageState();
  }
}

class AddPageState extends State<AddPage> {
  var textEditingControllerName = new TextEditingController();
  var textEditingControllerPhone = new TextEditingController();
  var textEditingControllerDescription = new TextEditingController();
  var textEditingControllerEmail = new TextEditingController();
  var textEditingControllerAdress = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Add Contact"),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Name"),
                    controller: textEditingControllerName,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Phone"),
                    controller: textEditingControllerPhone,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Adress"),
                    controller: textEditingControllerAdress,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Email"),
                    controller: textEditingControllerEmail,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Description"),
                    controller: textEditingControllerDescription,
                    maxLines: 5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        child: Text("Save"),
                        onPressed: () async {
                          var contact = new Contact(
                            name: textEditingControllerName.text,
                            description: textEditingControllerDescription.text,
                            phone: textEditingControllerPhone.text,
                            address: textEditingControllerAdress.text,
                            email: textEditingControllerEmail.text,
                          );
                          var db = DatabaseHelper();
                          await db.create(contact);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ));
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 5,
                        right: 5,
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyApp(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
