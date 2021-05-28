import 'package:cloud_firestore/cloud_firestore.dart';

class TextSnippet {
  final String text;
  final String? style;

  TextSnippet({required this.text, this.style});

  factory TextSnippet.fromJson(Map<String, dynamic> json) {
    return TextSnippet(text: json["text"], style: json["style"]);
  }
}

class Paragraph {
  final List<TextSnippet> textSnippets;

  Paragraph({required this.textSnippets});

  factory Paragraph.fromJson(List<dynamic> json) {
    List<TextSnippet> textSnippets = [];

    for (var textSnippet in json) {
      textSnippets.add(TextSnippet.fromJson(textSnippet));
    }

    return Paragraph(textSnippets: textSnippets);
  }
}

class Chapter {
  final int number;
  final String name;

  final DocumentReference? reference;
  final List<Paragraph>? contents;

  Chapter({required this.number, required this.name, this.reference, this.contents});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    List<Paragraph> contents = [];

    if (json.containsKey("contents")) {
      for (var paragraph in json["contents"]) {
        var textSnippets = paragraph["contents"] as List<dynamic>;
        contents.add(Paragraph.fromJson(textSnippets));
      }
    }

    return Chapter(number: json["number"], name: json["name"], contents: contents);
  }
}
