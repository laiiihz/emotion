library emotion;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/emotion_keyboard.dart';

export 'src/emotion_keyboard.dart';

class Emotion {
  static Future<void> hideKeyboard() async {
    await SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static Future<void> showKeyboard() async {
    await SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  static Future<String?> keyboard(BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      builder: (context) {
        return EmotionKeyboard(
          onSelect: (emoji) {
            Navigator.pop(context, emoji);
          },
        );
      },
    );
  }
}
