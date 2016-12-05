// Copyright (c) 2016, zarisi. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'package:CsvToIcs/core.dart';

main(List<String> arguments){
  csvToIcs("in/csvTeruel.csv", "in/ineTeruel.csv", "out/Teruel.ics");
  csvToIcs("in/csvHuesca.csv", "in/ineHuesca.csv", "out/Huesca.ics");
  csvToIcs("in/csvZaragoza.csv", "in/ineZaragoza.csv", "out/Zaragoza.ics");
}
