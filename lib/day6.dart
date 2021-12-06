import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'dart:math';

day6_1() async {
  File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day6.txt')
      .readAsString()
      .then((String contents) {
    print(contents);
    Map<int, int> daysUntilBirth = Map();
    contents.split(",").forEach((element) {
      final days = int.parse(element);
      if (daysUntilBirth.containsKey(days)) {
        daysUntilBirth[days] = daysUntilBirth[days]! + 1;
      } else {
        daysUntilBirth[days] = 1;
      }
    });
    for (int simulatedDays = 0; simulatedDays < 80; simulatedDays++) {
      final fishThatGaveBirth =
          daysUntilBirth.containsKey(0) ? daysUntilBirth[0]! : 0;
      daysUntilBirth.remove(0);
      final dates = daysUntilBirth.keys.toList();
      dates.sort();
      dates.forEach((element) {
        int count = daysUntilBirth.remove(element)!;
        daysUntilBirth[element - 1] = count;
      });
      if (daysUntilBirth.containsKey(6)) {
        daysUntilBirth[6] = daysUntilBirth[6]! + fishThatGaveBirth;
      } else {
        daysUntilBirth[6] = fishThatGaveBirth;
      }
      if (daysUntilBirth.containsKey(8)) {
        daysUntilBirth[8] = daysUntilBirth[8]! + fishThatGaveBirth;
      } else {
        daysUntilBirth[8] = fishThatGaveBirth;
      }
    }
    print(daysUntilBirth.values.reduce((value, element) => value + element));
  });
}

day6_2() async {
  File('C:\\Users\\brand\\Documents\\GitHub\\AOC2021\\lib\\day6.txt')
      .readAsString()
      .then((String contents) {
    print(contents);
    Map<int, int> daysUntilBirth = Map();
    contents.split(",").forEach((element) {
      final days = int.parse(element);
      if (daysUntilBirth.containsKey(days)) {
        daysUntilBirth[days] = daysUntilBirth[days]! + 1;
      } else {
        daysUntilBirth[days] = 1;
      }
    });
    for (int simulatedDays = 0; simulatedDays < 256; simulatedDays++) {
      final fishThatGaveBirth =
          daysUntilBirth.containsKey(0) ? daysUntilBirth[0]! : 0;
      daysUntilBirth.remove(0);
      final dates = daysUntilBirth.keys.toList();
      dates.sort();
      dates.forEach((element) {
        int count = daysUntilBirth.remove(element)!;
        daysUntilBirth[element - 1] = count;
      });
      if (daysUntilBirth.containsKey(6)) {
        daysUntilBirth[6] = daysUntilBirth[6]! + fishThatGaveBirth;
      } else {
        daysUntilBirth[6] = fishThatGaveBirth;
      }
      if (daysUntilBirth.containsKey(8)) {
        daysUntilBirth[8] = daysUntilBirth[8]! + fishThatGaveBirth;
      } else {
        daysUntilBirth[8] = fishThatGaveBirth;
      }
    }
    print(daysUntilBirth.values.reduce((value, element) => value + element));
  });
}
