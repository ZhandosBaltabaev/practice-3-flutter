import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class MainScreen extends StatefulWidget {
const MainScreen({Key key}) : super(key: key);
@override
_MainScreenState createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Список дел'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {

            Navigator.pushNamed(context, '/add');
            },
          )
        ],
      ),
      body: StreamBuilder( // Вывод всех записей
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      
          if(snapshot.data.docs.length == 0) return Center(child: Text('Нет записей', style: TextStyle(color: Colors.white),));
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key(snapshot.data.docs[index].id),
                child: Card(
                  child: ListTile(
                    title: Row( // Вывод не просто текста, а целого ряда
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [

                            Text(snapshot.data.docs[index].get('title')),
                            Text(snapshot.data.docs[index].get('text'), style:TextStyle(color: Colors.grey),),
                          ],
                        )
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete_sweep,
                        color: Colors.deepOrangeAccent
                      ),
                      onPressed: () {
FirebaseFirestore.instance.collection('items').doc(snapshot.data.docs[index].id).delete();
                    },
                  ),
                ),
              ),
              onDismissed: (direction) {
FirebaseFirestore.instance.collection('items').doc(snapshot.data.docs[index].id).delete();
                },
              );
            }
          );
        },
      ),
    );
  }
}