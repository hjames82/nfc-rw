import 'package:flutter/material.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _error = '';
  String get error => _error;
  set error(String value) {
    _error = value;
  }

  String _success = '';
  String get success => _success;
  set success(String value) {
    _success = value;
  }

  String _notsupported = '';
  String get notsupported => _notsupported;
  set notsupported(String value) {
    _notsupported = value;
  }

  String _empty = '';
  String get empty => _empty;
  set empty(String value) {
    _empty = value;
  }

  String _historicalBytes = '';
  String get historicalBytes => _historicalBytes;
  set historicalBytes(String value) {
    _historicalBytes = value;
  }

  String _sak = '';
  String get sak => _sak;
  set sak(String value) {
    _sak = value;
  }

  String _atqa = '';
  String get atqa => _atqa;
  set atqa(String value) {
    _atqa = value;
  }

  String _id = '';
  String get id => _id;
  set id(String value) {
    _id = value;
  }
}
