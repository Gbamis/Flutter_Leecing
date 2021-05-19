import "package:cloud_firestore/cloud_firestore.dart";
import 'dart:async';

class FirestoreAPI{

 CollectionReference propertyCollection;

  FirestoreAPI(){
    propertyCollection = Firestore.instance.collection("Properties");
  }
  Future <String> addProperty(DateTime stamp,
                              String title,
                              String city,String pType,
                              String amount,String about,
                              List<String> picData,
                              String ownerContact)async{
    await propertyCollection.add(
      {
        'timeStamp':stamp,
        'title':title,
        'city':city,
        'amount':amount,
        'about':about,
        'pType':pType,
        'ownerContact':ownerContact,
        'picDataArray':picData,
      }
    );
    return 'done';
  }
  
  
}