import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key key}) : super(key: key);
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  String _title, _text;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title:Text('Добавление записи'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Row(
          mainAxisAligment: MainAxisAligment.center,
          children: [
            Text('Укажите значения', style: TextStyle(color: Colors.white, fontSize: 30),),
            Padding(padding: EdgeInstets.only(top:10)),
            Container(
              width: 200,
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InderlineInputBorder(),
                  labelText: 'Введите название',
                  labelStyle: new TextStyle(
                    color: Colors.white,
                  )
                  suffixIcon: Icon(Icons.text_fields),
                ),
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
              ),
            ),
            Padding(padding: EdgeInsets.only(top:10)),
            Container(
              width: 200,
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Введите текст',
                  labelStyle: new TextStyle(
                    color: Colors.white,
                  ),
                  suffixIcon: Icon(Icons.text_format),
                ),
                onChanged: (value) {
                  setState((){
                    _text = value;
                  });
                },
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            
            ElevatedButton(onPressed: (){
              FirebaseFirestore.instance.collection('items').aadd({'title': _title, 'text': _text});
              Navigator.pop(context);
            }, child: Text('Добавить'))
          ],
        ),
      ),
    );
  }
}