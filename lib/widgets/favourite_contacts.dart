import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:Raven/models/message_model.dart';
import 'package:path_provider/path_provider.dart';


class FavouriteContacts extends StatefulWidget {
  static List userData = [];

  const FavouriteContacts({Key? key}) : super(key: key);

  @override
  State<FavouriteContacts> createState() => _FavouriteContactsState();
}

class _FavouriteContactsState extends State<FavouriteContacts> {
  Map<String, String> dataMap = {'Sam': 'Sam.jpg'};
  late String directory;
  File file = File('');
  File chatsFile =File('');
  File userFile = File('');
  static var userData;

  @override
  void initState() {
    super.initState();

    initializeUserData();

    WidgetsBinding.instance.addPostFrameCallback((_) => initializeUserData());
  }

  @override
  Widget build(BuildContext context) {
    // log('build');f

    initializeUserData();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Favorite Contacts',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.more_horiz,
                  ),
                  iconSize: 30.0,
                  color: Colors.blueGrey,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SizedBox(
            height: 120.0,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: FavouriteContacts.userData.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  // onTap: () => Navigator.push(
                  //   context,Ï
                  //   MaterialPageRoute(
                  //     builder: (_) => ChatScreen(
                  //       user: favorites[index],
                  //     ),
                  // ),

                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 35.0,
                          backgroundImage: AssetImage(FavouriteContacts
                              .userData[index]['sender']['imageUrl']),
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          FavouriteContacts.userData[index]['sender']['name'],
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  initializeUserData() async {
    // log('getfile');
    if (kIsWeb) {
      // Set web-specific directory
    } else {
      Directory appDocDirectory = await getApplicationDocumentsDirectory();

      Directory('${appDocDirectory.path}/chats')
          .create(recursive: true)
          .then((Directory directory) {
        // print('Path of New Dir: ' + directory.path);
      });

      chatsFile = File('${appDocDirectory.path}/chats/chats.json');
      userFile = File('${appDocDirectory.path}/chats/users.json');

      directory = '${(await getApplicationDocumentsDirectory()).path}/chats';
      // log(directory);

      setState(() {
        // file = Directory("$directory")
        //     .listSync(); //use your folder name insted of resume.

        file = File('$directory/user.json');
      });
      // log(test);

      // var check=User.fromJson(file.readAsLinesSync().first);
      // log(file.readAsStringSync());
      List userData = [];

      userData = await jsonDecode(userFile.readAsStringSync());
      // log(data.toString());
      // log(userData[0]['sender']['name']);

      // log(file.toString());

      // log(data.name);

      FavouriteContacts.userData = userData;
      // log('message' + userData.runtimeType.toString());
      if (FavouriteContacts.userData == null) {
        initializeUserData();
      }
      return userData;
    }
  }
}
