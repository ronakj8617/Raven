import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:raven/models/message_model.dart';
import 'package:raven/models/user_model.dart';

class ChatScreen extends StatefulWidget {
  final User user;
  static List messageData = [];
  static int messageDataCount = 0;

  const ChatScreen({super.key, required this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  static const String kFileName = 'myJsonFile.json';

  bool _fileExists = false;
  File? _filePath;
  late String directory;
  File file = File('');
  File messagesFile = File('');

  // First initialization of _json (if there is no json in the file)
  Map<String, dynamic> _json = {};
  late String _jsonString;

  Future<String> get _localPath async {
    final directory = Directory("/Users/ronak/Documents/TextApp$kFileName");
    // final directory = await getApplicationDocumentsDirectory();

    if (directory.exists() == false) {
      directory.create();
    }

    // log(directory.path.toString());
    // log(directory.path);

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$kFileName');
  }

  void _writeJson(String key, dynamic value) async {
    // Initialize the local _filePath
    //final _filePath = await _localFile;

    //1. Create _newJson<Map> from input<TextField>
    Map<String, dynamic> newJson = {key: value};
    print('1.(_writeJson) _newJson: $newJson');

    //2. Update _json by adding _newJson<Map> -> _json<Map>
    _json.addAll(newJson);
    print('2.(_writeJson) _json(updated): $_json');

    //3. Convert _json ->_jsonString
    _jsonString = jsonEncode(_json);
    print('3.(_writeJson) _jsonString: $_jsonString\n - \n');

    //4. Write _jsonString to the _filePath
    _filePath?.writeAsString(_jsonString);
  }

  void _readJson() async {
    // Initialize _filePath
    _filePath = await _localFile;

    // 0. Check whether the _file exists
    _fileExists = (await _filePath?.exists())!;
    print('0. File exists? $_fileExists');

    // If the _file exists->read it: update initialized _json by what's in the _file
    if (_fileExists) {
      try {
        //1. Read _jsonString<String> from the _file.
        _jsonString = (await _filePath?.readAsString())!;
        // log('Read');
        print('1.(_readJson) _jsonString: $_jsonString');

        //2. Update initialized _json by converting _jsonString<String>->_json<Map>
        _json = jsonDecode(_jsonString);
        print('2.(_readJson) _json: $_json \n - \n');
      } catch (e) {
        // Print exception errors
        print('Tried reading _file error: $e');
        // If encountering an error, return null
      }
    }
  }

  final List _items = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/chats.json');
    // log('Response: ' + response);

    final test = rootBundle.loadString('assets/chats.json');
    // log('test');

    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    // log('Parent: ' + appDocDirectory.parent.path);
    Directory('${appDocDirectory.path}/chats')
        .create(recursive: true)
        .then((Directory directory) {
      // print('Path of New Dir: ' + directory.path);
    });

    var chatsFile = File('${appDocDirectory.path}/chats/chats.json');
    var userFile = File('${appDocDirectory.path}/chats/users.json');
    var messageFile = File('${appDocDirectory.path}/chats/messsages.json');

    if (userFile.exists() != true) {
      userFile.create();
    }
    if (chatsFile.exists() != true) {
      chatsFile.create();
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

    List userList = [];
    List chatsList = [];
    List messageList = [];

    for (var i = 0; i < chats.length; i++) {
      Message tempMesage;
      // if (chats[i].sender.id == widget.user.id && chats[i].unread) {
      if (chats[i].sender.name == widget.user.name) {
        log('Widget Username: ${widget.user.name}');
        // log('message');
        tempMesage = Message(
            sender: chats[i].sender,
            time: chats[i].time,
            text: chats[i].text,
            isLiked: chats[i].isLiked,
            unread: false);
      } else {
        tempMesage = Message(
            sender: chats[i].sender,
            time: chats[i].time,
            text: chats[i].text,
            isLiked: chats[i].isLiked,
            unread: chats[i].unread);
      }
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
      if (chats[i].sender.id == widget.user.id) {
        // log('message');
        tempMesage = Message(
            sender: messages[i].sender,
            time: messages[i].time,
            text: messages[i].text,
            isLiked: messages[i].isLiked,
            unread: false);
      } else {
        tempMesage = Message(
            sender: messages[i].sender,
            time: messages[i].time,
            text: messages[i].text,
            isLiked: messages[i].isLiked,
            unread: messages[i].unread);
      }

      // chats.removeAt(i);
      // log(chats[i].text);
      var encodeMessages = tempMesage.toJson(tempMesage);
      // check.add(jsonEncode(test));
      messageList.add(encodeMessages);
      // log(check);

      // chats.insert(chats.length, tempMesage);
      // chats[i] = tempMesage;
      // chats[i].unread=false;

    }


    // log('Check: ' + check.toString());
    // chatsFile.delete();
    // userFile.delete();
    // messagesFile.delete();

    chatsFile.writeAsStringSync(jsonEncode(chatsList));
    userFile.writeAsStringSync(jsonEncode(userList));
    messagesFile.writeAsStringSync(jsonEncode(messageList));

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
  void initState() {
    super.initState();

    readJson();
    readJson();

    initializeFiles();
    initializeMessageData();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => initializeMessageData());
    initializeMessageData();
    // readJson();
    initializeFiles();
    // print('0. Initialized _json: $_json');
    // _writeJson('key', 'value');
    // _readJson();

    // for (var i = 0; i < chats.length; i++) {
    //   if (chats[i].sender.id == widget.user.id && chats[i].unread) {
    //     // log('message');
    //     Message tempMesage = Message(
    //         sender: chats[i].sender,
    //         time: chats[i].time,
    //         text: chats[i].text,
    //         isLiked: chats[i].isLiked,
    //         unread: false);
    //     chats.removeAt(i);
    //     // log(chats[i].text);
    //     var test = tempMesage.toJson(tempMesage);
    //     var check = jsonEncode(test);
    //     // log(check);

    //     chats.insert(chats.length, tempMesage);
    //     // chats[i] = tempMesage;
    //     // chats[i].unread=false;
    //   }
    // }
  }

  @override
  _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: isMe ? Theme.of(context).primaryColor : const Color(0xFFFFEFEE),
        borderRadius: isMe
            ? const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : const BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.time,
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            message.text,
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
        IconButton(
          icon: message.isLiked
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border),
          iconSize: 30.0,
          color: message.isLiked
              ? Theme.of(context).primaryColor
              : Colors.blueGrey,
          onPressed: () {},
        )
      ],
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.photo),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: const InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (ChatScreen.messageData.isEmpty) {
      initializeMessageData();
    } else {
      // print(ChatScreen.chatData);
    }
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          widget.user.name,
          style: const TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      // topLeft: Radius.circular(30.0),
                      // topRight: Radius.circular(30.0),
                      ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.only(top: 15.0),
                    itemCount: ChatScreen.messageDataCount,
                    itemBuilder: (BuildContext context, int index) {
                      final User user = User(
                          id: ChatScreen.messageData[index]['sender']['id'],
                          name: ChatScreen.messageData[index]['sender']['name'],
                          imageUrl: ChatScreen.messageData[index]['sender']
                              ['imageUrl']);
                      final Message message = Message(
                          sender: user,
                          time: ChatScreen.messageData[index]['time'],
                          text: ChatScreen.messageData[index]['text'],
                          isLiked: ChatScreen.messageData[index]['isLiked'],
                          unread: ChatScreen.messageData[index]['unread']);
                      // final Message message = Message(ChatScreen.chatData[index]['']);
                      final bool isMe = message.sender.id == currentUser.id;

                      return _buildMessage(message, isMe);
                    },
                  ),
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }

  Future<void> initializeFiles() async {
    _filePath = await _localFile;
  }

  initializeMessageData() async {
    // log('getfile');
    Directory appDocDirectory = await getApplicationDocumentsDirectory();

    Directory('${appDocDirectory.path}/chats')
        .create(recursive: true)
        .then((Directory directory) {});

    messagesFile = File('${appDocDirectory.path}/chats/messages.json');

    directory = '${(await getApplicationDocumentsDirectory()).path}/chats';

    setState(() {
      file = File('$directory/messages.json');
    });

    List messageData = [];
    messageData = await jsonDecode(messagesFile.readAsStringSync());

    ChatScreen.messageData = messageData;
    // log(ChatScreen.chatData.toString());
    if (ChatScreen.messageData == null) {
      initializeMessageData();
    }
    if (ChatScreen.messageData.isNotEmpty) {
      ChatScreen.messageDataCount = ChatScreen.messageData.length;
    } else {
      initializeMessageData();
    }

    return ChatScreen.messageDataCount;
  }
}
