import 'dart:convert';

class ExhibitorDetails {
  String? code;
  String? message;
  List<ExhibitorRecord>? records;

  ExhibitorDetails({this.code, this.message, this.records});

  factory ExhibitorDetails.fromJson(dynamic data) {
    if (data is String) {
      return ExhibitorDetails.fromMap(json.decode(data));
    }
    return ExhibitorDetails.fromMap(data as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory ExhibitorDetails.fromMap(Map<String, dynamic> json) =>
      ExhibitorDetails(
        code: json["Code"],
        message: json["Message"],
        records: json["Records"] == null
            ? []
            : List<ExhibitorRecord>.from(
                json["Records"].map(
                  (x) => ExhibitorRecord.fromMap(Map<String, dynamic>.from(x)),
                ),
              ),
      );

  Map<String, dynamic> toMap() => {
    "Code": code,
    "Message": message,
    "Records": records == null
        ? []
        : List<dynamic>.from(records!.map((x) => x.toMap())),
  };
}

class ExhibitorRecord {
  String? guid;
  String? exhibitorUserId;
  String? exhibitorBadgeNo;
  String? exhibitorId;
  String? stName;
  String? stCompany;
  String? stDesignation;
  String? stEmailId;
  String? stPassword;
  String? stMobileNo;
  String? stcountry;
  String? qrPath;

  ExhibitorRecord({
    this.guid,
    this.exhibitorUserId,
    this.exhibitorBadgeNo,
    this.exhibitorId,
    this.stName,
    this.stCompany,
    this.stDesignation,
    this.stEmailId,
    this.stPassword,
    this.stMobileNo,
    this.stcountry,
    this.qrPath,
  });

  factory ExhibitorRecord.fromJson(dynamic data) {
    if (data is String) {
      return ExhibitorRecord.fromMap(json.decode(data));
    }
    return ExhibitorRecord.fromMap(data as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory ExhibitorRecord.fromMap(Map<String, dynamic> json) => ExhibitorRecord(
    guid: json["Guid"],
    exhibitorUserId: json["ExhibitorUserId"],
    exhibitorBadgeNo: json["ExhibitorBadgeNo"],
    exhibitorId: json["ExhibitorId"],
    stName: json["stName"],
    stCompany: json["stCompany"],
    stDesignation: json["stDesignation"],
    stEmailId: json["stEmailId"],
    stPassword: json["stPassword"],
    stMobileNo: json["stMobileNo"],
    stcountry: json["stcountry"],
    qrPath: json["QRPath"],
  );

  Map<String, dynamic> toMap() => {
    "Guid": guid,
    "ExhibitorUserId": exhibitorUserId,
    "ExhibitorBadgeNo": exhibitorBadgeNo,
    "ExhibitorId": exhibitorId,
    "stName": stName,
    "stCompany": stCompany,
    "stDesignation": stDesignation,
    "stEmailId": stEmailId,
    "stPassword": stPassword,
    "stMobileNo": stMobileNo,
    "stcountry": stcountry,
    "QRPath": qrPath,
  };
}
