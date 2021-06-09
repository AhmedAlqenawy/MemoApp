import 'dart:convert';

import 'package:flutter/material.dart';


Person barangFromMap(String str) => Person.fromMap(json.decode(str));

String barangToMap(Person data) => json.encode(data.toMap());


class Person {
  Person({
    this.name,
    this.memoNum,
    this.birthDate

  });
  String name ;
  int memoNum;
  String birthDate;


  factory Person.fromMap(Map<dynamic, dynamic> json) => Person(
    name: json["name"] == null ? null : json["name"],
    memoNum: json["memoNum"] == null ? null : json["memoNum"],
    birthDate: json["birthDate"] == null ? null : json["birthDate"],

  );

  Map<String, dynamic> toMap() => {
     "name": name == null ? null : name,
    "memoNum": memoNum == null ? null : memoNum,
    "birthDate": birthDate == null ? null : birthDate,
  };
}
