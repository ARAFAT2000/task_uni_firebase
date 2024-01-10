import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_task_data.dart';

class ShowTaskScreen extends StatefulWidget {
  const ShowTaskScreen({super.key});

  @override
  State<ShowTaskScreen> createState() => _ShowTaskScreenState();
}

class _ShowTaskScreenState extends State<ShowTaskScreen> {
  final ref= FirebaseFirestore.instance.collection('Teacher');
final Stream<QuerySnapshot> showdata=FirebaseFirestore.instance.collection('Teacher').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Your Task List'),
      ),
      floatingActionButton:FloatingActionButton.extended(
        backgroundColor: Colors.deepPurple,
          onPressed:(){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>AddtaskData())).
            then((value) {

            }).
            onError((error, stackTrace) {
              Text(error.toString());
            });
          }, label: Text('Add Data')),
     body: SafeArea(
       child: Padding(
         padding: const EdgeInsets.only(left: 10,right: 10),
         child: Column(
           children: [

             StreamBuilder(
                 stream: showdata,
                 builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
                   return !snapshot.hasData?
                   Padding(
                     padding: const EdgeInsets.only(top: 30),
                     child: Center(child: CircularProgressIndicator(
                       strokeWidth:4,color: Colors.deepPurple,
                     )),
                   ):
                       Expanded(child:
                       ListView.builder(
                         shrinkWrap: true,
                         itemCount: snapshot.data!.docs.length,
                           itemBuilder: (context,index){
                           var itemlist=snapshot.data!.docs[index];
                          return Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(itemlist['Title'],style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,color: Colors.deepPurple
                                  ),),

                                  subtitle: Text(itemlist['Id']),
                                  trailing: InkWell(
                                      onTap: (){
                                     ref.doc(itemlist.toString()).delete();
                                      },
                                      child: Icon(Icons.delete)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 18,right: 18),
                                  child: Text(itemlist['Description']),
                                ),
                              Text(' ')

                              ],
                            ),
                          );
                       }));
                 }),
           ],
         ),
       ),
     )
    );
  }
}
