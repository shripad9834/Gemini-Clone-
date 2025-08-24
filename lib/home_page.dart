// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//   final Gemini gemini = Gemini.instance;
//
//   List<ChatMessage> messages = [];
//   ChatUser currentUser = ChatUser(id: "0",firstName: "User");
//   ChatUser geminiUser = ChatUser(id: "1",firstName: "Gemini",profileImage: "assets/images/geminilogo.png");
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("Gemini Chat"),
//       ),
//
//       body: _buildUI(),
//     );
//   }
//
//   Widget _buildUI(){
//     return DashChat(currentUser: currentUser, onSend: _sendMessage, messages: messages);
//   }
//
//   void _sendMessage(ChatMessage chatMessage){
//     setState(() {
//       messages = [chatMessage, ...messages];
//     });
//
//     try{
//       String question = chatMessage.text;
//       gemini.streamGenerateContent(question).listen((event) {
//         ChatMessage? lastMessage = messages.firstOrNull;
//         if(lastMessage != null && lastMessage.user == geminiUser){
//           lastMessage = messages.removeAt(0);
//           String response = event.content?.parts?.fold("", (previous, current) => "$previous${current.text}") ?? "";
//           lastMessage.text += response;
//           setState(() {
//             messages = [lastMessage!, ...messages];
//           });
//         }else{
//           String response = event.content?.parts?.fold("", (previous, current) => "$previous${current.text}") ?? "";
//           ChatMessage message = ChatMessage(user: geminiUser, createdAt: DateTime.now(),text: response);
//           setState(() {
//             messages = [message, ...messages];
//           });
//         }
//       });
//     }catch(e){
//
//     }
//   }
// }


// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
// import 'package:image_picker/image_picker.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final Gemini gemini = Gemini.instance;
//
//   List<ChatMessage> messages = [];
//   ChatUser currentUser = ChatUser(id: "0", firstName: "User");
//   ChatUser geminiUser = ChatUser(
//     id: "1",
//     firstName: "Gemini",
//     profileImage: "assets/images/geminilogo.png",
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("Gemini Chat"),
//       ),
//       body: _buildUI(),
//     );
//   }
//
//   Widget _buildUI() {
//     return DashChat(
//       inputOptions: InputOptions(
//         trailing: [
//           IconButton(
//             onPressed: _sendMediaMessage,
//             icon: Icon(Icons.image),
//           )
//         ]
//       ),
//       currentUser: currentUser,
//       onSend: _sendMessage,
//       messages: messages,
//     );
//   }
//
//   void _sendMessage(ChatMessage chatMessage) {
//     setState(() {
//       messages = [chatMessage, ...messages];
//     });
//
//     try {
//       String question = chatMessage.text;
//       List<Uint8List>? images;
//       if(chatMessage.medias?.isNotEmpty ?? false){
//         images = [File(chatMessage.medias!.first.url).readAsBytesSync(),];
//       }
//
//       gemini.streamGenerateContent(question,images: images).listen((event) {
//         ChatMessage? lastMessage = messages.isNotEmpty ? messages.first : null;
//
//         String response = event.content?.parts
//             ?.whereType<TextPart>() // Ensure only TextPart is processed
//             .map((part) => part.text) // Extract actual text
//             .join(" ") ?? "I'm sorry, I couldn't generate a response.";
//
//         if (lastMessage != null && lastMessage.user == geminiUser) {
//           messages.removeAt(0);
//           lastMessage.text += response;
//           setState(() {
//             messages = [lastMessage, ...messages];
//           });
//         } else {
//           ChatMessage message = ChatMessage(
//             user: geminiUser,
//             createdAt: DateTime.now(),
//             text: response,
//           );
//           setState(() {
//             messages = [message, ...messages];
//           });
//         }
//       });
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
//
//   void _sendMediaMessage() async{
//     ImagePicker picker = ImagePicker();
//     XFile? file = await picker.pickImage(source: ImageSource.gallery);
//
//     if(file != null){
//       ChatMessage chatMessage = ChatMessage(user: currentUser, createdAt: DateTime.now(),text: "Describe this picture",medias: [
//         ChatMedia(url: file.path, fileName: "", type: MediaType.image),
//       ]);
//
//       _sendMessage(chatMessage);
//     }
//   }
// }

