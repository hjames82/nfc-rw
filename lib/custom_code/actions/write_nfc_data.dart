// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:ndef/ndef.dart' as ndef;

Future<String> writeNfcData(
  String? text,
) async {
  if (text == null || text.isEmpty) {
    String error = 'Error: No NFC data to write';
    FFAppState().error = error;
    print(error);
    return error;
  }

  bool isNfcAvailable = await NfcManager.instance.isAvailable();
  if (!isNfcAvailable) {
    String error = 'Error: NFC is not available or turned off on this device';
    FFAppState().error = error;
    print(error);
    return error;
  }

  Completer<String> completer = Completer<String>();

  NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
    var ndef = Ndef.from(tag);

    if (ndef != null && ndef.isWritable) {
      NdefRecord ndefRecord = NdefRecord.createText(text);
      NdefMessage message = NdefMessage([ndefRecord]);

      try {
        await ndef.write(message);
        FFAppState().success = 'Write Success';
        print('Write Success');
        completer.complete('Write Success');
      } catch (e) {
        FFAppState().error = 'Error during NFC write: ${e.toString()}';
        print('Error during NFC write: $e');
        completer.complete('Error during NFC write: ${e.toString()}');
      } finally {
        NfcManager.instance.stopSession();
      }
    } else {
      String errorMsg = ndef == null
          ? 'NDEF not supported on this tag'
          : 'Tag is not writable';
      FFAppState().error = errorMsg;
      print(errorMsg);
      NfcManager.instance.stopSession(errorMessage: errorMsg);
      completer.complete(errorMsg);
    }
  });

  return completer.future;
}
