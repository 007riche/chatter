//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String username;
  final String userImage;
  final Key key;

  MessageBubble(
    this.message,
    this.username,
    this.userImage,
    this.isMe, {
    this.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.black54 : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(9),
                  bottomRight: Radius.circular(9),
                  topRight: isMe ? Radius.circular(0) : Radius.circular(9),
                  topLeft: isMe ? Radius.circular(9) : Radius.circular(0),
                ),
              ),
              width: 250,
              padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 18,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 12,
              ),
              child: Column(
                children: [
                  //Autre alternative mais couteuse en connection
                  // FutureBuilder(
                  //     future: Firestore.instance
                  //         .collection('users')
                  //         .document(userName)
                  //         .get(),
                  //     builder: (context, snapShot) {
                  //       if (snapShot.connectionState == ConnectionState.waiting) {
                  //         return SizedBox(
                  //           height: 3,
                  //           width: 3,
                  //           child: CircularProgressIndicator(),
                  //         );
                  //       }
                  //     return
                  Container(
                    constraints: BoxConstraints(minHeight: 25),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: Row(
                        mainAxisAlignment: isMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Text(
                            '~',
                            style: isMe
                                ? TextStyle(
                                    color: Theme.of(context)
                                        .floatingActionButtonTheme
                                        .foregroundColor,
                                  )
                                : null,
                          ),
                          Text(
                            username,
                            style: isMe
                                ? TextStyle(
                                    color: Theme.of(context)
                                        .floatingActionButtonTheme
                                        .foregroundColor,
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //  }),
                  Container(
                    //constraints: BoxConstraints(minHeight: 15),
                    child: Text(
                      message,
                      softWrap: true,
                      style: TextStyle(
                        color: isMe
                            ? Theme.of(context)
                                .floatingActionButtonTheme
                                .foregroundColor
                            : null,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        //color: Theme.of(context).accentTextTheme.headline3.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 8,
          left: isMe ? null : 218,
          right: isMe ? 218 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
