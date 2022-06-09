import 'package:buy_link/features/core/notifiers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routes.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../services/local_storage_service.dart';
import '../../../../services/navigation_service.dart';

class ChatNotifier extends BaseChangeNotifier {
  final Reader _reader;

  ChatNotifier(this._reader) {
    getCurrentUser();
    getMessages();
  }

  final firestoreInstance = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  late User loggedInUser;
  String? messageText;

  String chatId = '';

  Stream<QuerySnapshot<Object?>>? fetchAllMessages(
      {required var senderId, required var receiverId}) {
    generateId(senderId: senderId, receiverId: receiverId);
    return firestoreInstance
        .collection('chats/$chatId/messages')
        .orderBy('timeStamp')
        .snapshots();
  }

  //QrVcmRUPcV
  //0dQmu9zWtr

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

  void sendMessage({
    required String messageText,
    required String senderName,
    required var senderId,
    required String? senderImage,
    required bool isImage,
    required var receiverId,
  }) {
    generateId(senderId: senderId, receiverId: receiverId);
    firestoreInstance.collection('chats/$chatId/messages').add({
      'timeStamp': DateTime.now(),
      'text': messageText,
      'senderName': senderName,
      'senderId': senderId,
      'senderImage': senderImage,
      'isImage': isImage,
    });
  }

  // void signOut() {
  //   firebaseAuth.signOut();
  //   _reader(navigationServiceProvider).navigateToNamed(Routes.welcomeView);
  //   // _reader(localStorageService).emptyPreference();
  // }

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
      print(message.data());
    }
  }

  void messagesStream() async {
    // firestoreInstance.collection('messages').snapshots();
    await for (var snapshot
        in firestoreInstance.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }
}

final chatNotifierProvider =
    ChangeNotifierProvider<ChatNotifier>((ref) => ChatNotifier(ref.read));
