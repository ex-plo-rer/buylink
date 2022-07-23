import 'package:buy_link/repositories/core_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../services/base/network_exception.dart';
import '../../../../services/navigation_service.dart';
import '../../models/saved_session_model.dart';

class MessageListNotifier extends BaseChangeNotifier {
  final Reader _reader;

  MessageListNotifier(this._reader);

  final firestoreInstance = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  late User loggedInUser;
  String? messageText;

  final String _chatId = '';

  String get chatId => _chatId;

  List<SavedSessionModel> _chats = [];

  List<SavedSessionModel> get chats => _chats;

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
      for (var element in value.docs) {
        Timestamp time = element.get('timeStamp');
        final senderId = element.get('senderId');
        if (ownerId != senderId && time.toDate().isAfter(lastMessageTime)) {
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
        for (int i = 0; i < _chats.length; i++) {
          _chats[i].unreadCount = await getUnreadCount(
            ownerId: sessionId,
            chatId: _chats[i].chatId,
            lastMessageTime: _chats[i].time,
          );
          print('_chats[i].unreadCount 2 : ${_chats[i].unreadCount}');
        }
      }
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify().error();
      _reader(navigationServiceProvider).navigateBack();
    } finally {
      // setState(state: ViewState.idle);
    }
  }

  void dump() {
    _chats.clear();
    setState(state: ViewState.idle);
    notifyListeners();
  }
}

final messageListNotifierProvider = ChangeNotifierProvider<MessageListNotifier>(
    (ref) => MessageListNotifier(ref.read));
