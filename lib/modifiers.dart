// Copyright (c) 2016, zarisi. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'dart:convert';
import 'dart:io';
import 'package:csv_sheet/csv_sheet.dart';

///Lee el csv y lo transforma en un formato con el que trabajar
getCsvSheet(String filePath){
  File file = new File(filePath);
  return new CsvSheet(file.readAsStringSync(encoding: UTF8) , headerRow: true);
}

///Devuelve un mapa con los INE
Map<String, String> getINE(CsvSheet sheet) {
  Map<String, String> INE = new Map<String, String>();
  sheet.forEachRow((CsvRow row){
    INE.addAll({row[4]: row[1] + row[2]});
  });
  return INE;
}

///Transforma las fechas a un formato util para el ICS
String getDate(String date) {
  List<String> dateSplitted;
  if (date.contains("/")) {
    dateSplitted = date.split("/");
    return dateSplitted[2] + dateSplitted[1] + dateSplitted[0];
  } else if (date.contains(" de ")) {
    dateSplitted = date.split(" de ");
    return "2017" + getMonth(dateSplitted[1]) + getDay(dateSplitted[0]);
  } else {
    throw new StateError("no date given");
  }
}

///Corrige el formato del dia para el ICS
String getDay(String s) {
  if (s.length == 1) {
    return "0" + s;
  } else if (s.length != 2) {
    throw new StateError('Day have a wrong format: $s');
  } else {
    return s;
  }
}

///Transforma las fechas a un formato util para el ICS
String getMonth(String s) {
  switch (s.toLowerCase()) {
    case "enero":
      return "01";
    case "febrero":
      return "02";
    case "marzo":
      return "03";
    case "abril":
      return "04";
    case "mayo":
      return "05";
    case "junio":
      return "06";
    case "julio":
      return "07";
    case "agosto":
      return "08";
    case "sept":
    case "septie":
    case "septiem":
    case "septiembre":
      return "09";
    case "octubre":
      return "10";
    case "noviembre":
    case "noviem":
      return "11";
    case "diciem":
    case "diciembre":
      return "12";
    default:
      throw new StateError('Cant detect the month of the date: $s');
  }
}

/// devuelve el codigo DC de un INE
///
/// #Formula usada para obtener el DC
///
/// La formula para obtener el DC de un INE es sumar cada uno de los valores del
/// codigo transformandolo con unas tablas con estructura CBACB y lo que quede
/// hasta el siguiente multiplo de 10 sera el DC
/// ejemplo:
///  17141
///  CBACB
///  25183
///
///  2+5+1+8+3 = 19, el siguiente múltiplo de 10 es 20, luego el dígito de control es 20-19 = 1.
///
String getINEWithDC(String INE, String INEFromCSV) {
  try {
    if (INE == null) {
      return INEFromCSV;
    } else {
      Map<String, int> A = {
        "0": 0,
        "1": 1,
        "2": 2,
        "3": 3,
        "4": 4,
        "5": 5,
        "6": 6,
        "7": 7,
        "8": 8,
        "9": 9,
      };
      Map<String, int> B = {
        "0": 0,
        "1": 3,
        "2": 8,
        "3": 2,
        "4": 7,
        "5": 4,
        "6": 1,
        "7": 5,
        "8": 9,
        "9": 6,
      };
      Map<String, int> C = {
        "0": 0,
        "1": 2,
        "2": 4,
        "3": 6,
        "4": 8,
        "5": 1,
        "6": 3,
        "7": 5,
        "8": 7,
        "9": 9,
      };

      if (INE.length != 5) {
        throw "INE code has a worng length";
      } else {
        int n = C[INE[0]] + B[INE[1]] + A[INE[2]] + C[INE[3]] + B[INE[4]];
        int DC;
        if (n % 10 != 0) {
          DC = 10 - (n % 10);
        } else {
          DC = 0;
        }
        return INE + DC.toString();
      }
    }
  } catch (e, st) {
    print(e);
    return " ";
  }
}

///Devuelve un [Festivo] si tiene o [Lugar] en caso de no tener
String getSummary(String Festivo,String Lugar){
  if(Festivo == null || !Festivo.isEmpty ){
    return Festivo;
  }else{
    return Lugar;
  }
}
