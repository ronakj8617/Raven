import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:raven/global%20variables/api_keys.dart';
import 'package:raven/models/message_model.dart';
import 'package:raven/models/user_model.dart';
import './widgets/category_selector.dart';
import './widgets/favourite_contacts.dart';
import './widgets/recent_chats.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late Client client;  
  late var account;
  API_KEYS api_keys = API_KEYS();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.addPostFrameCallback((_) => authenticationInit());

  }

  Future<void> authenticationInit() async {
    
      User user = User(id: 001, name: 'name', imageUrl: 'imageUrl');

      Message message = Message(
          sender: user, time: 'time', text: 'text', isLiked: true, unread: true);

      client = Client()
                .setEndpoint(api_keys.endPoint) // Your API Endpoint
                .setProject(api_keys.project)
                .setSelfSigned(status:api_keys.selfSigned);               // Your project ID

      account = Account(client);

      final session = await account.createPhoneSession(
        userId: ID.unique(),
        phone: '+917283844571'
      );

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
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: const <Widget>[
                  FavouriteContacts(),
                  RecentChats(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
