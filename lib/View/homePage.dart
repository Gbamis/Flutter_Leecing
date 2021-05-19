import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leecit/Store/firestoreAPI.dart';
import '../constants.dart';
import '../widget/myWidget.dart';
import '../Models/propertyModel.dart';
import '../View/detailsPage.dart';
import '../Store/firestoreAPI.dart';

class HomePage extends StatefulWidget {
  final String username;
  HomePage({Key key, this.username}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String searchText = "";
  int docLength;

  FirestoreAPI API;

  @override
  void initState(){
    API = new FirestoreAPI();
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext con) {
    return Scaffold(
      backgroundColor: base,
      body: Center(child: _page(con)),
      floatingActionButton: FloatingActionButton.extended(icon: Icon(Icons.edit), 
              heroTag: 'nav',
              label: Text("Add"), 
              backgroundColor: control, 
              onPressed: () {
                addPage(con);
              }),
    );
  }


  Widget _page(BuildContext con) {
    return Container(
      //color: Colors.green[300],
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: StreamBuilder<QuerySnapshot>(
        stream:(searchText !="" && searchText !=null)
        ? Firestore.instance.collection("Properties")
                  .orderBy('timeStamp',descending: true)
                  .where('city', isEqualTo: searchText).snapshots() : 

        Firestore.instance.collection("Properties")
                  .orderBy('timeStamp',descending:true)
                  .snapshots(),

        builder:(BuildContext con, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData) return CircularProgressIndicator();
          if(snapshot.hasError) return Center(child:Text("Could not fetch data"));

          setDocLength(snapshot);

          return _pageCon(con,snapshot);
        }
      ),
    );
  }
  
  Widget _pageCon(BuildContext con, AsyncSnapshot<QuerySnapshot> snapshot){
    return Stack(
        children: <Widget>[
        Positioned(
          child: CustomScrollView(slivers: <Widget>[
            _mySpacer(70),
            _myHeading(),
            _myAppBar(),
            //_gridView(snapshot),
            _gridListView(con,snapshot),
          ]),
        ),
      ]);
  }

  Widget _addButton(BuildContext con) {
    return ClipPath(
      clipper: AddBtnClipper(),
      child: Container(height: 60, width: MediaQuery.of(con).size.width, color: control),
    );
  }

  Widget _mySpacer(double h) {
    return SliverToBoxAdapter(
      child: SizedBox(height: h),
    );
  }

  Widget _myHeading() {
    return SliverToBoxAdapter(
      child: Text("Explore Properties",
       style: TextStyle(color: title, fontSize: 65, fontWeight: FontWeight.bold)),
    );
  }

  Widget _myAppBar() {
    return SliverAppBar(
        expandedHeight: 100,
        floating: true,
        backgroundColor: Colors.white,
        flexibleSpace: FlexibleSpaceBar(
          stretchModes: <StretchMode>[
            StretchMode.zoomBackground,
            StretchMode.blurBackground,
            StretchMode.fadeTitle,
          ],
          title: Column(
            children: <Widget>[
            Expanded(flex: 5, child: SizedBox(height: 20)),
            Expanded(flex: 3, 
            child: MySearchBar(myTextChanged:(value){
              setState((){
                searchText = value;
              });
            },
            myWidth:260,myHintText: "Property\nLeasing"))
          ]),
          centerTitle: true,
        ));
  }

  Widget _gridListView(BuildContext con, AsyncSnapshot<QuerySnapshot> snapshot) {
    List<DocumentSnapshot> docs = snapshot.data.documents;
    return SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300.0,
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
              childAspectRatio: 0.5,
              
            ),
            delegate: SliverChildListDelegate(
              docs.map((data){
                PropertyModel pmd = PropertyModel.fromDoc(data);
                return PropertyCard(
                    pm: pmd,
                    index: 2,
                    myH:700,
                    myTapped: () {
                      showDetails(con, pmd);
                    });
              }).toList()
            ),
          );
  }

  Widget _gridView(AsyncSnapshot<QuerySnapshot> snapshot) {
    return SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 0.7,
              
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext con, int index) {
                List<DocumentSnapshot> docs = snapshot.data.documents;
                //docLength = docs.length;
                //setState((){});
                print("total is $docLength");
                PropertyModel pmd = PropertyModel.fromDoc(docs[index]);

                return PropertyCard(
                    pm: pmd,
                    index: index,
                    myH:400,
                    myTapped: () {
                      showDetails(con, pmd);
                    });
              },
              childCount: 5,
            ),
          );
  }

  void showDetails(BuildContext cont, PropertyModel pm) {
    Navigator.push(cont, MaterialPageRoute(builder: (cont) => DetailsPage(pM: pm)));
  }
  
  void addPage(BuildContext con){
    Navigator.pushNamed(con,'/add');
  }

  void setDocLength(AsyncSnapshot<QuerySnapshot> snapshot) async{
    docLength = await snapshot.data.documents.length;
  }
}
