import 'dart:io';
import 'dart:convert';
import 'dart:async';

day2_1() async {
  final file =
      File('C:\\Users\\brand\\Documents\\code\\aoc2021_1\\lib\\day2.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    var x = 0;
    var y = 0;
    await for (var line in lines) {
      final instruction = line.split(" ");
      switch (instruction[0]) {
        case "forward":
          x += int.parse(instruction[1]);
          break;
        case "down":
          y += int.parse(instruction[1]);
          break;
        case "up":
          y -= int.parse(instruction[1]);
          break;
      }
    }
    print(x * y);
  } catch (e) {
    print('Error: $e');
  }
}

day2_2() async {
  final file =
      File('C:\\Users\\brand\\Documents\\code\\aoc2021_1\\lib\\day2.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    var x = 0;
    var y = 0;
    var aim = 0;
    await for (var line in lines) {
      final instruction = line.split(" ");
      switch (instruction[0]) {
        case "forward":
          x += int.parse(instruction[1]);
          y += int.parse(instruction[1]) * aim;
          break;
        case "down":
          aim += int.parse(instruction[1]);
          break;
        case "up":
          aim -= int.parse(instruction[1]);
          break;
      }
    }
    print(x * y);
  } catch (e) {
    print('Error: $e');
  }
}
