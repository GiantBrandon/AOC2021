import 'dart:io';
import 'dart:convert';
import 'dart:async';

class Board {
  List<int> numbers = [];
  List<bool> checks = List.filled(25, false);
  bool hasBingo = false;
  Board(this.numbers);

  void mark(int number) {
    if (hasBingo) return;
    numbers.asMap().forEach((index, value) {
      if (value == number) {
        checks[index] = true;
      }
    });
    check();
  }

  void check() {
    for (int x = 0; x < 5; x++) {
      if (checks[0 + (x * 5)] &&
          checks[1 + (x * 5)] &&
          checks[2 + (x * 5)] &&
          checks[3 + (x * 5)] &&
          checks[4 + (x * 5)]) {
        hasBingo = true;
      } else if (checks[0 + x] &&
          checks[5 + x] &&
          checks[10 + x] &&
          checks[15 + x] &&
          checks[20 + x]) {
        hasBingo = true;
      }
    }
    if (checks[0] && checks[6] && checks[12] && checks[18] && checks[24]) {
      hasBingo = true;
    } else if (checks[4] &&
        checks[8] &&
        checks[12] &&
        checks[16] &&
        checks[20]) {
      hasBingo = true;
    }
  }

  int unmarkedTotal() {
    int total = 0;
    checks.asMap().forEach((key, value) {
      total += value ? 0 : numbers[key];
    });
    return total;
  }
}

day4_1() async {
  final file =
      File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day4.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  List<String> readLines = [];
  try {
    await for (var line in lines) {
      readLines.add(line.trim());
    }
  } catch (e) {
    print('Error: $e');
  }
  List<Board> boards = [];
  final numbers = readLines.first.split(",").map((e) => int.parse(e));
  readLines.removeAt(0);
  while (readLines.length > 0) {
    boards.add(Board(
      readLines[1]
              .split(" ")
              .where((num) => num.length > 0)
              .map((e) => int.parse(e.trim()))
              .toList() +
          readLines[2]
              .split(" ")
              .where((num) => num.length > 0)
              .map((e) => int.parse(e.trim()))
              .toList() +
          readLines[3]
              .split(" ")
              .where((num) => num.length > 0)
              .map((e) => int.parse(e.trim()))
              .toList() +
          readLines[4]
              .split(" ")
              .where((num) => num.length > 0)
              .map((e) => int.parse(e.trim()))
              .toList() +
          readLines[5]
              .split(" ")
              .where((num) => num.length > 0)
              .map((e) => int.parse(e.trim()))
              .toList(),
    ));
    readLines.removeRange(0, 6);
  }
  for (int number in numbers) {
    for (Board board in boards) {
      board.mark(number);
      if (board.hasBingo) {
        print(board.unmarkedTotal() * number);
        return;
      }
    }
  }
}

day4_2() async {
  final file =
      File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day4.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  List<String> readLines = [];
  try {
    await for (var line in lines) {
      readLines.add(line.trim());
    }
  } catch (e) {
    print('Error: $e');
  }
  List<Board> boards = [];
  final numbers = readLines.first.split(",").map((e) => int.parse(e));
  readLines.removeAt(0);
  while (readLines.length > 0) {
    boards.add(Board(
      readLines[1]
              .split(" ")
              .where((num) => num.length > 0)
              .map((e) => int.parse(e.trim()))
              .toList() +
          readLines[2]
              .split(" ")
              .where((num) => num.length > 0)
              .map((e) => int.parse(e.trim()))
              .toList() +
          readLines[3]
              .split(" ")
              .where((num) => num.length > 0)
              .map((e) => int.parse(e.trim()))
              .toList() +
          readLines[4]
              .split(" ")
              .where((num) => num.length > 0)
              .map((e) => int.parse(e.trim()))
              .toList() +
          readLines[5]
              .split(" ")
              .where((num) => num.length > 0)
              .map((e) => int.parse(e.trim()))
              .toList(),
    ));
    readLines.removeRange(0, 6);
  }
  for (int number in numbers) {
    for (Board board in boards) {
      board.mark(number);
      if (board.hasBingo) {
        if (boards.length == 1) print(board.unmarkedTotal() * number);
      }
    }
    boards.removeWhere((element) => element.hasBingo);
  }
}
