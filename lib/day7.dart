import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'dart:math';

day7_1() async {
  File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day7.txt')
      .readAsString()
      .then((String contents) {
    List<int> numbers = contents.split(",").map((e) => int.parse(e)).toList();
    Map<int, int> positions = Map();
    numbers.forEach((element) {
      if (positions.containsKey(element)) {
        positions[element] = positions[element]! + 1;
      } else {
        positions[element] = 1;
      }
    });
    numbers.sort();
    final median = numbers[(numbers.length / 2).toInt()];
    int difference = 0;
    positions.forEach((key, value) {
      difference += (key - median).abs() * value;
    });
    print(difference);
  });
}

day7_2() async {
  File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day7.txt')
      .readAsString()
      .then((String contents) {
    List<int> numbers = contents.split(",").map((e) => int.parse(e)).toList();
    Map<int, int> positions = Map();
    numbers.forEach((element) {
      if (positions.containsKey(element)) {
        positions[element] = positions[element]! + 1;
      } else {
        positions[element] = 1;
      }
    });
    int sum = 0;
    positions.forEach((key, value) {
      sum += key * value;
    });
    int mean = (sum / numbers.length).toInt();
    int difference = 0;
    positions.forEach((key, value) {
      int diff = (key - mean).abs();
      double sum = diff * (diff + 1) / 2;
      //thank you Alison
      difference += sum.toInt() * value;
    });
    print(difference);
  });
}
