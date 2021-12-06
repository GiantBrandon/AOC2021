import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'dart:math';

day5_1() async {
  final file =
      File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day5.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    Map<String, int> counts = Map();
    await for (var line in lines) {
      List<List<int>> coordinates = line
          .trim()
          .split(" -> ")
          .map((e) => e.split(",").map((e) => int.parse(e)).toList())
          .toList();
      int x1 = coordinates[0][0];
      int y1 = coordinates[0][1];
      int x2 = coordinates[1][0];
      int y2 = coordinates[1][1];
      if (x1 == x2 || y1 == y2) {
        for (int x = min(x1, x2); x <= max(x1, x2); x++) {
          for (int y = min(y1, y2); y <= max(y1, y2); y++) {
            if (counts.containsKey("$x,$y")) {
              counts["$x,$y"] = counts["$x,$y"]! + 1;
            } else {
              counts["$x,$y"] = 1;
            }
          }
        }
      }
    }
    var count = 0;
    counts.forEach((key, value) {
      if (value >= 2) count++;
    });
    print(count);
  } catch (e) {
    print('Error: $e');
  }
}

day5_2() async {
  final file =
      File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day5.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    Map<String, int> counts = Map();
    await for (var line in lines) {
      List<List<int>> coordinates = line
          .trim()
          .split(" -> ")
          .map((e) => e.split(",").map((e) => int.parse(e)).toList())
          .toList();
      int x1 = coordinates[0][0];
      int y1 = coordinates[0][1];
      int x2 = coordinates[1][0];
      int y2 = coordinates[1][1];
      if (x1 == x2 || y1 == y2) {
        for (int x = min(x1, x2); x <= max(x1, x2); x++) {
          for (int y = min(y1, y2); y <= max(y1, y2); y++) {
            if (counts.containsKey("$x,$y")) {
              counts["$x,$y"] = counts["$x,$y"]! + 1;
            } else {
              counts["$x,$y"] = 1;
            }
          }
        }
      } else if ((x1 - x2).abs() == (y1 - y2).abs()) {
        for (int i = 0; i <= (x1 - x2).abs(); i++) {
          int x = x2 > x1 ? x1 + i : x1 - i;
          int y = y2 > y1 ? y1 + i : y1 - i;
          if (counts.containsKey("$x,$y")) {
            counts["$x,$y"] = counts["$x,$y"]! + 1;
          } else {
            counts["$x,$y"] = 1;
          }
        }
      }
    }
    var count = 0;
    counts.forEach((key, value) {
      if (value >= 2) count++;
    });
    print(count);
  } catch (e) {
    print('Error: $e');
  }
}
