import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'dart:math';

day8_1() async {
  final file =
      File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day8.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    int count = 0;
    await for (var line in lines) {
      final output = line.split(" | ")[1];
      count += output
          .split(" ")
          .where((element) =>
              element.length == 2 ||
              element.length == 3 ||
              element.length == 4 ||
              element.length == 7)
          .length;
    }
    print(count);
    print("test".split(""));
  } catch (e) {
    print('Error: $e');
  }
}

day8_2() async {
  final file =
      File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day8.txt');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    int count = 0;
    await for (var line in lines) {
      final input = line.split(" | ");
      List<String> mapping = findMapping(input[0].split(" "));
      int output = int.parse(input[1]
          .split(" ")
          .map((inputNumber) => mapping.indexOf(sortString(inputNumber)))
          .join(""));
      count += output;
    }
    print(count);
  } catch (e) {
    print('Error: $e');
  }
}

List<String> findMapping(List<String> codes) {
  List<String> mapping = List.filled(10, "");
  final sortedCodes = codes.map((e) => sortString(e));
  mapping[1] = sortedCodes.where((code) => code.length == 2).first;
  mapping[7] = sortedCodes.where((code) => code.length == 3).first;
  mapping[4] = sortedCodes.where((code) => code.length == 4).first;
  mapping[8] = sortedCodes.where((code) => code.length == 7).first;
  mapping[3] = sortedCodes
      .where((code) => code.length == 5)
      .where((code) => countSimilarities(mapping[1]!, code) == 2)
      .first;
  mapping[9] = sortedCodes
      .where((code) => code.length == 6)
      .where((code) => countSimilarities(mapping[4]!, code) == 4)
      .first;
  mapping[5] = sortedCodes
      .where((code) => code.length == 5)
      .where((code) =>
          code != mapping[3] && countSimilarities(mapping[4]!, code) == 3)
      .first;
  mapping[2] = sortedCodes
      .where((code) => code.length == 5)
      .where((code) => code != mapping[3] && code != mapping[5])
      .first;
  mapping[6] = sortedCodes
      .where((code) => code.length == 6)
      .where((code) => countSimilarities(mapping[5]!, code) == 5)
      .where((code) => code != mapping[9])
      .first;
  mapping[0] = sortedCodes
      .where((code) => code.length == 6)
      .where((code) => code != mapping[6] && code != mapping[9])
      .first;
  return mapping;
}

String sortString(String input) {
  final characters = input.split("");
  characters.sort();
  return characters.join("");
}

int countSimilarities(String a, String b) {
  return a.split("").where((character) => b.contains(character)).length;
}
