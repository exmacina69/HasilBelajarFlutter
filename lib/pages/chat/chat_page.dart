import 'package:flutter/material.dart';

class Profile {
  final String name;
  final String avatar;

  Profile(this.name, this.avatar);
}

class Message {
  final String sender;
  final String text;
  final bool isSentByMe;

  Message(this.sender, this.text, this.isSentByMe);
}

class ChatPage extends StatefulWidget {
  final Profile profile;

  ChatPage({required this.profile});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> messages = [];
  TextEditingController messageController = TextEditingController();

  void sendMessage() {
    String messageText = messageController.text.trim();
    if (messageText.isNotEmpty) {
      Message newMessage = Message(widget.profile.name, messageText, true);
      setState(() {
        messages.add(newMessage);
      });
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        backgroundColor: Color.fromARGB(255, 248, 107, 20),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                Message message = messages[index];
                return Align(
                  alignment: message.isSentByMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: message.isSentByMe
                          ? Colors.orange
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: message.isSentByMe ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 50),
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                FloatingActionButton(
                  onPressed: sendMessage,
                  child: Icon(Icons.send),
                  mini: true,
                  backgroundColor: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessengerHomePage extends StatefulWidget {
  @override
  _MessengerHomePageState createState() => _MessengerHomePageState();
}

class _MessengerHomePageState extends State<MessengerHomePage> {
  List<Profile> profiles = [
    Profile('Twitter', 'assets/image/avatar1.png'),
    Profile('Ultra Milk', 'assets/image/avatar2.png'),
    Profile('Facebook', 'assets/image/avatar3.png'),
    Profile('Kompas TV', 'assets/image/avatar4.png'),
    Profile('Gudang Garam', 'assets/image/avatar5.png'),
  ];

  Profile? selectedProfile;

  @override
  void initState() {
    super.initState();
    selectedProfile = profiles[0];
  }

  void selectProfile(Profile profile) {
    setState(() {
      selectedProfile = profile;
    });
  }

  void goToChat() {
    if (selectedProfile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(profile: selectedProfile!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        backgroundColor: Color.fromARGB(255, 248, 107, 20),
      ),
      body: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          Profile profile = profiles[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(profile.avatar),
            ),
            title: Text(profile.name),
            onTap: () => selectProfile(profile),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goToChat,
        child: Icon(Icons.chat),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MessengerHomePage(),
  ));
}
