//import 'dart:html';

import 'package:ChatTER/widget/discussion/messages.dart';
import 'package:ChatTER/widget/discussion/nouveauMessages.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

var indexAjout = 0;

class Discussion extends StatefulWidget {
  @override
  _DiscussionState createState() => _DiscussionState();
}

class _DiscussionState extends State<Discussion> {
  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(
      onLaunch: (message) {
        print(message);
        return;
      },
      onResume: (message) {
        print(message);
        return;
      },
    );
    fbm.subscribeToTopic('chat');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(' ChatTER'),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryColor,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Logout'),
                          SizedBox(
                            width: 7,
                          ),
                          Icon(Icons.logout),
                        ],
                      ),
                    ],
                  ),
                ),
                value: 'logout',
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
//streamBuilder est un peu le listView.Builder des streams(Les Flux comme les fux d'entree et sortie en C++ )
//D'ou l'intancitation et recuperation du flux creer et venant du firebase via FireStore.instance

      //  StreamBuilder(
      //   stream: Firestore.instance
      //       .collection('chats/3GU7sGtQlHxnAdiUYTP0/messages')
      //       .snapshots(),
      //   builder: (ctx, streamSnapshot) {
      //     if (streamSnapshot.connectionState == ConnectionState.waiting) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }

      //     final documents = streamSnapshot.data.documents;
      //     return ListView.builder(
      //       itemCount: documents.length,
      //       itemBuilder: (ctx, index) => Container(
      //         padding: EdgeInsets.all(10),
      //         child: Text(documents[index]['text']),
      //       ),
      //     );
      //   },
      // ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NouveauMessage(),
          ],
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //     hoverColor: Theme.of(context).floatingActionButtonTheme.hoverColor,
      //     hoverElevation: 10,
      //     child: Icon(
      //       Icons.mail,
      //     ),
      //     onPressed: () {
      //       indexAjout++;
      //       Firestore.instance
      //           .collection('chats/3GU7sGtQlHxnAdiUYTP0/messages')
      //           .add({'text': 'Message $indexAjout ajoute'});
      //     }),
    );
  }
}
