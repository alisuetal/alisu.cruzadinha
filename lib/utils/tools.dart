import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String getDate() {
  return "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";
}

String letterConversor(String letter) {
  switch (letter) {
    case "ã":
      return "a";
    case "á":
      return "a";
    case "â":
      return "a";
    case "é":
      return "e";
    case "ê":
      return "e";
    case "í":
      return "i";
    case "ó":
      return "o";

    case "ô":
      return "o";
    case "õ":
      return "o";
    case "ú":
      return "u";
    case "ç":
      return "c";
    default:
      return letter;
  }
}

String wordConversor(String word) {
  String localWord = "";
  for (var x = 0; x < word.length; x++) {
    localWord += letterConversor(word[x]);
  }
  return localWord;
}

List<String> wordsConversor(List<String> words) {
  List<String> localWords = [];
  for (var x = 0; x < words.length; x++) {
    localWords.add(wordConversor(words[x]));
  }
  return localWords;
}

void onInitColor(Color w, Color x, Brightness y, Brightness z) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: w,
      systemNavigationBarColor: x,
      statusBarIconBrightness: y,
      systemNavigationBarIconBrightness: z,
    ),
  );
}
