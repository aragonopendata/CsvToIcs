// Copyright (c) 2016, zarisi. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library core;

export 'package:CsvToIcs/core.dart';
export 'package:CsvToIcs/modifiers.dart';
import 'dart:async';
import 'dart:io';
import 'package:CsvToIcs/modifiers.dart';

import 'package:csv_sheet/csv_sheet.dart';

/// Transforma el csv a ics
///
///  [csvPath] es la ruta del csv que se quiere parsear y debes pasarle el [inePath] para que puedas obtener el ine de cada localidad ademas de pasarle [finalPath] para saber donde guardar el archivo
Future csvToIcs(String csvPath, String inePath, String finalPath) async {
  printSheet(getCsvSheet(csvPath), getINE(getCsvSheet(inePath)), finalPath);
}

///Genera un string con el ics y lo imprime en un archivo
///
/// usa el [csvSheet] para obtener todos los datos necesarios y [INE] para obtener los datos necesarios para elegir el ine
void printSheet(CsvSheet csvSheet, Map<String, String> INE, String finalPath) {
  String icsSheet = "";
  icsSheet += "BEGIN:VCALENDAR\n";
  icsSheet +=
      "PRODID:-//Gobierno de Aragon//Festivos en Comunidad de Aragon//ES\n";
  icsSheet += "VERSION:2.0\n";
  icsSheet += "CALSCALE:GREGORIAN\n";
  csvSheet.forEachRow((CsvRow row) {
    try {
      String DTSTART = getDate(row[3]);
      String SUMMARY = getSummary(row[4], row[2]);
      String LOCATION = row[2];
      String DESCRIPTION = getINEWithDC(INE[row[2]], row[1]);
      icsSheet += "BEGIN:VEVENT\n";
      icsSheet += "DTSTAMP:20170526T135421Z\n";
      icsSheet += "DTSTART;VALUE=DATE:$DTSTART\n";
      icsSheet += "SUMMARY:$SUMMARY\n";
      icsSheet += "LOCATION:$LOCATION\n";
      icsSheet += "DESCRIPTION:$DESCRIPTION\n";
      icsSheet += "END:VEVENT\n";
    } catch (exception, stackTrace) {
      print(exception);
      //print(stackTrace);
    }
  });
  icsSheet += "END:VCALENDAR\n";
  printToFile(icsSheet, finalPath);
}

///Imprime el ics a un archivo en la ubicacion indicada
void printToFile(String icsSheet, String finalPath) {
  new File(finalPath).writeAsString(icsSheet).then((File file) {
    print("File created at $finalPath");
  });
}
