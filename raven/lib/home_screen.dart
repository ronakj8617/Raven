import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:raven/models/message_model.dart';
import 'package:raven/models/user_model.dart';
import 'package:raven/widgets/category_selector.dart';
import 'package:raven/widgets/favourite_contacts.dart';
import 'package:raven/widgets/recent_chats.dart';
import 'package:snapshot/snapshot.dart';

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
    // if (Firebase.apps.length == 0) {
    //   // await Firebase.initializeApp(
    //       // options: DefaultFirebaseOptions.currentPlatform);
    // } // Firebase.initializeApp().onError((error, stackTrace) => (error));

    // FirebaseApp secondaryApp = Firebase.app('raven (ios)');
    // FirebaseDatabase database = FirebaseDatabase.instanceFor(app: secondaryApp);

    User user = User(id: 001, name: 'name', imageUrl: 'imageUrl');
    Message message = Message(
        sender: user, time: 'time', text: 'text', isLiked: true, unread: true);
    if (!kIsWeb) {
      // ignore: unrelated_type_equality_checks

      if (Platform.isMacOS) {
        await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform);

        FirebaseFirestore.instance
            .collection('testing')
            .doc('Desktop')
            .collection('macOs')
            .add({'Name': 'Raven1', 'DOB': 1999});

        var db = FirebaseFirestore.instance;

        await db.collection("testing").get().then((event) {
          for (var doc in event.docs) {
            print("${doc.id} => ${doc.data()}");
            var v = doc.get('Name');
            print(v);
          }
        });
        DatabaseReference ref = FirebaseDatabase.instance.ref("raven (macOS)");
        await ref
            .child(Timeline.now.toString())
            .set({'user': message.toJson(message)})
            .onError((error, stackTrace) => error.toString())
            .then((value) => value);
      } else if (Platform.isAndroid) {
        await Firebase.initializeApp();

        FirebaseFirestore.instance
            .collection('testing')
            .doc('Mobile')
            .collection('Android')
            .add({'Name': 'Raven1', 'DOB': 1999});

        var db = FirebaseFirestore.instance;

        await db.collection("testing/Mobile/Android").get().then((event) {
          for (var doc in event.docs) {
            print("${doc.id} => ${doc.data()}");
            var v = doc.get('Name');
            print(v);
          }
        });
        DatabaseReference ref =
            FirebaseDatabase.instance.ref("raven (Android)");

        await ref
            .child(Timeline.now.toString())
            .set({'user': message.toJson(message)})
            .onError((error, stackTrace) => error.toString())
            .then((value) => value);
      } else if (Platform.isIOS) {
        await Firebase.initializeApp();

        await Auth.FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+91 7283844571',
          verificationCompleted: (Auth.PhoneAuthCredential credential) {},
          verificationFailed: (Auth.FirebaseAuthException e) {log(e.toString());},
          codeSent: (String verificationId, int? resendToken) {},
          codeAutoRetrievalTimeout: (String verificationId) {},
        );

        FirebaseFirestore.instance
            .collection('testing')
            .doc('Mobile')
            .collection('iOS')
            .add({'Name': 'Raven1', 'DOB': 1999});

        var db = FirebaseFirestore.instance;
        await db.collection("testing/Mobile/iOS").get().then((event) {
          for (var doc in event.docs) {
            print("${doc.id} => ${doc.data()}");
            var v = doc.get('Name');
            print(v);
          }
        });
        // var ios = DefaultFirebaseOptions.ios;
        DatabaseReference ref = FirebaseDatabase.instance.ref("raven (iOS)");

        await ref
            .child(Timeline.now.toString())
            .set({'user': message.toJson(message)})
            .onError((error, stackTrace) => error.toString())
            .then((value) => value);

        final getRef = FirebaseDatabase.instance.ref("raven (iOS)");
        final snapshot = await ref.get();
        if (snapshot.exists) {
          var decoder = SnapshotDecoder()
            ..register<Map<String, dynamic>, Message>(
                (v) => Message.fromJson(v));

          Map m = jsonDecode(jsonEncode(snapshot.value));

          log(m['17873075840'].toString());
        } else {
          print('No data available.');
          // }
        }
      }
    } else {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);

      FirebaseFirestore.instance
          .collection('testing')
          .doc('web')
          .collection('web')
          .add({'Name': 'Raven3', 'DOB': 1999});

      var db = FirebaseFirestore.instance;

      await db.collection("testing/web/web").get().then((event) {
        for (var doc in event.docs) {
          print("${doc.id} => ${doc.data()}");
          var v = doc.get('Name');
          print(v);
        }
      });
      DatabaseReference ref = FirebaseDatabase.instance.ref("raven (Web)");

      User user = User(id: 001, name: 'name', imageUrl: 'imageUrl');
      Message message = Message(
          sender: user,
          time: 'time',
          text: 'text',
          isLiked: true,
          unread: true);

      await ref
          .child(Timeline.now.toString())
          .set({'user': message.toJson(message)});
    }
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
          'Raven 1.1.2',
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
