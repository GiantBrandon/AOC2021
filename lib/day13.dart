import 'dart:io';
import 'dart:convert';
import 'dart:async';

class Point {
  int x;
  int y;
  Point(this.x, this.y);
  int get hashcode {
    return x * 10000 + y;
  }

  bool operator ==(other) => other is Point && x == other.x && y == other.y;
  int get hashCode => x * 10000 + y;
  @override
  String toString() => "{$x, $y}";
}

Set<Point> fold(Set<Point> original, String direction, int position) {
  if (direction == "x") {
    return original
        .map((e) =>
            e.x < position ? e : Point(position - (position - e.x).abs(), e.y))
        .toSet();
  } else {
    return original
        .map((e) =>
            e.y < position ? e : Point(e.x, position - (position - e.y).abs()))
        .toSet();
  }
}

day13_1() async {
  final file =
      File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day13.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    var coordinates = Set<Point>();
    bool lineBreak = false;
    await for (var line in lines) {
      if (line.trim().isEmpty) {
        lineBreak = true;
      } else if (lineBreak) {
        //skip for now
      } else {
        final input = line.split(",");
        coordinates.add(Point(int.parse(input[0]), int.parse(input[1])));
      }
    }
    print(coordinates.length);
    print(fold(coordinates, "x", 655).length);
  } catch (e) {
    print('Error: $e');
  }
}

day13_2() async {
  final file =
      File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day13.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    var coordinates = Set<Point>();
    bool lineBreak = false;
    await for (var line in lines) {
      if (line.trim().isEmpty) {
        lineBreak = true;
      } else if (lineBreak) {
        final input = line.split(" ");
        final instructions = input[2].split("=");
        coordinates =
            fold(coordinates, instructions[0], int.parse(instructions[1]));
        //skip for now
      } else {
        final input = line.split(",");
        coordinates.add(Point(int.parse(input[0]), int.parse(input[1])));
      }
    }
    for (int y = 0; y < 6; y++) {
      for (int x = 0; x < 40; x++) {
        stdout.write(coordinates.contains(Point(x, y)) ? "#" : ".");
      }
      print("");
    }
  } catch (e) {
    print('Error: $e');
  }
}
