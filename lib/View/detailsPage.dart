import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import '../widget/myWidget.dart';
import '../Models/propertyModel.dart';
import '../constants.dart';

class DetailsPage extends StatefulWidget {
  PropertyModel pM;
  List<List<int>> images = [];

  DetailsPage({Key key, this.pM}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  double _h, _w;
  bool open = false;
  
  @override
  void initState(){
    super.initState();
    widget.pM.pImages.forEach((f){
      List<int> data = base64Decode(f);
      widget.images.add(data);
    });
    
    print(widget.images.length);
    print(widget.pM.pImages.length);
  }
  @override
  Widget build(BuildContext con) {

      Future.delayed(
            Duration(milliseconds: 500),
            (){
                setState((){
                    open=true;
                });
                }
      );

    return Scaffold(
      body: Center(child: _page(con)),
    );
  }

  Widget _page(BuildContext con) {
    var screen = MediaQuery.of(con).size;
    _h = screen.height;
    _w = screen.width;

    return Stack(children: <Widget>[
      Positioned(
        child: Container(height: _h),
      ),
      Positioned(
        child: backgroundImage(_w, _h-(_h/5)),
      ),
      Positioned(
          top: 40,
          left: 20,
          width: 50,
          height:50,
          child: Card(
            color:Colors.white,
            shape:RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(10),
            ),
            child:IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: control,
              iconSize: 20,
              onPressed: () {
                Navigator.pop(con);
              }
          )
          )),

      /*AnimatedPositioned(
          duration:Duration(milliseconds: 500,),
          curve:Curves.elasticOut,
          top: _h/4,
          left:open? 20 : _w,
          child: _title(),
      ),*/
      AnimatedPositioned(
          duration:Duration(milliseconds: 500,),
          curve:Curves.elasticOut,
          top: _h/5,
          left:open? 20 : _w,
          child: _location(),
      ),
      AnimatedPositioned(
          top:open?_h-(_h/5):_h,
          left:-5,
          duration:Duration(milliseconds: 1000, ),
          curve:Curves.elasticOut,
          child:_baseCardMin(_h,_w)
      )
    ]);
  }

  Widget _title() {
    return Container(
        child: Center(
      child: Text("${widget.pM.pTitle}",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )),
    ));
  }

   Widget _location() {
    return Container(
        child: Center(
      child: Text("${widget.pM.pCity}",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )),
    ));
  }

Widget backgroundImage3(double screenW, double screenH) {
    return SizedBox(
      width: screenW,
      height: screenH,
      child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
          Container(width: screenW, child: Image.network(bgUrl, fit: BoxFit.cover)),
        ],
      ),
    );
  }
  Widget backgroundImage2(double screenW, double screenH) {
    return SizedBox(
      width: screenW,
      height: screenH,
      child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
          Container(width: screenW, child: Image.network(bgUrl, fit: BoxFit.cover)),
          Container(width: screenW, child: Image.network(img2, fit: BoxFit.cover)),
        ],
      ),
    );
  }

   Widget backgroundImage(double screenW, double screenH) {
    return SizedBox(
      width: screenW,
      height: screenH,
      child: ListView(scrollDirection: Axis.horizontal, 
                children: widget.images.map((r){
                  //List<int> data = base64Decode(r);
                  return Container(width: screenW, 
                  child: (r==null)? CircularProgressIndicator() :Image.memory(r, fit: BoxFit.cover));
                }).toList()
      ),
    );
  }

   Widget _baseCardMin(double h,double w){
      return Container(
          height:h/5,
          width:w+9,
          child:Card(
              child:Container(
                margin:EdgeInsets.fromLTRB(40,10,40,10),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children:<Widget>[
                    Text("${widget.pM.pTitle}",style:TextStyle(color:title,fontSize:30,fontWeight:FontWeight.bold)),
                    Expanded(
                      flex:1,
                      child:Text("${widget.pM.pAbout}",style:TextStyle(color:title,fontSize:15,fontWeight:FontWeight.bold)),
                    ),
                    Row(
                      children:<Widget>[
                        Expanded(
                           child:Image.asset('assets/images/nairaLogoBlack.png',width:30,height:30)
                          ),
                          
                         Expanded(
                           flex:2,
                           child:Text("${widget.pM.pAmount}",
                           style:TextStyle(color:title,fontSize:30,fontWeight:FontWeight.bold))
                          ),

                          Expanded(
                          flex:3,
                          child:FloatingActionButton.extended(
                              label:Text("Call Owner"),
                              icon:Icon(Icons.call),
                              backgroundColor:control,
                              onPressed:(){}
                              )
                          ),
                      ]
                    ),

                  ]
                ),
              ),
              shape:RoundedRectangleBorder(
                  borderRadius:BorderRadius.only(
                      topLeft:Radius.circular(0),
                      topRight:Radius.circular(0),
                  )
              ),
          ),
      );
  }

  Widget _baseCard(double h,double w){
      return Container(
          height:h/4,
          width:w,
          child:Card(
              child:Row(
                  children:<Widget>[
                      Expanded(
                          flex:1,
                          child:SizedBox(width:20)
                      ),
                      Expanded(
                          flex:2,
                          child:Text("N${widget.pM.pAmount}",
                          style:TextStyle(fontSize:30,fontWeight:FontWeight.bold))
                      ),
                      Expanded(
                          flex:3,
                          child:FloatingActionButton.extended(
                              label:Text("Call Owner"),
                              icon:Icon(Icons.call),
                              backgroundColor:control,
                              onPressed:(){}
                          )
                      ),
                      Expanded(
                          flex:1,
                          child:SizedBox(width:20)
                      ),
                  ]
              ),
              shape:RoundedRectangleBorder(
                  borderRadius:BorderRadius.only(
                      topLeft:Radius.circular(40),
                      topRight:Radius.circular(40),
                  )
              ),
          ),
      );
  }
}
