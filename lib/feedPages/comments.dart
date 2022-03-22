import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:susell/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'Category.dart';


class Comments extends StatefulWidget {
  final String postId;


  Comments({
    required this.postId,
  });

  @override
  CommentsState createState() => CommentsState(
    postId: this.postId,
  );
}

class CommentsState extends State<Comments> {
  TextEditingController commentController = TextEditingController();
  final commentsRef = FirebaseFirestore.instance.collection('comments');
  final DateTime timestamp = DateTime.now();
  final String postId;


  CommentsState({
    required this.postId,

  });

  buildComments() {
    return StreamBuilder<QuerySnapshot>(
        stream: commentsRef.doc(postId).collection('comments').orderBy('timestamp', descending: false).snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          List<Comment> comments = [];
          snapshot.data!.docs.forEach((doc) {
            comments.add(Comment.fromDocument(doc));
          });
          return ListView(
            children: comments, );
        });

  }



  addComment() {
/*
    String nonNullableString = currentUser?.displayName![0] ?? 'U';

    CircleAvatar myAvatar = CircleAvatar(
      child: Text(nonNullableString),
    );

*/
    commentsRef
        .doc(postId)
        .collection('comments')
        .add({
      //"username": currentUser?.displayName,
      "comment": commentController.text,
      "timestamp": timestamp,
      //"avatarUrl": currentUser?.photoURL,
      //"userId": currentUser?.uid,
    });
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:Text('Comments'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: buildComments()),
          Divider(),
          ListTile(
            title: TextFormField(
              controller: commentController,
              decoration: InputDecoration(labelText: 'Write a comment...'),
            ),
            trailing: OutlinedButton(
              onPressed: addComment,
              child: Text('Post'),
            ),
          ),
        ],
      ),
    );
  }
}

class Comment extends StatelessWidget {
  //final String username;
  //final String userId;
  //final String avatarUrl;
  final String comment;
  final Timestamp timestamp;

  Comment({
    //required this.username,
    //required this.userId,
    //required this.avatarUrl,
    required this.comment,
    required this.timestamp,
  });

  factory Comment.fromDocument(DocumentSnapshot doc){
    return Comment(
      // username: doc['username'],
      // userId: doc['userId'],
      //avatarUrl: doc['avatarUrl'],
      comment: doc['comment'],
      timestamp: doc['timestamp'],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          ListTile(
            title: Text(comment),
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider('https://e7.pngegg.com/pngimages/416/62/png-clipart-anonymous-person-login-google-account-computer-icons-user-activity-miscellaneous-computer.png'),
            ),
            subtitle: Text(timeago.format(timestamp.toDate())),
          ),
          Divider(),
        ]
    );
  }
}

showComments(BuildContext context, {required String postId}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return Comments(
      postId: postId,
    );
  }));
}
