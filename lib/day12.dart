import 'dart:io';
import 'dart:convert';
import 'dart:async';

class Octopus {
  int energy;
  bool isFlashing;
  Octopus(this.energy, this.isFlashing);
}

String Uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
bool isUppercase(String str) {
  return str.split("").every((element) => Uppercase.contains(element));
}

day12_1() async {
  final file =
      File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day12.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    Map<String, List<String>> paths = {};
    await for (var line in lines) {
      List<String> pair = line.split("-");
      if (paths.containsKey(pair[0])) {
        paths[pair[0]]?.add(pair[1]);
      } else {
        paths[pair[0]] = [pair[1]];
      }
      if (paths.containsKey(pair[1])) {
        paths[pair[1]]?.add(pair[0]);
      } else {
        paths[pair[1]] = [pair[0]];
      }
    }
    print(paths);

    List<List<String>> findPaths(List<String> pathSoFar) {
      if (pathSoFar.last == "end") {
        return [pathSoFar];
      } else if (!paths.containsKey(pathSoFar.last)) {
        return [];
      }
      List<String> endpoints = paths[pathSoFar.last]!
          .where((endpoint) =>
              isUppercase(endpoint) || !pathSoFar.contains(endpoint))
          .toList();
      List<List<String>> newPaths = [];
      endpoints.forEach((element) {
        newPaths.addAll(findPaths([...pathSoFar, element]));
      });
      return newPaths;
    }

    final allPaths = findPaths(["start"]);
    print(allPaths.length);
  } catch (e) {
    print('Error: $e');
  }
}

int duplicates(List<String> path) {
  int count = 0;
  for (int i = 0; i < path.length; i++) {
    if (!isUppercase(path[i])) {
      for (int j = i + 1; j < path.length; j++) {
        if (path[i] == path[j]) {
          count++;
        }
      }
    }
  }
  return count;
}

day12_2() async {
  final file =
      File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day12.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    Map<String, List<String>> paths = {};
    await for (var line in lines) {
      List<String> pair = line.split("-");
      if (paths.containsKey(pair[0])) {
        paths[pair[0]]?.add(pair[1]);
      } else {
        paths[pair[0]] = [pair[1]];
      }
      if (paths.containsKey(pair[1])) {
        paths[pair[1]]?.add(pair[0]);
      } else {
        paths[pair[1]] = [pair[0]];
      }
    }
    print(paths);

    List<List<String>> findPaths(List<String> pathSoFar) {
      if (!paths.containsKey(pathSoFar.last) || duplicates(pathSoFar) > 1) {
        return [];
      } else if (pathSoFar.last == "end") {
        return [pathSoFar];
      }
      List<String> endpoints = paths[pathSoFar.last]!
          .where((endpoint) => endpoint != "start")
          .toList();
      List<List<String>> newPaths = [];
      endpoints.forEach((element) {
        newPaths.addAll(findPaths([...pathSoFar, element]));
      });
      return newPaths;
    }

    final allPaths = findPaths(["start"]);
    print(allPaths.length);
  } catch (e) {
    print('Error: $e');
  }
}
