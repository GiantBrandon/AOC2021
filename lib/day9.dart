import 'dart:io';
import 'dart:convert';
import 'dart:async';

day9_1() async {
  final file =
      File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day9.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    int count = 0;
    List<List<int>> heights = [];
    await for (var line in lines) {
      List<int> currentLine =
          line.split("").map((element) => int.parse(element)).toList();
      heights.add(currentLine);
    }
    for (int x = 0; x < heights.length; x++) {
      for (int y = 0; y < heights[x].length; y++) {
        bool lessThanTop = true;
        bool lessThanBottom = true;
        bool lessThanLeft = true;
        bool lessThanRight = true;
        if (y - 1 >= 0) {
          lessThanTop = heights[x][y] < heights[x][y - 1];
        }
        if (y + 1 < heights[x].length) {
          lessThanBottom = heights[x][y] < heights[x][y + 1];
        }
        if (x - 1 >= 0) {
          lessThanLeft = heights[x][y] < heights[x - 1][y];
        }
        if (x + 1 < heights.length) {
          lessThanRight = heights[x][y] < heights[x + 1][y];
        }
        if (lessThanRight && lessThanLeft && lessThanBottom && lessThanTop) {
          count += heights[x][y] + 1;
        }
      }
    }
    print(count);
  } catch (e) {
    print('Error: $e');
  }
}

day9_2() async {
  final file =
      File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day9.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    List<int> counts = [0, 0, 0];
    List<List<int>> heights = [];
    await for (var line in lines) {
      List<int> currentLine =
          line.split("").map((element) => int.parse(element)).toList();
      heights.add(currentLine);
    }

    int getHeight(int x, int y) {
      if (x >= 0 && x < heights.length && y >= 0 && y < heights[x].length) {
        return heights[x][y];
      } else {
        return 9;
      }
    }

    int findBasin(List<String> coordinates) {
      List<String> basinCoordinates = [...coordinates];
      while (!coordinates.isEmpty) {
        String coordinate = coordinates.removeLast();
        int x = int.parse(coordinate.split(",")[0]);
        int y = int.parse(coordinate.split(",")[1]);
        if (getHeight(x, y - 1) > getHeight(x, y) && getHeight(x, y - 1) != 9) {
          if (!basinCoordinates.contains("$x,${y - 1}")) {
            coordinates.add("$x,${y - 1}");
            basinCoordinates.add("$x,${y - 1}");
          }
        }
        if (getHeight(x, y + 1) > getHeight(x, y) && getHeight(x, y + 1) != 9) {
          if (!basinCoordinates.contains("$x,${y + 1}")) {
            coordinates.add("$x,${y + 1}");
            basinCoordinates.add("$x,${y + 1}");
          }
        }
        if (getHeight(x - 1, y) > getHeight(x, y) && getHeight(x - 1, y) != 9) {
          if (!basinCoordinates.contains("${x - 1},$y")) {
            coordinates.add("${x - 1},$y");
            basinCoordinates.add("${x - 1},$y");
          }
        }
        if (getHeight(x + 1, y) > getHeight(x, y) && getHeight(x + 1, y) != 9) {
          if (!basinCoordinates.contains("${x + 1},$y")) {
            coordinates.add("${x + 1},$y");
            basinCoordinates.add("${x + 1},$y");
          }
        }
      }

      return basinCoordinates.length;
    }

    for (int x = 0; x < heights.length; x++) {
      for (int y = 0; y < heights[x].length; y++) {
        bool lessThanTop = getHeight(x, y) < getHeight(x, y - 1);
        bool lessThanBottom = getHeight(x, y) < getHeight(x, y + 1);
        bool lessThanLeft = getHeight(x, y) < getHeight(x - 1, y);
        bool lessThanRight = getHeight(x, y) < getHeight(x + 1, y);
        if (lessThanRight && lessThanLeft && lessThanBottom && lessThanTop) {
          int basinSize = findBasin(["$x,$y"]);
          if (basinSize > counts[0]) {
            counts[0] = basinSize;
            counts.sort();
          }
        }
      }
    }
    print(counts.reduce((value, element) => value * element));
  } catch (e) {
    print('Error: $e');
  }
}
