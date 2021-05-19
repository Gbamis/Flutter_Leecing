import 'package:flutter/material.dart';
import '../constants.dart';
import '../widget/myWidget.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller = TextEditingController();
  final _passCon = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  BuildContext cont;

  @override
  Widget build(BuildContext con) {
    cont = con;
    return Scaffold(
      backgroundColor: base,
      body: Center(child: _pageCon(con)),
    );
  }

  Widget sn() {
    return SnackBar(
        duration: Duration(seconds: 2),
        content: Text(_controller.text),
        action: SnackBarAction(
            label: 'undo',
            onPressed: () {
              print("d");
            }));
  }

  void login() {
    if (_formKey.currentState.validate()) {
      Navigator.pushNamed(cont, '/home', arguments: {
        'username': 'oil'
      });
    }
  }

  Widget _pageCon(BuildContext con) {
    var w = MediaQuery.of(con).size.width;
    var h = MediaQuery.of(con).size.height;
    return Container(
      //Text("Homepage",style:TextStyle(color:(w<h)?control : primary,fontSize:27))
      width: w - 100,
      child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Fill your email";
                  }
                  return null;
                }),
            SizedBox(height: 10),
            TextFormField(
                controller: _passCon,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Fill you password";
                  }
                  return null;
                },
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.add),
                  hintText: "Password",
                )),
            SizedBox(height: 10),
            MyButton(
                label: 'Login',
                btnHeight: 50,
                btnColor: control,
                myTap: () {
                  login();
                }),
            /*RaisedButton(
                    child:Container(
                        height:50,
                        child:Center(child:Text("Login",style:TextStyle(color:Colors.white)))
                    ),
                    color:control,
                    onPressed:(){
                        //ScaffoldMessenger.of(con).showSnackBar(sn());
                        if(_formKey.currentState.validate()){
                            Navigator.pushNamed(con,'/home',arguments:{'username':'oil'});
                        }
                    },
                    shape:RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(10),
                    )
                ),*/
          ])),
    );
  }
}
