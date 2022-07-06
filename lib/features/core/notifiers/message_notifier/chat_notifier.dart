import 'dart:io';

import 'package:buy_link/features/core/notifiers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../repositories/core_repository.dart';
import '../../../../services/base/network_exception.dart';

class ChatNotifier extends BaseChangeNotifier {
  final Reader _reader;

  ChatNotifier(this._reader);

  final firestoreInstance = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  late User loggedInUser;
  String? messageText;

  String chatId = '';

  String? _lastMessage;

  String? get lastMessage => _lastMessage;

  DateTime? _lastMessageTime;
  DateTime? _newMessageTime;

  DateTime? get lastMessageTime => _lastMessageTime;

  UploadTask? uploadTask;

  String? _imageUrl;

  String? get imageUrl => _imageUrl;

  bool _canSaveSession = false;

  bool get canSaveSession => _canSaveSession;

  Future<void> uploadFile(PlatformFile pickedFile) async {
    final path = 'images/${pickedFile.name}';
    final file = File(pickedFile.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});

    _imageUrl = await snapshot.ref.getDownloadURL();
    print('Download url: $imageUrl');
    notifyListeners();
  }

  void resetImage() {
    _imageUrl = null;
    notifyListeners();
  }

  void generateId({
    required var senderId,
    required var receiverId,
  }) {
    // var myId = _reader(userProvider).currentUser?.id;
    print('senderId: $senderId, receiverId: $receiverId');
    senderId.hashCode;
    print('myId.hashCode : ${senderId.hashCode}');
    if (senderId.hashCode <= receiverId.hashCode) {
      chatId = '$senderId-$receiverId';
    } else {
      chatId = '$receiverId-$senderId';
    }
  }

  Stream<QuerySnapshot<Object?>>? fetchAllMessages(
      {required var senderId, required var receiverId}) {
    generateId(senderId: senderId, receiverId: receiverId);
    firestoreInstance
        .collection('chats/$chatId/messages')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot documentSnapshot in snapshot.docs) {
        if (documentSnapshot.get('text') == 'Hello') {}
      }
    });

    return firestoreInstance
        .collection('chats/$chatId/messages')
        .orderBy('timeStamp')
        // .where('text' == 'hello')
        .snapshots();
  }

  Future<void> deleteConversation() async {
    print('Chat id $chatId');
    await firestoreInstance
        .collection('chats/$chatId/messages')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot documentSnapshot in snapshot.docs) {
        documentSnapshot.reference.delete();
      }
    });
  }

  void sendMessage({
    required String messageText,
    required String senderName,
    required var senderId,
    // required String? senderImage,
    required bool isImage,
    required var receiverId,
  }) {
    generateId(senderId: senderId, receiverId: receiverId);
    firestoreInstance.collection('chats/$chatId/messages').add({
      'timeStamp': DateTime.now(),
      'text': messageText,
      'senderName': senderName,
      'senderId': senderId,
      // 'senderImage': senderImage,
      'isImage': isImage,
    });
  }

  void getCurrentUser() {
    _reader(userProvider).currentUser;
    try {
      final user = firebaseAuth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(user.email);
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void getMessages() async {
    final messages = await firestoreInstance.collection('messages').get();
    for (var message in messages.docs) {
      print(message.get('field'));
    }
  }

  void messagesStream() async {
    // firestoreInstance.collection('messages').snapshots();
    await for (var snapshot
        in firestoreInstance.collection('chats/$chatId/messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  void saveLastMessage({
    required String message,
    required DateTime messageTime,
  }) {
    print('Message time: $messageTime');
    _lastMessage = message;
    if (_lastMessageTime == null) {
      _lastMessageTime = messageTime;
      _canSaveSession = true;
    } else {
      _newMessageTime = messageTime;
      _canSaveSession = _lastMessageTime!.isBefore(_newMessageTime!);
      _lastMessageTime = _newMessageTime;
    }
    print('Can save session: $_canSaveSession');
    print('Last message: $_lastMessage');
    print('Last message time: $_lastMessageTime');
    notifyListeners();
  }

  Future<void> saveSession({
    required String chatId,
    required String message,
    required String actor,
  }) async {
    try {
      setState(state: ViewState.loading);
      await _reader(coreRepository).saveSession(
        chatId: chatId,
        message: message,
        actor: actor,
      );
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify().error();
    } finally {
      // setState(state: ViewState.idle);
    }
  }
}

final chatNotifierProvider =
    ChangeNotifierProvider<ChatNotifier>((ref) => ChatNotifier(ref.read));
