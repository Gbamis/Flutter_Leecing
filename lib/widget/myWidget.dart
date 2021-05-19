import 'package:flutter/material.dart';
import "package:image_picker/image_picker.dart";

import '../constants.dart';
import '../Models/propertyModel.dart';

import 'dart:math';
import 'dart:io';
import 'dart:convert';

class MyButton extends StatelessWidget {
  VoidCallback myTap;
  Color btnColor;
  String label;
  double btnHeight;

  MyButton({this.myTap, this.btnColor, @required this.label, this.btnHeight});

  @override
  Widget build(BuildContext con) {
    return RaisedButton(
        child: Container(
          height: btnHeight,
          child: Center(
              child: Text("$label", style: TextStyle(color: Colors.white))),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: btnColor,
        onPressed: () {
          myTap();
        });
  }
}

class PropertyCard extends StatelessWidget {
  VoidCallback myTapped;
  double myH, myW;
  String pcity, pamount, ptype, pcontact, pabout,pTitle;
  int index;
  PropertyModel pm;
  List<dynamic> pCoverImage;

  PropertyCard({this.pm, this.index, this.myTapped, this.myH}) {
    pcity = pm.pCity;
    pamount = pm.pAmount;
    ptype = pm.pType;
    pcontact = pm.pContact;
    pabout = pm.pAbout;
    pTitle = pm.pTitle;
    pCoverImage = pm.pImages;

  }

  @override
  Widget build(BuildContext con) {
    return GestureDetector(
        onTap: () {
          myTapped();
        },
        child: Container(
          height: myH,
          width: myW,
          child: Card(
            child:_content(),
            clipBehavior:Clip.antiAlias,
            shape:RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(30),
            ),
          ),
        ));
  }

  Widget _content() {
    Random random = new Random(index);
    int randIndex = random.nextInt(cardColors.length);

    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(flex: 10, 
                  child: Image.memory(base64Decode(pCoverImage[0]),
                  fit: BoxFit.cover)),

          Expanded(
              flex: 1,
              child: Container(
                width:40,
                  child: Row(
                    children:<Widget>[
                      //SizedBox(width:10),
                       Expanded(
                         flex:1,
                           child:Image.asset('assets/images/nairaLogoBlack.png',width:20,height:20)
                          ),
                      Expanded(
                        flex:4,
                        child:Text("$pamount",textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 32,color:Colors.grey[600], fontWeight: FontWeight.bold))
                      ),
                    ]
                  ),
                      )
          ),

          Expanded(
              flex: 1,
              child: Container(
                width:40,
                //color:title,
                  child: Row(
                    children:<Widget>[
                      SizedBox(width:20),
                      Text("$pTitle",textAlign: TextAlign.left,
                      style: TextStyle(color:Colors.grey[600],fontSize: 15, fontWeight: FontWeight.bold))
                    ]
                  ),
                      )
          ),

          Expanded(
              flex: 1,
              child: Container(
                width:40,
                //color:title,
                  child: Row(
                    children:<Widget>[
                      SizedBox(width:20),
                      Expanded(
                        child:Text("$pcity",textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
                      )
                    ]
                  ),
                      )
          ),
        ]);
  }
}

class MyTextInput extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final Icon myPrefIcon;
  final TextInputType inputType;
  final int lines;
  final int lengthMax;
  final TextCapitalization caps;

  Function(String) textChanged;

  MyTextInput(
      {Key key,
      this.hintText,
      this.controller,
      this.myPrefIcon,
      this.inputType,
      this.lines,
      this.lengthMax,
      this.caps,
      this.textChanged})
      : super(key: key);

  @override
  _MyTextInputState createState() => _MyTextInputState();
}

class _MyTextInputState extends State<MyTextInput> {
  @override
  Widget build(BuildContext con) {
    return Container(
      child: TextFormField(
        maxLines: widget.lines,
        maxLength: widget.lengthMax,
          validator: (value) {
            if (value.isEmpty || value==null) {
              return 'Please pfill this';
            }
            
          },
          textCapitalization: widget.caps,
          keyboardType: widget.inputType,
          //style: TextStyle(color: textColor),
          controller: widget.controller,
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.black,fontSize:15),
            border: OutlineInputBorder(
              borderRadius:BorderRadius.circular(20),
              borderSide:BorderSide.none,
            ),
            //focusedBorder: InputBorder.none,
            //enabledBorder: InputBorder.none,
            //errorBorder: InputBorder.none,
           // disabledBorder: InputBorder.none,
            hintText: widget.hintText,
            prefixIcon: widget.myPrefIcon,
            filled: true,
            fillColor: Colors.grey[70],
          ),
        ),
    );
  }
}

