import 'dart:convert';


Memo barangFromMap(String str) => Memo.fromMap(json.decode(str));

String barangToMap(Memo data) => json.encode(data.toMap());


class Memo {
  Memo({
    this.titel,
    this.discription,
    this.pirsonName

  });
  String discription,titel,pirsonName;
  factory Memo.fromMap(Map<dynamic, dynamic> json) => Memo(
    titel: json["titel"] == null ? null : json["titel"],
    discription: json["discription"] == null ? null : json["discription"],
    pirsonName: json["pirsonName"] == null ? null : json["pirsonName"],

  );

  Map<String, dynamic> toMap() => {
    "titel": titel == null ? null : titel,
    "discription": discription == null ? null : discription,
    "pirsonName": pirsonName == null ? null : pirsonName,
  };
}
