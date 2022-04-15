import 'package:buy_link/core/utilities/view_state.dart';
import 'package:flutter/material.dart';

class BaseChangeNotifier extends ChangeNotifier {
  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  void setState({ViewState? state}) {
    if (state == null) {
      notifyListeners();
      return;
    } else {
      _state = state;
      notifyListeners();
    }
  }
}
