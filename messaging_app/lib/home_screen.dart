import 'package:flutter/material.dart';
import 'package:messaging_app/widgets/category_selector.dart';
import 'package:messaging_app/widgets/favourite_contacts.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.red, accentColor: Color(0xFFFEF9EB)),
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Chats',
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        elevation: 0.0,
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: Column(children: [
        CategorySelector(),
        Expanded(
          child: Container(
            height: 500.00,
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0))),
                    child: FavouriteContacts(),
          ),
          
        ),
      ]),
    );
  }
}
