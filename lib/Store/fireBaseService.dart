import "package:cloud_firestore/cloud_firestore.dart";
import 'dart:async';

class FirestoreAPI{

  static CollectionReference propertyCollection = Firestore.instance.collection("Properties");

  FirestoreAPI(){
    propertyCollection = Firestore.instance.collection("Properties");
  }
  Future<String> addProperty(String city,String pType,String amount,String about,String ownerContact)async{
    await propertyCollection.add(
      {
        'city':city,
        'amount':amount,
        'about':about,
        'pType':pType,
        'ownerContact':ownerContact,
      }
    );
    return 'done';
  }
  
  static void applySearch(String value){
	  propertyCollection = Firestore.instance.collection("Properties").where("city",isEqualTo: value);
	  print(value);
  }
  void resetCollection(){
	  propertyCollection = Firestore.instance.collection("Properties");
  }
}