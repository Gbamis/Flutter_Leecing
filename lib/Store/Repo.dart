import 'dart:async';
import '../Models/propertyModel.dart';
import '../constants.dart';

class Repo{
    List<PropertyModel> data;
    StreamController<List<PropertyModel>> sc = StreamController();

    PropertyModel pm1 = PropertyModel(
        pCity:"Kaduna",pAmount:"\$40",pType:"Housing",
    );
    PropertyModel pm2 = PropertyModel(
        pCity:"lokoja",pAmount:"\$400",pType:"Electronics",
    );
    PropertyModel pm3 = PropertyModel(
        pCity:"abuja",pAmount:"\$30",pType:"Automobile",
    );

    Repo(){
        data = List<PropertyModel>();
        data.add(pm1);
        data.add(pm2);
        data.add(pm3); 
        
        sc.sink.add(data);
    }
}