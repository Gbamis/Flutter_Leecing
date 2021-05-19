import 'dart:io';
import 'dart:async';
import 'dart:convert';

//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:image_picker/image_picker.dart";

import 'package:leecit/constants.dart';
import '../widget/myWidget.dart';
import '../Store/firestoreAPI.dart';

class AddPage extends StatefulWidget {
  //TextEditingController test, titleCon, locCon, amountCon, typeCon, descCon, phoneCon;
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final test = TextEditingController();
  final titleCon = TextEditingController();
  final locCon = TextEditingController();
  final amountCon = TextEditingController();
  final typeCon = TextEditingController();
  final descCon = TextEditingController();
  final phoneCon = TextEditingController();

  final nameController = TextEditingController();
  final locController = TextEditingController();
  final amountController = TextEditingController();
  //final typeController = TextEditingController();
  final desController = TextEditingController();
  final phoneController = TextEditingController();

  List<String> pTypes = ["Automible", "Electronics", "Housing"];
  List<File> photos = [];
  List<String> photoUrls = [];

  String mType;
  File _image1;
  File _image2;
  File _image3;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FirestoreAPI API;
  //FirebaseStorage storage;
  BuildContext cont;

  bool isSubmitting = false;

  @override
  void initState() {
    API = FirestoreAPI();
    //storage = FirebaseStorage.instance;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext con) {
    cont = con;
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(child: _pageMain()),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.edit),
          label: isSubmitting ? Text("Please wait......") : Text("Submit"),
          heroTag: 'nav',
          backgroundColor: control,
          onPressed: () {
            try {
              if (isSubmitting == false) {
                submit(con);
              }
            } catch (e) {
              print(e);
            }
          }),
    );
  }

  Widget _snackBar() {
    return SnackBar(
      content: Text("Added"),
      duration: Duration(seconds: 2),
    );
  }

  Widget _heading() {
    return Container(
      child: Text("Add Properties",
          style: TextStyle(
              color: Colors.grey[600],
              fontSize: 70,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _photoSection(BuildContext con) {
    return Row(
      children: <Widget>[
        Expanded(
          child: PhotoCard(
              onPictureTaken: (file) {
                if (photos.contains(file)) {
                  return;
                } else {
                  photos.add(file);
                }
              },
              mWidth: 50,
              mHeight: 180),
        ),
        Expanded(
          child: PhotoCard(
              onPictureTaken: (file) {
                if (photos.contains(file)) {
                  return;
                } else {
                  photos.add(file);
                }
              },
              mWidth: 50,
              mHeight: 180),
        ),
        Expanded(
          child: PhotoCard(
              onPictureTaken: (file) {
                if (photos.contains(file)) {
                  return;
                } else {
                  photos.add(file);
                }
              },
              mWidth: 50,
              mHeight: 180),
        ),
      ],
    );
  }

  Future<String> processImages() async {
    setState(() {
      isSubmitting = true;
    });

    photos.forEach((f) {
      processPic(f);
    });
    return 'processed';
  }

  void processPic(File pic) async {
    List<int> picBytes = pic.readAsBytesSync();
    String encoded = base64Encode(picBytes);
    photoUrls.add(encoded);
  }

  void uploadPic(File pic) async {
    /* StorageReference storeRef = storage.ref().child('images/');
    StorageUploadTask upload = storeRef.putFile(pic);

    Uri location = (await upload.future).downloadUrl;
    photoUrls.add(location.toString());
    */
  }

  void submit(BuildContext con) async {
    if (photos.length > 0) {
      processImages().then((res) {
        if (_formKey.currentState.validate()) {
          API
              .addProperty(
                  DateTime.now(),
                  nameController.text,
                  locController.text,
                  mType,
                  amountController.text,
                  desController.text,
                  photoUrls,
                  phoneController.text)
              .then((res) {
            _scaffoldKey.currentState.showSnackBar(snack);
            Future.delayed(Duration(seconds: 1), () {
              Navigator.pop(con);
            });
          });
        }
      });
    }
    else{
      _scaffoldKey.currentState.showSnackBar(snackBar("Add images of your property"));
    }
  }

  Widget _pageMain() {
    //TextEditingController titleCon, locCon, amountCon, typeCon, descCon, phoneCon;
    return Container(
        margin: EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            SizedBox(height: 30),
            _heading(),
            SizedBox(height: 30),
            MyTextInput(
              controller: nameController,
              lengthMax: 20,
              caps: TextCapitalization.words,
              hintText: "Title",
              inputType: TextInputType.text,
              myPrefIcon: Icon(Icons.location_on),
              textChanged: (value) {},
            ),
            SizedBox(height: 1),
            SizedBox(height: 1),
            Row(children: <Widget>[
              /*Expanded(
                flex: 2,
                child: ComboBox(
                    items: pTypes,
                    myPrefIcon: Icon(Icons.menu),
                    itemChanged: (value) {
                      setState(() {
                        mType = value;
                      });
                    }),
              ),*/
              Expanded(
                flex: 2,
                child: MyTextInput(
                  controller: locController,
                  caps: TextCapitalization.words,
                  lengthMax: 30,
                  hintText: "location",
                  inputType: TextInputType.text,
                  myPrefIcon: Icon(Icons.location_on),
                  textChanged: (value) {},
                ),
              ),
              Expanded(
                flex: 2,
                child: MyTextInput(
                  controller: amountController,
                  lengthMax: 11,
                  hintText: "Amount",
                  caps: TextCapitalization.sentences,
                  inputType: TextInputType.number,
                  myPrefIcon: Icon(Icons.attach_money),
                  textChanged: (value) {},
                ),
              ),
            ]),
            SizedBox(height: 1),
            MyTextInput(
              controller: desController,
              lines: 2,
              caps: TextCapitalization.sentences,
              lengthMax: 100,
              hintText: "Description (less than 100 words)",
              inputType: TextInputType.multiline,
              myPrefIcon: Icon(Icons.description),
              textChanged: (value) {},
            ),
            SizedBox(height: 1),
            MyTextInput(
              controller: phoneController,
              lengthMax: 11,
              caps: TextCapitalization.sentences,
              hintText: "Phone number",
              inputType: TextInputType.number,
              myPrefIcon: Icon(Icons.phone),
              textChanged: (value) {},
            ),
            SizedBox(height: 1),
            _photoSection(cont),
          ]),
        ));
  }
   Widget snackBar(String msg){
     return SnackBar(
       content:Text("$msg"),
       duration:Duration(seconds:1),
       backgroundColor: control,
     );
   }
  final snack = SnackBar(
    backgroundColor: Colors.blueGrey[900],
    elevation: 20,
    duration: Duration(seconds: 1),
    content: Text("property published succesfully"),
  );
}