//Final without database





// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/foundation.dart' show kIsWeb; // For platform check
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final Gemini gemini = Gemini.instance;
//
//   List<ChatMessage> messages = [];
//   ChatUser currentUser = ChatUser(id: "0", firstName: "User");
//   ChatUser geminiUser = ChatUser(
//     id: "1",
//     firstName: "Gemini",
//     profileImage: "assets/images/geminilogo.png",
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("Gemini Chat"),
//       ),
//       body: _buildUI(),
//     );
//   }
//
//   Widget _buildUI() {
//     return DashChat(
//       inputOptions: InputOptions(
//         trailing: [
//           IconButton(
//             onPressed: _sendMediaMessage,
//             icon: Icon(Icons.image),
//           ),
//         ],
//       ),
//       currentUser: currentUser,
//       onSend: _sendMessage,
//       messages: messages,
//     );
//   }
//
//   void _sendMessage(ChatMessage chatMessage) async{
//     setState(() {
//       messages = [chatMessage, ...messages];
//     });
//
//     try {
//       String question = chatMessage.text;
//       List<Uint8List>? images;
//
//       if (chatMessage.medias?.isNotEmpty ?? false) {
//         if (kIsWeb) {
//           images = [await XFile(chatMessage.medias!.first.url).readAsBytes()];
//         } else {
//           images = [File(chatMessage.medias!.first.url).readAsBytesSync()];
//         }
//       }
//
//       gemini.streamGenerateContent(question, images: images).listen((event) {
//         ChatMessage? lastMessage = messages.isNotEmpty ? messages.first : null;
//
//         String response = event.content?.parts
//             ?.whereType<TextPart>()
//             .map((part) => part.text)
//             .join(" ") ??
//             "I'm sorry, I couldn't generate a response.";
//
//         if (lastMessage != null && lastMessage.user == geminiUser) {
//           messages.removeAt(0);
//           ChatMessage updatedMessage = ChatMessage(
//             user: lastMessage.user,
//             createdAt: lastMessage.createdAt,
//             text: "${lastMessage.text}\n\n$response",
//           );
//           setState(() {
//             messages = [updatedMessage, ...messages];
//           });
//         } else {
//           ChatMessage message = ChatMessage(
//             user: geminiUser,
//             createdAt: DateTime.now(),
//             text: response,
//           );
//           setState(() {
//             messages = [message, ...messages];
//           });
//         }
//       });
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
//
//   void _sendMediaMessage() async {
//     ImagePicker picker = ImagePicker();
//     XFile? file = await picker.pickImage(source: ImageSource.gallery);
//
//     if (file == null) return; // ✅ Handle cancellation
//
//     ChatMessage chatMessage = ChatMessage(
//       user: currentUser,
//       createdAt: DateTime.now(),
//       text: "Describe this picture",
//       medias: [
//         ChatMedia(url: file.path, fileName: "", type: MediaType.image),
//       ],
//     );
//
//     _sendMessage(chatMessage);
//   }
// }


// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/foundation.dart' show kIsWeb; // For platform check
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final Gemini gemini = Gemini.instance;
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//   List<ChatMessage> messages = [];
//   ChatUser currentUser = ChatUser(id: "0", firstName: "User");
//   ChatUser geminiUser = ChatUser(
//     id: "1",
//     firstName: "Gemini",
//     profileImage: "assets/images/geminilogo.png",
//   );
//
//   String? selectedChatId;
//   List<Map<String, dynamic>> chatList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadChats();
//   }
//
//   /// Load available chat sessions
//   Future<void> _loadChats() async {
//     final snapshot = await firestore.collection("chats").orderBy("createdAt", descending: true).get();
//     setState(() {
//       chatList = snapshot.docs.map((doc) {
//         return {"id": doc.id, "name": doc["name"] ?? "Chat ${doc.id.substring(0, 6)}"};
//       }).toList();
//     });
//
//     if (chatList.isNotEmpty) {
//       _loadMessages(chatList.first["id"]); // Load latest chat by default
//     }
//   }
//
//   /// Load messages for a specific chat session
//   Future<void> _loadMessages(String chatId) async {
//     final snapshot = await firestore
//         .collection("chats")
//         .doc(chatId)
//         .collection("messages")
//         .orderBy("createdAt", descending: true)
//         .get();
//
//     setState(() {
//       selectedChatId = chatId;
//       messages = snapshot.docs.map((doc) {
//         var data = doc.data();
//         return ChatMessage(
//           user: data["userId"] == "0" ? currentUser : geminiUser,
//           createdAt: (data["createdAt"] as Timestamp).toDate(),
//           text: data["text"],
//         );
//       }).toList();
//     });
//   }
//
//   /// Create a new chat session
//   Future<void> _createNewChat() async {
//     DocumentReference newChat = await firestore.collection("chats").add({
//       "name": "New Chat",
//       "createdAt": FieldValue.serverTimestamp(),
//     });
//
//     setState(() {
//       chatList.insert(0, {"id": newChat.id, "name": "New Chat"});
//     });
//
//     _loadMessages(newChat.id);
//   }
//
//   /// Save a message to Firestore
//   Future<void> _saveMessage(ChatMessage chatMessage) async {
//     if (selectedChatId == null) return;
//
//     await firestore.collection("chats").doc(selectedChatId).collection("messages").add({
//       "userId": chatMessage.user.id,
//       "text": chatMessage.text,
//       "createdAt": chatMessage.createdAt,
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(centerTitle: true, title: Text("Gemini Chat")),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(color: Colors.blue),
//               child: Text("Menu", style: TextStyle(color: Colors.white, fontSize: 24)),
//             ),
//             ListTile(
//               leading: Icon(Icons.add),
//               title: Text("New Chat"),
//               onTap: () {
//                 _createNewChat();
//                 Navigator.pop(context);
//               },
//             ),
//             Divider(),
//             ...chatList.map((chat) => ListTile(
//               leading: Icon(Icons.chat),
//               title: Text(chat["name"]),
//               onTap: () {
//                 _loadMessages(chat["id"]);
//                 Navigator.pop(context);
//               },
//             )),
//           ],
//         ),
//       ),
//       body: _buildUI(),
//     );
//   }
//
//   Widget _buildUI() {
//     return DashChat(
//       inputOptions: InputOptions(
//         trailing: [
//           IconButton(onPressed: _sendMediaMessage, icon: Icon(Icons.image)),
//         ],
//       ),
//       currentUser: currentUser,
//       onSend: _sendMessage,
//       messages: messages,
//     );
//   }
//
//   void _sendMessage(ChatMessage chatMessage) async {
//     setState(() {
//       messages = [chatMessage, ...messages];
//     });
//
//     _saveMessage(chatMessage);
//
//     try {
//       String question = chatMessage.text;
//       List<Uint8List>? images;
//
//       if (chatMessage.medias?.isNotEmpty ?? false) {
//         if (kIsWeb) {
//           images = [await XFile(chatMessage.medias!.first.url).readAsBytes()];
//         } else {
//           images = [File(chatMessage.medias!.first.url).readAsBytesSync()];
//         }
//       }
//
//       gemini.streamGenerateContent(question, images: images).listen((event) {
//         ChatMessage? lastMessage = messages.isNotEmpty ? messages.first : null;
//
//         String response = event.content?.parts
//             ?.whereType<TextPart>()
//             .map((part) => part.text)
//             .join(" ") ??
//             "I'm sorry, I couldn't generate a response.";
//
//         if (lastMessage != null && lastMessage.user == geminiUser) {
//           messages.removeAt(0);
//           ChatMessage updatedMessage = ChatMessage(
//             user: lastMessage.user,
//             createdAt: lastMessage.createdAt,
//             text: "${lastMessage.text}\n\n$response",
//           );
//           setState(() {
//             messages = [updatedMessage, ...messages];
//           });
//           _saveMessage(updatedMessage);
//         } else {
//           ChatMessage message = ChatMessage(
//             user: geminiUser,
//             createdAt: DateTime.now(),
//             text: response,
//           );
//           setState(() {
//             messages = [message, ...messages];
//           });
//           _saveMessage(message);
//         }
//       });
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
//
//   void _sendMediaMessage() async {
//     ImagePicker picker = ImagePicker();
//     XFile? file = await picker.pickImage(source: ImageSource.gallery);
//
//     if (file == null) return;
//
//     ChatMessage chatMessage = ChatMessage(
//       user: currentUser,
//       createdAt: DateTime.now(),
//       text: "Describe this picture",
//       medias: [
//         ChatMedia(url: file.path, fileName: "", type: MediaType.image),
//       ],
//     );
//
//     _sendMessage(chatMessage);
//   }
// }



