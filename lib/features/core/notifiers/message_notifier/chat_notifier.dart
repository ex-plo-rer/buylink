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

  Stream<QuerySnapshot<Object?>>? fetchAllMessages() {
    return firestoreInstance
        .collection('chats/{loggedInUser.uid}/messages')
        .orderBy('timeStamp')
        .snapshots();
  }

  //QrVcmRUPcV
  //0dQmu9zWtr

  void sendMessage({
    required String messageText,
    required bool isImage,
  }) {
    firestoreInstance.collection('chats/{loggedInUser.uid}/messages').add({
      'timeStamp': DateTime.now(),
      'text': messageText,
      'sender': _reader(userProvider).currentUser?.email ?? 'user@gmail.com',
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
