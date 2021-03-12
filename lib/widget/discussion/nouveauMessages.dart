import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NouveauMessage extends StatefulWidget {
  @override
  _NouveauMessageState createState() => _NouveauMessageState();
}

class _NouveauMessageState extends State<NouveauMessage> {
  final _controllerMessage = new TextEditingController();
  var _messageSaisi = '';
  void _envoyerMessage() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser();
    final userData =
        await Firestore.instance.collection('users').document(user.uid).get();
    Firestore.instance.collection('chat').add({
      'text': _messageSaisi,
      'createAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData['username'],
      'userImage': userData['imageUrl'],
    });
    _controllerMessage.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autocorrect: true,
              textCapitalization: TextCapitalization.sentences,
              enableSuggestions: true,
              controller: _controllerMessage,
              decoration: InputDecoration(labelText: 'Type a message...'),
              onChanged: (value) {
                setState(() {
                  _messageSaisi = value;
                });
              },
            ),
          ),
          IconButton(
            color: Colors.indigo,
            icon: Icon(
              Icons.send,
            ),
            onPressed: _messageSaisi.trim().isEmpty ? null : _envoyerMessage,
          ),
        ],
      ),
    );
  }
}
