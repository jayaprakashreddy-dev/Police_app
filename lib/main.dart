import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:policeapp/custom.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue[30],
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget
{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Police Application for Thief Records "),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('records')
              .snapshots(),
            builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return new ListView(
                      children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                          return new CustomCard(
                            title: document['title'],
                            description: document['description'],
                            age: document['age'],
                            sex: document['sex'],
                            city: document['city'],

                          );
                      }).toList(),
                    );
                }
              },
            )),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
TextEditingController ageController;
TextEditingController cityController;
TextEditingController sexController;
TextEditingController taskTitleInputController;
TextEditingController taskDescripInputController;

@override
initState() {
  taskTitleInputController = new TextEditingController();
  taskDescripInputController = new TextEditingController();
  ageController=new TextEditingController();
  sexController =new TextEditingController();
  cityController =new TextEditingController();
  super.initState();
}

_showDialog() async {
  await showDialog<String>(
    context: context,
    child: AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      content: Column(
        children: <Widget>[
          Text("Please fill all fields to add a new thief record"),
          Expanded(
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(labelText: 'Thief Name*'),
              controller: taskTitleInputController,
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: 'Identifications*'),
              controller: taskDescripInputController,
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: 'Age*'),
              controller: ageController,
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: 'Sex*'),
              controller: sexController,
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: 'City*'),
              controller: cityController,
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            taskTitleInputController.clear();
            taskDescripInputController.clear();
            ageController.clear();
            cityController.clear();
            sexController.clear();
            Navigator.pop(context);
          }),
        FlatButton(
          child: Text('Add'),
          onPressed: () {
            if (taskDescripInputController.text.isNotEmpty &&
                taskTitleInputController.text.isNotEmpty) {
              Firestore.instance
                .collection('records')
                .add({
                  "title": taskTitleInputController.text,
                  "description": taskDescripInputController.text,
                  "age": ageController.text,
                  "city" :cityController.text,
                  "sex":sexController.text,
              })
              .then((result) => {
                Navigator.pop(context),
                taskTitleInputController.clear(),
                taskDescripInputController.clear(),
                ageController.clear(),
                  cityController.clear(),
                  sexController.clear(),
              })
              .catchError((err) => print(err));
          }
        })
      ],
    ),
  );
}

}