class MySearchBar extends StatefulWidget {
  double myWidth, myHeight;
  String myHintText;

  Function(String) myTextChanged;

  MySearchBar(
      {this.myWidth, this.myHeight, this.myHintText, this.myTextChanged});

  _MySearchBarState createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final searchText = TextEditingController();

  @override
  Widget build(BuildContext con) {
    return Container(
      height: widget.myHeight,
      width: widget.myWidth,
      child: Center(
        child: Row(children: <Widget>[
          Expanded(flex: 1, child: SizedBox(width: 1)),
          Expanded(
              flex: 500,
              child: Card(
                color: input,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                    margin: EdgeInsets.all(2),
                    child: Center(
                        child: TextField(
                      controller: searchText,
                      onChanged: (value) {
                        widget.myTextChanged(value);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Search by City, Property",
                        hintStyle:
                            TextStyle(fontSize: 16, color: Colors.grey[600]),
                        prefixIcon:
                            Icon(Icons.search, color: control, size: 20),
                      ),
                    ))),
              )),
          Expanded(flex: 1, child: SizedBox(width: 1)),
        ]),
      ),
    );
  }
}

class AddBtnClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height / 2);
    path.lineTo(size.width, size.height / 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldPath) => false;
}

class ComboBox extends StatefulWidget {
  final Function(String) itemChanged;
  final Icon myPrefIcon;
  final List<String> items;
  String dropDownValue;

  ComboBox({Key key, this.myPrefIcon, this.items, this.itemChanged});
  @override
  ComboBoxState createState() => ComboBoxState();
}

class ComboBoxState extends State<ComboBox> {
  String viewItem;

  @override
  void initState() {
    super.initState();
    widget.dropDownValue = widget.items[0];
    viewItem = widget.items[0];
  }

  //keyboard_arrow_left_sharp
  @override
  Widget build(BuildContext con) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Align(
            alignment: Alignment.center,
            child: DropdownButton<String>(
                value: viewItem,
                elevation: 10,
                icon: Icon(Icons.menu),
                iconSize: 30,
                style: TextStyle(fontSize: 20, color: control),
                items: widget.items.map<DropdownMenuItem<String>>((val) {
                  return DropdownMenuItem<String>(value: val, child: Text(val));
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    widget.dropDownValue = value;
                    viewItem = value;
                    widget.itemChanged(value);
                  });
                }),
          ),
        ),
      ),
    );
  }
}
class PhotoCard extends StatefulWidget{
	//final VoidCallback addPhoto;
  final Function(File) onPictureTaken;
	final double mWidth;
	final double mHeight;

	PhotoCard({Key key, this.mWidth, this.mHeight,this.onPictureTaken});
	
	_PhotoCardState createState() => _PhotoCardState();
}

class _PhotoCardState extends State<PhotoCard> {

  File image;
  @override
  Widget build(BuildContext con) {
    return GestureDetector(
                  onTap:(){
              showBottomSheet(con);
              
            },

      child:Container(
      width: widget.mWidth,
      height: widget.mHeight,
      child: Card(
        clipBehavior:Clip.antiAlias,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Stack(
            children:<Widget>[
              Positioned(
                child:imageArea(),
              ),
              
            ]
          ),
        ),
      ),
    )
    );
  }

  void getPicture(ImageSource mSource)async{
    print("wana get");
    var _image = await ImagePicker.pickImage(source: mSource);

    setState(() {
       image = _image ;
       widget.onPictureTaken(image);
    });
  }

  void showBottomSheet(BuildContext con){
    showModalBottomSheet(
      context: con,
      builder:(con){
        return Container(
          height:MediaQuery.of(con).size.height/5,
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text("Camera"),
                onTap: (){
                  getPicture(ImageSource.camera);
                  Navigator.pop(con);
                },
              ),

              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Gallery"),
                onTap:(){
                  getPicture(ImageSource.gallery);
                  Navigator.pop(con);
                }
              ),
            ],
          ),
        );
      }
    );
  }
  Widget imageArea(){
    return SizedBox(
      //width:300,height:600,
      child:image==null?
            Container(
              child:Center(
                child:Icon(Icons.add_a_photo,size: 100,)
              ),
            )
            :Image.file(image,fit:BoxFit.fill),
    );
  }
}