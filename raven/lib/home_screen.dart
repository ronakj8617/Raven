import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:raven/models/message_model.dart';
import 'package:raven/models/user_model.dart';
import 'package:raven/widgets/category_selector.dart';
import 'package:raven/widgets/favourite_contacts.dart';
import 'package:raven/widgets/recent_chats.dart';

import 'firebase_options.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsFlutterBinding.ensureInitialized();
    // Firebase.initializeApp();
    // Firebase.app('raven (ios)');
    WidgetsBinding.instance.addPostFrameCallback((_) => firebaseInit());

    // Firebase.initializeApp();
    // FirebaseDatabase database = FirebaseDatabase.instance;
    // firebaseInit();
  }

  Future<void> firebaseInit() async {
        await Firebase.initializeApp();

    // if (Firebase.apps.length == 0) {
    //   // await Firebase.initializeApp(
    //       // options: DefaultFirebaseOptions.currentPlatform);
    // } // Firebase.initializeApp().onError((error, stackTrace) => (error));

    // FirebaseApp secondaryApp = Firebase.app('raven (ios)');
    // FirebaseDatabase database = FirebaseDatabase.instanceFor(app: secondaryApp);

    DatabaseReference ref = FirebaseDatabase.instance.ref("raven (ios)");
    var ios = DefaultFirebaseOptions.ios;

    User user = User(id: 001, name: 'name', imageUrl: 'imageUrl');
    Message message= Message(sender:user, time: 'time', text: 'text', isLiked: true, unread: true);

    await ref.child(Timeline.now.toString()).set({'user':message.toJson(message)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () {},
        ),
        title: const Text(
          'Raven 1.1.1',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          CategorySelector(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  // const FavouriteContacts(),
                  // const RecentChats(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
