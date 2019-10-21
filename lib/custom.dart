import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:policeapp/size.dart';

class CustomCard extends StatelessWidget {
  CustomCard({@required this.title,this.description,this.sex,this.city,this.state,this.age});

  final title;
  final description;
  final sex;
  final city;
  final state;
  final age;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              children: <Widget>[
                Text(title),
                FlatButton(
                    child: Text("See More and Edit"),
                    onPressed: () {
                      print(sex);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondPage(
                                  title: title, description: description,age:age,sex:sex,city:city)));
                    }),
              ],
            )));
  }
}

// class SecondPage extends StatelessWidget {
//   SecondPage({@required this.title, this.description, this.sex, this.city, this.state, this.age});

//   final title;
//   final description;
//   final sex;
//   final city;
//   final state;
//   final age;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(title),
//         ),
//         body: Center(
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
               
//                 Text("\nName: "+title),
                 
//                 Text("\nAge: "+age),
//                 Text("\nSex: "+sex),
//                 Text("\nCity: "+city),
//                 Text("\nIdentifications are: "+description),
//                 RaisedButton(
//                     child: Text('Back To HomeScreen'),
//                     color: Theme.of(context).primaryColor,
//                     textColor: Colors.white,
//                     onPressed: () => Navigator.pop(context)),
//               ]),
//         ));
//   }
// }



class SecondPage extends StatelessWidget {
  SecondPage({@required this.title, this.description, this.sex, this.city, this.state, this.age});

  final title;
  final description;
  final sex;
  final city;
  final state;
  final age;
TextEditingController ageController;
TextEditingController cityController;
TextEditingController sexController;
TextEditingController taskTitleInputController;
TextEditingController taskDescripInputController;

// @override
// initState() {
//   taskTitleInputController = new TextEditingController();
//   taskDescripInputController = new TextEditingController();
//   ageController=new TextEditingController();
//   sexController =new TextEditingController();
//   cityController =new TextEditingController();
//   super.initState();
// }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Thief Details Edit Page"),
        ),
        body: Container(
          child: Form(
            child: ListView(
              children: <Widget>[
                Text("\n Name: "+title),
                 
                Text("\n Age: "+age),
                Text("\n Sex: "+sex),
                Text("\n City: "+city),
                Text("\n Identifications are: "+description+"\n"),
                Text("To Edit :",style: TextStyle(fontSize: 15,color: Colors.red),),
                Padding(
                          padding: EdgeInsets.only(top:5,bottom:5),
                        
               child: TextFormField(
                 controller: taskTitleInputController,
                   decoration: InputDecoration(
                            // labelStyle:textStyle,
                            
                            labelText: "Name",
                            hintText: title,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                            ),

                ),)
                ,
                      Padding(
                          padding: EdgeInsets.only(top:5,bottom:5),
                child: TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                   decoration: InputDecoration(
                            // labelStyle:textStyle,
                            labelText: "Age",
                            hintText: age,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                            ),

                ),),
                Padding(
                          padding: EdgeInsets.only(top:5,bottom:5),
                   child: TextFormField(
                     controller: sexController,
                  keyboardType: TextInputType.number,
                   decoration: InputDecoration(
                            // labelStyle:textStyle,
                            labelText: "Sex",
                            hintText: sex,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                            ),

                ),),
                   Padding(
                          padding: EdgeInsets.only(top:5,bottom:5),
                   child: TextFormField(
                     controller: cityController,
                  keyboardType: TextInputType.number,
                   decoration: InputDecoration(
                     
                            // labelStyle:textStyle,
                            labelText: "City",
                            hintText: city,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                            ),

                ),),
                 Padding(
                          padding: EdgeInsets.only(top:5,bottom:5),
                   child: TextFormField(
                     
                  controller: taskDescripInputController,
                     minLines: 1,
                     maxLines: 3,
                  // keyboardType: TextInputType.number,
                   decoration: InputDecoration(
                            // labelStyle:textStyle,
                            labelText: "Identifications",
                            hintText: description,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                            ),

                ),),
                 Padding(
                          padding: EdgeInsets.only(top:5,bottom:5),
                   child:Text(" *All the details seen in hint text are Actual details",style: TextStyle(color: Colors.red),),),
                          Padding(
                          padding: EdgeInsets.only(top:5,bottom:5),
                          child:  RaisedButton(
          child: Text('Submit'),
          color: Colors.green,
          onPressed: () {
            Navigator.pop(context);
            if (taskDescripInputController.text.isNotEmpty &&
                taskTitleInputController.text.isNotEmpty) {
                  print("chcked");
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
                print("in final add"),
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
                          ),

              ],
            ),
          ),
          
          
        ),
          );
  }
}


