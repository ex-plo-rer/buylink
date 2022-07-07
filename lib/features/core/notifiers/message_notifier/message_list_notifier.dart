import 'package:buy_link/repositories/core_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../services/base/network_exception.dart';
import '../../models/saved_session_model.dart';

class MessageListNotifier extends BaseChangeNotifier {
  final Reader _reader;

  // final String id;

  MessageListNotifier(
    this._reader,
    // {required this.id}
  );

  // {
  //   // getUnreadCount();
  //   // getChatList(
  //   //   sessionId: id,
  //   // );
  //   // getCurrentUser();
  //   // getMessages();
  // }

  final firestoreInstance = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  late User loggedInUser;
  String? messageText;

  String _chatId = '';

  String get chatId => _chatId;

  List<SavedSessionModel> _chats = [];

  List<SavedSessionModel> get chats => _chats;

  List<int> unreadM = [];

  // bool _fetchingList = false;
  // bool get fetchingList => _fetchingList;

/*  Future<void> getChatList({required dynamic id,}) async {
    print('Get chat list called with id $id');
    _fetchingList = true;
    await FirebaseFirestore.instance.collection('chats').get().then((value) {
      print('value Size: ${value.size}');
      for (var element in value.docs) {
        if (element.id.contains('31')) {
          //Do something with the messages collection.
        }
      }
    });
    print('Get chat list finished');
    _fetchingList = false;
    notifyListeners();
  }*/

  Future<int> getUnreadCount({
    required String ownerId,
    required String chatId,
    required DateTime lastMessageTime,
  }) async {
    int unreadMessages = 0;
    await firestoreInstance
        .collection('chats/$chatId/messages')
        .orderBy('timeStamp')
        .get()
        .then((value) {
      print('Last message time : $lastMessageTime');
      for (var element in value.docs) {
        // print('The data : ${element.data()}');
        Timestamp time = element.get('timeStamp');
        final senderId = element.get('senderId');
        print('Time before : ${time.toDate()}');
        print('Owner id : ${ownerId} Sender id : ${senderId}');
        if (ownerId != senderId && time.toDate().isAfter(lastMessageTime)) {
          print('Time after : ${time.toDate()}');
          unreadMessages += 1;
        }
      }
      print('Unread messages count: $unreadMessages');
    });
    return unreadMessages;
  }

  Future<void> getChatList({
    required String sessionId,
  }) async {
    try {
      setState(state: ViewState.loading);
      _chats = await _reader(coreRepository).getSessions(
        sessionId: sessionId,
        suffix: sessionId.substring(sessionId.length - 1),
      );
      if (_chats.isNotEmpty) {
        // for (var chat in _chats) {
        for (int i = 0; i < _chats.length; i++) {
          print('_chats[i].unreadCount 1 : ${_chats[i].unreadCount}');
          // print('_chats[i].unreadCount ${_chats[i].unreadCount}');
          print('{_chats[i].time}: ${_chats[i].time}');
          _chats[i].unreadCount = await getUnreadCount(
            ownerId: sessionId,
            chatId: _chats[i].chatId,
            lastMessageTime: _chats[i].time,
          );
          print('_chats[i].unreadCount 2 : ${_chats[i].unreadCount}');
          // unreadM.add(await getUnreadCount(
          //   chatId: _chats[i].chatId,
          //   lastMessageTime: DateTime(2022, 6, 13, 22, 08),
          // ));
        }
        // print('unreadM 2 : $unreadM');
      }
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify().error();
    } finally {
      // setState(state: ViewState.idle);
    }
  }
}

final messageListNotifierProvider = ChangeNotifierProvider<MessageListNotifier>(
    (ref) => MessageListNotifier(ref.read));
