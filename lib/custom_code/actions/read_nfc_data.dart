// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

import 'package:nfc_manager/nfc_manager.dart';

Future<String> readNfcData() async {
  Completer<String> completer = Completer<String>();
  ValueNotifier<Map<String, dynamic>?> tagData = ValueNotifier(null);

  NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
    tagData.value = tag.data;
    var data = tag.data;

    var nfca = data['nfca'] ?? {};
    var isodep = data['isodep'] ?? {};

    FFAppState().id = formatHex(nfca['identifier']);

    FFAppState().atqa = formatHex(nfca['atqa']);
    FFAppState().sak = nfca['sak']?.toString() ?? 'Unknown';
    FFAppState().historicalBytes = formatHex(isodep['historicalBytes']);

    NfcManager.instance.stopSession();
    completer.complete(tagData.value.toString());
  });

  return completer.future;
}

String formatHex(List<dynamic>? bytes) {
  if (bytes == null) return 'Unknown';
  return bytes
      .map((byte) => byte.toRadixString(16).padLeft(2, '0').toUpperCase())
      .join('');
}
