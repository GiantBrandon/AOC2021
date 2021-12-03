import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

day3_1() async {
  final file =
      File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day3.txt');
  var counts = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    await for (var line in lines) {
      for (var i = 0; i < line.length; i++) {
        counts[i] += int.parse(line[i]);
      }
    }
    final gamma = counts.map((count) => (count < 500) ? 1 : 0).join();
    final epsilon = counts.map((count) => (count < 500) ? 0 : 1).join();
    print(int.parse(gamma, radix: 2) * int.parse(epsilon, radix: 2));
  } catch (e) {
    print('Error: $e');
  }
}

day3_2() async {
  final file =
      File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day3.txt');
  List oxygenEntries = [];
  List co2Entries = [];
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    await for (var line in lines) {
      oxygenEntries.add(line);
      co2Entries.add(line);
    }
    for (int i = 0; i < 12 && oxygenEntries.length > 1; i++) {
      var count = 0;
      oxygenEntries.forEach((element) {
        count += int.parse(element[i]);
      });
      if (count >= oxygenEntries.length / 2) {
        oxygenEntries.removeWhere((element) => element[i] == "0");
      } else {
        oxygenEntries.removeWhere((element) => element[i] == "1");
      }
    }
    for (int i = 0; i < 12 && co2Entries.length > 1; i++) {
      var count = 0;
      co2Entries.forEach((element) {
        count += int.parse(element[i]);
      });
      print(count);
      print(i);
      if (count >= co2Entries.length / 2) {
        print("remove 1");
        co2Entries.removeWhere((element) => element[i] == "1");
      } else {
        print("remove 0");
        co2Entries.removeWhere((element) => element[i] == "0");
      }
      print(co2Entries);
    }
    print("oxygen");
    print(oxygenEntries);
    print("co2");
    print(co2Entries);
    print(int.parse(oxygenEntries[0], radix: 2) *
        int.parse(co2Entries[0], radix: 2));
  } catch (e) {
    print('Error: $e');
  }
}
