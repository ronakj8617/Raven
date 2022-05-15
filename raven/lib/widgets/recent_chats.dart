import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raven/chat_screen.dart';
import 'package:raven/models/message_model.dart';
import 'package:raven/models/user_model.dart';
import 'package:path_provider/path_provider.dart';

class RecentChats extends StatefulWidget {
  static List recentChatData = [];

  static int recentChatDataCount = 0;

  const RecentChats({Key? key}) : super(key: key);

  @override
  State<RecentChats> createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  File file = File('');

  File recentChatsFile = File('');

  late String directory;

  @override
  void initState() {
    super.initState();
    readJson();
    initializeChatData();
    WidgetsBinding.instance.addPostFrameCallback((_) => initializeChatData());
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/chats.json');
    // log('Response: ' + response);

    final test = rootBundle.loadString('assets/chats.json');
    // log('test');

    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    // log('Parent: ' + appDocDirectory.parent.path);
    new Directory(appDocDirectory.path + '/chats')
        .create(recursive: true)
        .then((Directory directory) {
      // print('Path of New Dir: ' + directory.path);
    });

    var chatsFile = File(appDocDirectory.path + '/chats/chats.json');
    var userFile = File(appDocDirectory.path + '/chats/users.json');
    var messageFile = File(appDocDirectory.path + '/chats/messsages.json');

log(chatsFile.path);
    if (userFile.exists() != true) {
      userFile.create();
          List userList = [];
    List chatsList = [];
    List messageList = [];

    for (var i = 0; i < chats.length; i++) {
      Message tempMesage;
      // if (chats[i].sender.id == widget.user.id && chats[i].unread) {

      tempMesage = Message(
          sender: chats[i].sender,
          time: chats[i].time,
          text: chats[i].text,
          isLiked: chats[i].isLiked,
          unread: chats[i].unread);

      User user = User(
          id: chats[i].sender.id,
          name: chats[i].sender.name,
          imageUrl: chats[i].sender.imageUrl);
      // chats.removeAt(i);
      // log(chats[i].text);
      // log(tempMesage.text.toString());
      var encodeChats = tempMesage.toJson(tempMesage);
      var encodeUsers = user.toJson(user);
      // check.add(jsonEncode(test));
      chatsList.add(encodeChats);
      userList.add(encodeUsers);

      // log(check);

      // chats.insert(chats.length, tempMesage);
      // chats[i] = tempMesage;
      // chats[i].unread=false;

    }
    for (var i = 0; i < messages.length; i++) {
      Message tempMesage;
      tempMesage = Message(
          sender: messages[i].sender,
          time: messages[i].time,
          text: messages[i].text,
          isLiked: messages[i].isLiked,
          unread: messages[i].unread);

      User user = User(
          id: messages[i].sender.id,
          name: messages[i].sender.name,
          imageUrl: messages[i].sender.imageUrl);
      // chats.removeAt(i);
      // log(chats[i].text);
      // log(tempMesage.text.toString());
      var encodeMessages = tempMesage.toJson(tempMesage);
      // check.add(jsonEncode(test));
      messageList.add(encodeMessages);

      // log(check);

      // chats.insert(chats.length, tempMesage);
      // chats[i] = tempMesage;
      // chats[i].unread=false;

    }

    // log('Check: ' + check.toString());
// /
    // chatsFile.writeAsStringSync(jsonEncode(chatsList));
    // userFile.writeAsStringSync(jsonEncode(userList));
    // messageFile.writeAsStringSync(jsonEncode(messageList));

    }
    if (chatsFile.exists() != true) {
      chatsFile.create();
    }
    if (messageFile.exists() != true) {
      messageFile.create();
    }

    // log('File: ' + chatsFile.toString());
    final SecurityContext context = SecurityContext.defaultContext;
    // String crtPath = await _getLocalFile("client.crt");
    // context.setTrustedCertificates(file.path);

    // chatsFile.readAsString().then((value) => log(value));

    // final data = await json.decode(response);
    setState(() {
      // _items = data["items"];
    });


    // file.writeAsStringSync(check);
    // file.writeAsString(check.add());
    //  check.forEach((element) { file
    //       .writeAsString(element)
    //       .then((value) => log(value.toString()))
    //       .onError((error, stackTrace) => print(error));});

    // file.readAsString().then((value) => log(value));
    // _items.forEach((element) {log(element['id']);});
  }

  @override
  Widget build(BuildContext context) {
    initializeChatData();

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: ListView.builder(
            itemCount: RecentChats.recentChatDataCount,
            itemBuilder: (BuildContext context, int index) {
              final User user = User(
                  id: RecentChats.recentChatData[index]['sender']['id'],
                  name: RecentChats.recentChatData[index]['sender']['name'],
                  imageUrl: RecentChats.recentChatData[index]['sender']
                      ['imageUrl']);
              final Message chat = Message(
                  sender: user,
                  time: RecentChats.recentChatData[index]['time'],
                  text: RecentChats.recentChatData[index]['text'],
                  isLiked: RecentChats.recentChatData[index]['isLiked'],
                  unread: RecentChats.recentChatData[index]['unread']);
              // final Message chat = ;
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(
                      user: chat.sender,
                    ),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: chat.unread ? Color(0xFFFFEFEE) : Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage: AssetImage(chat.sender.imageUrl),
                          ),
                          SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                chat.sender.name,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Text(
                                  chat.text,
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            chat.time,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          chat.unread
                              ? Container(
                                  width: 40.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'NEW',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : Text(''),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  initializeChatData() async {
    // log('getfile');

    Directory appDocDirectory = await getApplicationDocumentsDirectory();

    Directory(appDocDirectory.path + '/chats')
        .create(recursive: true)
        .then((Directory directory) {});

    recentChatsFile = File(appDocDirectory.path + '/chats/chats.json');

    directory = ((await getApplicationDocumentsDirectory()).path) + '/chats';

    file = File(directory + '/user.json');
    // log(file.path);
    List recentChatData = [];
    recentChatData = await jsonDecode(recentChatsFile.readAsStringSync());

    setState(() {
      RecentChats.recentChatData = recentChatData;
    });
    // log(ChatScreen.chatData.toString());
    if (RecentChats.recentChatData == null) {
      initializeChatData();
    }
    if (RecentChats.recentChatData.isNotEmpty) {
      RecentChats.recentChatDataCount = RecentChats.recentChatData.length;
      build(context);
    } else
      initializeChatData();

    return RecentChats.recentChatDataCount;
  }
}
