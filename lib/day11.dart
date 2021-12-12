import 'dart:io';
import 'dart:convert';
import 'dart:async';

class Octopus {
  int energy;
  bool isFlashing;
  Octopus(this.energy, this.isFlashing);
}

day11_1() async {
  final file =
      File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day11.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    int count = 0;
    List<List<Octopus>> octopodes = [];
    await for (var line in lines) {
      List<Octopus> currentLine = line
          .split("")
          .map((element) => Octopus(int.parse(element), false))
          .toList();
      octopodes.add(currentLine);
    }

    void increase(int x, int y) {
      if (x < 0 || x >= octopodes.length || y < 0 || y >= octopodes[x].length) {
        return;
      }
      if (!octopodes[x][y].isFlashing) {
        octopodes[x][y].energy++;
        if (octopodes[x][y].energy > 9) {
          octopodes[x][y].isFlashing = true;
          count++;
          for (int x1 = -1; x1 <= 1; x1++) {
            for (int y1 = -1; y1 <= 1; y1++) {
              increase(x + x1, y + y1);
            }
          }
        }
      }
    }

    for (int cycle = 0; cycle < 100; cycle++) {
      for (int x = 0; x < octopodes.length; x++) {
        for (int y = 0; y < octopodes[x].length; y++) {
          increase(x, y);
        }
      }
      for (int x = 0; x < octopodes.length; x++) {
        for (int y = 0; y < octopodes[x].length; y++) {
          if (octopodes[x][y].isFlashing) {
            octopodes[x][y].energy = 0;
          }
          octopodes[x][y].isFlashing = false;
        }
      }
    }

    print(count);
  } catch (e) {
    print('Error: $e');
  }
}

day11_2() async {
  final file =
      File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day11.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    List<List<Octopus>> octopodes = [];
    await for (var line in lines) {
      List<Octopus> currentLine = line
          .split("")
          .map((element) => Octopus(int.parse(element), false))
          .toList();
      octopodes.add(currentLine);
    }

    void increase(int x, int y) {
      if (x < 0 || x >= octopodes.length || y < 0 || y >= octopodes[x].length) {
        return;
      }
      if (!octopodes[x][y].isFlashing) {
        octopodes[x][y].energy++;
        if (octopodes[x][y].energy > 9) {
          octopodes[x][y].isFlashing = true;
          for (int x1 = -1; x1 <= 1; x1++) {
            for (int y1 = -1; y1 <= 1; y1++) {
              increase(x + x1, y + y1);
            }
          }
        }
      }
    }

    for (int cycle = 0;; cycle++) {
      for (int x = 0; x < octopodes.length; x++) {
        for (int y = 0; y < octopodes[x].length; y++) {
          increase(x, y);
        }
      }
      if (octopodes
          .every((element) => element.every((element) => element.isFlashing))) {
        return;
      }
      for (int x = 0; x < octopodes.length; x++) {
        for (int y = 0; y < octopodes[x].length; y++) {
          if (octopodes[x][y].isFlashing) {
            octopodes[x][y].energy = 0;
          }
          octopodes[x][y].isFlashing = false;
        }
      }
    }
  } catch (e) {
    print('Error: $e');
  }
}
