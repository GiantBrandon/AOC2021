import 'dart:io';
import 'dart:convert';
import 'dart:async';

day14_1() async {
  final file =
      File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day15.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    var input = "";
    bool lineBreak = false;
    Map<String, String> templates = Map();
    await for (var line in lines) {
      if (line.trim().isEmpty) {
        lineBreak = true;
      } else if (lineBreak) {
        final instructions = line.split(" -> ");
        templates[instructions[0]] = instructions[1];
      } else {
        input = line;
      }
    }
    for (int i = 0; i < 10; i++) {
      var lastChar = "";
      var newString = "";
      input.split("").forEach((element) {
        if (lastChar == "") {
          lastChar = element;
          newString += element;
        } else {
          newString += templates["$lastChar$element"]! + element;
          lastChar = element;
        }
      });
      input = newString;
    }
    Map<String, int> counts = Map();
    input.split("").forEach((element) {
      if (counts.containsKey(element)) {
        counts[element] = counts[element]! + 1;
      } else {
        counts[element] = 1;
      }
    });
    var min = 0;
    var max = 0;
    counts.forEach((key, value) {
      if (min == 0) {
        min = value;
        max = value;
      } else if (max < value) {
        max = value;
      } else if (min > value) {
        min = value;
      }
    });
    print(max - min);
  } catch (e) {
    print('Error: $e');
  }
}

day14_2() async {
  final file =
      File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day15.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    var pairs = Map<String, int>();
    bool lineBreak = false;
    Map<String, String> templates = Map();
    await for (var line in lines) {
      if (line.trim().isEmpty) {
        lineBreak = true;
      } else if (lineBreak) {
        final instructions = line.split(" -> ");
        templates[instructions[0]] = instructions[1];
      } else {
        var lastChar = "";
        line.split("").forEach((element) {
          if (lastChar == "") {
            lastChar = element;
          } else {
            final pair = "$lastChar$element";
            if (pairs.containsKey(pair)) {
              pairs[pair] = pairs[pair]! + 1;
            } else {
              pairs[pair] = 1;
            }
            lastChar = element;
          }
        });
      }
    }
    for (int i = 0; i < 40; i++) {
      var newPairs = Map<String, int>();
      pairs.forEach((key, count) {
        final newChar = templates[key];
        final characters = key.split("");
        ["${characters[0]}$newChar", "$newChar${characters[1]}"]
            .forEach((element) {
          if (newPairs.containsKey(element)) {
            newPairs[element] = newPairs[element]! + count;
          } else {
            newPairs[element] = count;
          }
        });
      });
      pairs = newPairs;
    }
    Map<String, int> counts = Map();
    pairs.forEach((key, value) {
      key.split("").forEach((character) {
        if (counts.containsKey(character)) {
          counts[character] = counts[character]! + value;
        } else {
          counts[character] = value;
        }
      });
    });

    var min = 0;
    var max = 0;
    counts.forEach((key, value) {
      if (min == 0) {
        min = value;
        max = value;
      } else if (max < value) {
        max = value;
      } else if (min > value) {
        min = value;
      }
    });
    print(max / 2 - min / 2);
  } catch (e) {
    print('Error: $e');
  }
}
