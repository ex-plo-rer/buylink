import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

String currency (context){
  Locale locale = Localizations.localeOf(context);

  var format = NumberFormat.simpleCurrency(locale: locale.toString());

  //var format = NumberFormat.simpleCurrency(locale: Platform.localeName, name: "NGN");
  return format.currencySymbol;
}