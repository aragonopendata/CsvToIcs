// Copyright (c) 2016, eder. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

//import 'package:CsvToIcs/CsvToIcs.dart';
import 'package:CsvToIcs/modifiers.dart';
import 'package:test/test.dart';

void main() {
  test('Summary', () {
    expect(getSummary("TEST","TEST"), "TEST");
    expect(getSummary("","TEST"), "TEST");
  });
  test('Month', () {
    expect(getMonth("enero"), "01");
    expect(getMonth("sept"), "09");
    expect(getMonth("diciembre"), "12");
  });
  test('Day', () {
    expect(getDay("1"), "01");
    expect(getDay("10"), "10");
  });
}
