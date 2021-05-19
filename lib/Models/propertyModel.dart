import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyModel{
    String pCity,pAmount,pType,pContact,pAbout,pTitle;
    List<dynamic> pImages;

    PropertyModel({this.pCity,this.pAmount,this.pType,this.pContact,this.pAbout,this.pTitle,this.pImages});

    factory PropertyModel.fromDoc(DocumentSnapshot docShot){
      return PropertyModel(
        pCity:docShot['city'],
        pAmount:docShot['amount'],
        pType:docShot['pType'],
        pContact:docShot['ownerContact'],
        pAbout:docShot['about'],
        pTitle:docShot['title'],
        pImages:docShot['picDataArray'],
      );
    }
}