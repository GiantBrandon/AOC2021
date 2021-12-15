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

day15_1() async {
  final file =
      File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day15.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    List<List<int>> risks = [];
    await for (var line in lines) {
      risks.add(line.split("").map((e) => int.parse(e)).toList());
    }

    Set<Point> visited = {};
    Set<Point> candidates = {};

    List<Point> getNeighbors(Point point) {
      return [
        Point(point.x + 1, point.y),
        Point(point.x - 1, point.y),
        Point(point.x, point.y + 1),
        Point(point.x, point.y - 1)
      ]
          .where((element) =>
              element.x >= 0 &&
              element.x < risks.length &&
              element.y >= 0 &&
              element.y < risks[0].length)
          .where((element) => !visited.contains(element))
          .toList();
    }

    void addVisitor(Point point) {
      visited.add(point);
      candidates.remove(point);
      final neighbors = getNeighbors(point);
      neighbors.forEach((element) {
        if (!candidates.contains(element)) {
          risks[element.x][element.y] =
              risks[point.x][point.y] + risks[element.x][element.y];
        }
      });
      candidates.addAll(neighbors);
    }

    addVisitor(Point(risks.length - 1, risks.length - 1));

    while (!visited.contains(Point(0, 0))) {
      int min = risks[candidates.first.x][candidates.first.y];
      Point minPoint = candidates.first;
      candidates.forEach((element) {
        if (risks[element.x][element.y] < min) {
          min = risks[element.x][element.y];
          minPoint = element;
        }
      });
      addVisitor(minPoint);
    }
    print(risks[0][0]);
  } catch (e) {
    print('Error: $e');
  }
}

day15_2() async {
  final file =
      File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day15.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    List<List<int>> input = [];
    await for (var line in lines) {
      input.add(line.split("").map((e) => int.parse(e)).toList());
    }
    List<List<int>> risks = [];
    for (int y = 0; y < 5; y++) {
      final rowBase = [
        ...input.map(
            (e) => [...e].map((e) => e + y > 9 ? e + y - 9 : e + y).toList())
      ];
      for (int x = 0; x < 5; x++) {
        for (int row = 0; row < input.length; row++) {
          if (y * input.length + row >= risks.length) {
            risks.add([]);
          }
          risks[y * input.length + row].addAll([...rowBase[row]]
              .map((e) => e + x > 9 ? e + x - 9 : e + x)
              .toList());
        }
      }
    }

    Set<Point> visited = {};
    Set<Point> candidates = {};

    List<Point> getNeighbors(Point point) {
      return [
        Point(point.x + 1, point.y),
        Point(point.x - 1, point.y),
        Point(point.x, point.y + 1),
        Point(point.x, point.y - 1)
      ]
          .where((element) =>
              element.x >= 0 &&
              element.x < risks.length &&
              element.y >= 0 &&
              element.y < risks[0].length)
          .where((element) => !visited.contains(element))
          .toList();
    }

    void addVisitor(Point point) {
      visited.add(point);
      candidates.remove(point);
      final neighbors = getNeighbors(point);
      neighbors.forEach((element) {
        if (!candidates.contains(element)) {
          risks[element.x][element.y] =
              risks[point.x][point.y] + risks[element.x][element.y];
        }
      });
      candidates.addAll(neighbors);
    }

    addVisitor(Point(risks.length - 1, risks.length - 1));

    while (!visited.contains(Point(0, 0))) {
      int min = risks[candidates.first.x][candidates.first.y];
      Point minPoint = candidates.first;
      candidates.forEach((element) {
        if (risks[element.x][element.y] < min) {
          min = risks[element.x][element.y];
          minPoint = element;
        }
      });
      addVisitor(minPoint);
    }
    print(risks[0][0]);
  } catch (e) {
    print('Error: $e');
  }
}
