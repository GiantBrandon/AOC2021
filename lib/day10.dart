import 'dart:io';
import 'dart:convert';
import 'dart:async';

day10_1() async {
  final file =
      File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day10.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    int count = 0;
    await for (var line in lines) {
      List<String> stack = [];
      List<String> characters = line.split("");
      bool found = false;
      while (!found && !characters.isEmpty) {
        final character = characters.removeAt(0);
        switch (character) {
          case "(":
          case "[":
          case "{":
          case "<":
            {
              stack.add(character);
              break;
            }
          case ")":
            {
              if (stack.isEmpty || stack.removeLast() != "(") {
                count += 3;
                found = true;
              }
              break;
            }
          case "]":
            {
              if (stack.isEmpty || stack.removeLast() != "[") {
                count += 57;
                found = true;
              }
              break;
            }
          case "}":
            {
              if (stack.isEmpty || stack.removeLast() != "{") {
                count += 1197;
                found = true;
              }
              break;
            }
          case ">":
            {
              if (stack.isEmpty || stack.removeLast() != "<") {
                count += 25137;
                found = true;
              }
              break;
            }
        }
      }
    }
    print(count);
  } catch (e) {
    print('Error: $e');
  }
}

day10_2() async {
  final file =
      File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day10.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    List<int> counts = [];
    await for (var line in lines) {
      List<String> stack = [];
      List<String> characters = line.split("");
      bool found = false;
      while (!found && !characters.isEmpty) {
        final character = characters.removeAt(0);
        switch (character) {
          case "(":
          case "[":
          case "{":
          case "<":
            {
              stack.add(character);
              break;
            }
          case ")":
            {
              if (stack.isEmpty || stack.removeLast() != "(") {
                found = true;
              }
              break;
            }
          case "]":
            {
              if (stack.isEmpty || stack.removeLast() != "[") {
                found = true;
              }
              break;
            }
          case "}":
            {
              if (stack.isEmpty || stack.removeLast() != "{") {
                found = true;
              }
              break;
            }
          case ">":
            {
              if (stack.isEmpty || stack.removeLast() != "<") {
                found = true;
              }
              break;
            }
        }
      }
      if (!found) {
        int localCount = 0;
        while (!stack.isEmpty) {
          String character = stack.removeLast();
          switch (character) {
            case "(":
              {
                localCount = localCount * 5 + 1;
                break;
              }
            case "[":
              {
                localCount = localCount * 5 + 2;
                break;
              }
            case "{":
              {
                localCount = localCount * 5 + 3;
                break;
              }
            case "<":
              {
                localCount = localCount * 5 + 4;
                break;
              }
          }
        }
        counts.add(localCount);
      }
    }
    counts.sort();
    print(counts[(counts.length / 2).toInt()]);
  } catch (e) {
    print('Error: $e');
  }
}