import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // For platform check

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Gemini gemini = Gemini.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<ChatMessage> messages = [];
  String? currentChatId; // Store the active chat ID
  Map<String, String> chatNames = {}; // Store chat names for the drawer
  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "Gemini",
    profileImage: "assets/images/geminilogo.png",
  );

  @override
  void initState() {
    super.initState();
    _loadChats();
    _showInitialMessageIfNoChats();
  }


  Future<void> _showInitialMessageIfNoChats() async {
    final snapshot = await firestore.collection("chats").get();
    if (snapshot.docs.isEmpty) {
      setState(() {
        messages.add(ChatMessage(
          user: geminiUser,
          createdAt: DateTime.now(),
          text: "What can I help with?",
        ));
      });
    }
  }

  Future<void> _loadChats() async {
    final snapshot = await firestore.collection("chats").orderBy("createdAt", descending: true).get();
    setState(() {
      chatNames = {for (var doc in snapshot.docs) doc.id: doc["name"]};
    });
  }

  // Future<void> _loadMessages(String chatId) async {
  //   final snapshot = await firestore.collection("chats").doc(chatId).collection("messages").orderBy("createdAt", descending: true).get();
  //   setState(() {
  //     currentChatId = chatId;
  //     messages = snapshot.docs.map((doc) {
  //       var data = doc.data();
  //       return ChatMessage(
  //         user: data["userId"] == "0" ? currentUser : geminiUser,
  //         createdAt: (data["createdAt"] as Timestamp).toDate(),
  //         text: data["text"],
  //       );
  //     }).toList();
  //   });
  // }

  Future<void> _loadMessages(String chatId) async {
    final snapshot = await firestore.collection("chats").doc(chatId).collection("messages").orderBy("createdAt", descending: true).get();

    setState(() {
      currentChatId = chatId;
      messages = snapshot.docs.map((doc) {
        var data = doc.data();
        return ChatMessage(
          user: data["userId"] == "0" ? currentUser : geminiUser,
          createdAt: (data["createdAt"] as Timestamp).toDate(),
          text: data["text"],
          medias: (data["medias"] as List<dynamic>?)
              ?.map((m) => ChatMedia.fromJson(Map<String, dynamic>.from(m)))
              .toList(),
        );
      }).toList();
    });
  }


  // Future<void> _saveMessage(ChatMessage chatMessage) async {
  //   if (currentChatId == null) {
  //     // Create a new chat based on the first message
  //     String chatName = chatMessage.text.split(" ").take(5).join(" "); // Short name from first message
  //     DocumentReference newChatRef = await firestore.collection("chats").add({
  //       "name": chatName,
  //       "createdAt": Timestamp.now(),
  //     });
  //
  //     setState(() {
  //       currentChatId = newChatRef.id;
  //       chatNames[currentChatId!] = chatName;
  //     });
  //   }
  //
  //   await firestore.collection("chats").doc(currentChatId).collection("messages").add({
  //     "userId": chatMessage.user.id,
  //     "text": chatMessage.text,
  //     "createdAt": chatMessage.createdAt,
  //   });
  //
  //   _loadChats(); // Update chat list
  // }

  Future<void> _saveMessage(ChatMessage chatMessage) async {
    if (currentChatId == null) {
      String chatName = chatMessage.text.split(" ").take(5).join(" "); // Short name from first message
      DocumentReference newChatRef = await firestore.collection("chats").add({
        "name": chatName,
        "createdAt": Timestamp.now(),
      });

      setState(() {
        currentChatId = newChatRef.id;
        chatNames[currentChatId!] = chatName;
      });
    }

    await firestore.collection("chats").doc(currentChatId).collection("messages").add({
      "userId": chatMessage.user.id,
      "text": chatMessage.text,
      "createdAt": chatMessage.createdAt,
      "medias": chatMessage.medias?.map((m) => m.toJson()).toList() ?? [],
    });

    _loadChats(); // Update chat list
  }



  // Future<void> _saveMessage(ChatMessage chatMessage) async {
  //   if (currentChatId == null) {
  //     // Create a new chat based on the first message
  //     String chatName = chatMessage.text.split(" ").take(5).join(" "); // Short name from first message
  //     DocumentReference newChatRef = await firestore.collection("chats").add({
  //       "name": chatName,
  //       "createdAt": Timestamp.now(),
  //     });
  //
  //     setState(() {
  //       currentChatId = newChatRef.id;
  //       chatNames[currentChatId!] = chatName;
  //       messages = [
  //         ChatMessage(
  //           user: geminiUser,
  //           createdAt: DateTime.now(),
  //           text: "What can I help with?",
  //         ),
  //       ];
  //     });
  //
  //     // Save initial AI message in Firestore
  //     await firestore.collection("chats").doc(currentChatId).collection("messages").add({
  //       "userId": geminiUser.id,
  //       "text": "What can I help with?",
  //       "createdAt": Timestamp.now(),
  //     });
  //   }
  //
  //   // Remove the initial message when the user sends their first message
  //   if (messages.isNotEmpty && messages.first.text == "What can I help with?") {
  //     setState(() {
  //       messages.removeAt(0);
  //     });
  //
  //     // Remove it from Firestore
  //     final snapshot = await firestore
  //         .collection("chats")
  //         .doc(currentChatId)
  //         .collection("messages")
  //         .where("text", isEqualTo: "What can I help with?")
  //         .get();
  //
  //     for (var doc in snapshot.docs) {
  //       await doc.reference.delete();
  //     }
  //   }
  //
  //   // Save user message
  //   await firestore.collection("chats").doc(currentChatId).collection("messages").add({
  //     "userId": chatMessage.user.id,
  //     "text": chatMessage.text,
  //     "createdAt": chatMessage.createdAt,
  //   });
  //
  //   _loadChats(); // Update chat list
  // }


  Future<void> _confirmDeleteChat(String chatId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Chat"),
          content: Text("Are you sure you want to delete this chat?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await _deleteChat(chatId);
                Navigator.pop(context);
              },
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _renameChat(String chatId) async {
    TextEditingController renameController = TextEditingController(text: chatNames[chatId]);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Rename Chat"),
          content: TextField(
            controller: renameController,
            decoration: InputDecoration(hintText: "Enter new chat name"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                String newName = renameController.text.trim();
                if (newName.isNotEmpty) {
                  await firestore.collection("chats").doc(chatId).update({"name": newName});
                  setState(() {
                    chatNames[chatId] = newName;
                  });
                }
                Navigator.pop(context);
              },
              child: Text("Rename"),
            ),
          ],
        );
      },
    );
  }


  Future<void> _deleteChat(String chatId) async {
    await firestore.collection("chats").doc(chatId).delete();
    setState(() {
      chatNames.remove(chatId);
      if (currentChatId == chatId) {
        messages.clear();
        currentChatId = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.blue.shade900],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text("Gemini Chat", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              //decoration: BoxDecoration(color: Colors.blue),

              child: Center(child: Text("Chats", style: TextStyle(color: Colors.black, fontSize: 24,))),
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text("New Chat"),
              onTap: () {
                setState(() {
                  messages.clear();
                  currentChatId = null;
                  messages.add(ChatMessage(
                    user: geminiUser,
                    createdAt: DateTime.now(),
                    text: "What can I help with?",
                  ));
                });
                Navigator.pop(context); // Close drawer after selecting new chat
              },
            ),
            Divider(),
            ...chatNames.entries.map((entry) => ListTile(
              title: GestureDetector(
                onLongPress: () => _renameChat(entry.key),
                child: Text(entry.value),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => _confirmDeleteChat(entry.key),
              ),
              onTap: () {
                _loadMessages(entry.key);
                Navigator.pop(context);
              },
            )),

          ],
        ),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return DashChat(
      inputOptions: InputOptions(
        trailing: [
          IconButton(onPressed: _sendMediaMessage, icon: Icon(Icons.image)),
        ],
      ),
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
    );
  }

  void _sendMessage(ChatMessage chatMessage) async {
    setState(() {
      messages = [chatMessage, ...messages];
    });

    _saveMessage(chatMessage);

    try {
      String question = chatMessage.text;
      List<Uint8List>? images;

      if (chatMessage.medias?.isNotEmpty ?? false) {
        if (kIsWeb) {
          images = [await XFile(chatMessage.medias!.first.url).readAsBytes()];
        } else {
          images = [File(chatMessage.medias!.first.url).readAsBytesSync()];
        }
      }

      gemini.streamGenerateContent(question, images: images).listen((event) {
        ChatMessage? lastMessage = messages.isNotEmpty ? messages.first : null;

        String response = event.content?.parts
            ?.whereType<TextPart>()
            .map((part) => part.text)
            .join(" ") ??
            "I'm sorry, I couldn't generate a response.";

        if (lastMessage != null && lastMessage.user == geminiUser) {
          messages.removeAt(0);
          ChatMessage updatedMessage = ChatMessage(
            user: lastMessage.user,
            createdAt: lastMessage.createdAt,
            text: "${lastMessage.text}\n\n$response",
          );
          setState(() {
            messages = [updatedMessage, ...messages];
          });
          _saveMessage(updatedMessage);
        } else {
          ChatMessage message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
          );
          setState(() {
            messages = [message, ...messages];
          });
          _saveMessage(message);
        }
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  void _sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file == null) return;

    ChatMessage chatMessage = ChatMessage(
      user: currentUser,
      createdAt: DateTime.now(),
      text: "Describe this picture",
      medias: [
        ChatMedia(url: file.path, fileName: "", type: MediaType.image),
      ],
    );

    _sendMessage(chatMessage);
  }
}




















// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final Gemini gemini = Gemini.instance;
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//   List<ChatMessage> messages = [];
//   String? currentChatId;
//   Map<String, String> chatNames = {};
//   ChatUser currentUser = ChatUser(id: "0", firstName: "User");
//   ChatUser geminiUser = ChatUser(
//     id: "1",
//     firstName: "Gemini",
//     profileImage: "assets/images/geminilogo.png",
//   );
//
//   @override
//   void initState() {
//     super.initState();
//     _loadChats();
//   }
//
//
//   Future<void> _loadChats() async {
//     final snapshot = await firestore.collection("chats").orderBy("createdAt", descending: true).get();
//     setState(() {
//       chatNames = {for (var doc in snapshot.docs) doc.id: doc["name"]};
//     });
//   }
//
//   Future<void> _loadMessages(String chatId) async {
//     final snapshot = await firestore.collection("chats").doc(chatId).collection("messages").orderBy("createdAt", descending: true).get();
//
//     setState(() {
//       currentChatId = chatId;
//       messages = snapshot.docs.map((doc) {
//         var data = doc.data();
//         return ChatMessage(
//           user: data["userId"] == "0" ? currentUser : geminiUser,
//           createdAt: (data["createdAt"] as Timestamp).toDate(),
//           text: data["text"],
//           medias: (data["medias"] as List<dynamic>?)
//               ?.map((m) => ChatMedia.fromJson(Map<String, dynamic>.from(m)))
//               .toList(),
//         );
//       }).toList();
//     });
//   }
//
//   Future<void> _saveMessage(ChatMessage chatMessage) async {
//     if (currentChatId == null) {
//       String chatName = chatMessage.text.split(" ").take(5).join(" ");
//       DocumentReference newChatRef = await firestore.collection("chats").add({
//         "name": chatName,
//         "createdAt": Timestamp.now(),
//       });
//
//       setState(() {
//         currentChatId = newChatRef.id;
//         chatNames[currentChatId!] = chatName;
//       });
//     }
//
//     await firestore.collection("chats").doc(currentChatId).collection("messages").add({
//       "userId": chatMessage.user.id,
//       "text": chatMessage.text,
//       "createdAt": chatMessage.createdAt,
//       "medias": chatMessage.medias?.map((m) => m.toJson()).toList() ?? [],
//     });
//
//     _loadChats();
//   }
//
//   Future<void> _renameChat(String chatId) async {
//     TextEditingController _controller = TextEditingController(text: chatNames[chatId]);
//
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Rename Chat"),
//           content: TextField(
//             controller: _controller,
//             decoration: InputDecoration(labelText: "Enter new chat name"),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () async {
//                 String newName = _controller.text.trim();
//                 if (newName.isNotEmpty) {
//                   await firestore.collection("chats").doc(chatId).update({"name": newName});
//                   setState(() {
//                     chatNames[chatId] = newName;
//                   });
//                 }
//                 Navigator.pop(context);
//               },
//               child: Text("Rename"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Future<void> _confirmDeleteChat(String chatId) async {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Delete Chat"),
//           content: Text("Are you sure you want to delete this chat? This action cannot be undone."),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () async {
//                 Navigator.pop(context);
//                 await firestore.collection("chats").doc(chatId).delete();
//                 setState(() {
//                   chatNames.remove(chatId);
//                   if (currentChatId == chatId) {
//                     messages.clear();
//                     currentChatId = null;
//                   }
//                 });
//               },
//               child: Text("Delete", style: TextStyle(color: Colors.red)),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.blue.shade700, Colors.blue.shade900],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         title: Text("Gemini Chat", style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             DrawerHeader(
//               child: Center(child: Text("Chats", style: TextStyle(color: Colors.black, fontSize: 24))),
//             ),
//             ListTile(
//               leading: Icon(Icons.chat),
//               title: Text("New Chat"),
//               onTap: () {
//                 setState(() {
//                   messages.clear();
//                   currentChatId = null;
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//             Divider(),
//             ...chatNames.entries.map((entry) => ListTile(
//               title: Text(entry.value),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.edit, color: Colors.blue),
//                     onPressed: () => _renameChat(entry.key),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.delete, color: Colors.red),
//                     onPressed: () => _confirmDeleteChat(entry.key),
//                   ),
//                 ],
//               ),
//               onTap: () {
//                 _loadMessages(entry.key);
//                 Navigator.pop(context);
//               },
//             )),
//           ],
//         ),
//       ),
//       body: _buildUI(),
//     );
//   }
//
//   Widget _buildUI() {
//     return DashChat(
//       inputOptions: InputOptions(
//         trailing: [
//           IconButton(onPressed: _sendMediaMessage, icon: Icon(Icons.image)),
//         ],
//       ),
//       currentUser: currentUser,
//       onSend: _sendMessage,
//       messages: messages,
//     );
//   }
//
//   void _sendMessage(ChatMessage chatMessage) async {
//     setState(() {
//       messages = [chatMessage, ...messages];
//     });
//
//     _saveMessage(chatMessage);
//   }
//
//   void _sendMediaMessage() async {
//     ImagePicker picker = ImagePicker();
//     XFile? file = await picker.pickImage(source: ImageSource.gallery);
//
//     if (file == null) return;
//
//     ChatMessage chatMessage = ChatMessage(
//       user: currentUser,
//       createdAt: DateTime.now(),
//       text: "Describe this picture",
//       medias: [
//         ChatMedia(url: file.path, fileName: "", type: MediaType.image),
//       ],
//     );
//
//     _sendMessage(chatMessage);
//   }
// }


