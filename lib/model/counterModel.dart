import 'package:flutter/cupertino.dart';
import 'package:multilocationGroceryApp/service/common.dart';
import 'package:multilocationGroceryApp/service/sentry-service.dart';

SentryError sentryError = new SentryError();

class CounterModel with ChangeNotifier {
  Map cartData;
  getCartDataMethod() async {
    await Common.getCartData().then((onValue) {
      if (onValue != null) {
        cartData = onValue;
      } else {
        cartData = null;
      }
    });
    return cartData;
  }

  void getCatData() {
    getCartDataMethod();
    notifyListeners();
  }
}
