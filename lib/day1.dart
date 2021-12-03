import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

day1_1() async {
  final file =
      File('C:\\Users\\brand\\Documents\\code\\aoc2021_1\\lib\\day1.txt');
  var previous = -1;
  var count = 0;
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    await for (var line in lines) {
      final current = int.parse(line);
      if (previous == -1) {
        print('$line (N/A - no previous measurement)');
      } else if (current > previous) {
        print('$line (increased)');
        count++;
      } else {
        print('$line (decreased)');
      }
      previous = current;
    }
    print(count);
  } catch (e) {
    print('Error: $e');
  }
}

day1_2() async {
  final file =
      File('C:\\Users\\brand\\Documents\\code\\aoc2021_1\\lib\\day1.txt');
  var previous = Queue<int>();
  var count = 0;
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    await for (var line in lines) {
      final current = int.parse(line);
      if (previous.length < 3) {
        print('$line (N/A - no previous measurement)');
      } else {
        if (current > previous.first) {
          print('$line (increased)');
          count++;
        } else {
          print('$line (decreased)');
        }
      }
      previous.add(current);
      if (previous.length > 3) previous.removeFirst();
    }
    print(count);
  } catch (e) {
    print('Error: $e');
  }
}
