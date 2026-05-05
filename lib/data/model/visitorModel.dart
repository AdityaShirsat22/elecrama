// To parse this JSON data, do
//
//     final visitorDetails = visitorDetailsFromJson(jsonString);

import 'dart:convert';

Visitormodel visitorDetailsFromJson(String str) =>
    Visitormodel.fromJson(json.decode(str));

String visitorDetailsToJson(Visitormodel data) => json.encode(data.toJson());

class Visitormodel {
  String? code;
  String? message;
  List<VisitorRecord>? records;

  Visitormodel({this.code, this.message, this.records});

  factory Visitormodel.fromJson(Map<String, dynamic> json) => Visitormodel(
    code: json["Code"],
    message: json["Message"],
    records: json["Records"] == null
        ? []
        : List<VisitorRecord>.from(
            json["Records"]!.map((x) => VisitorRecord.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "Records": records == null
        ? []
        : List<dynamic>.from(records!.map((x) => x.toJson())),
  };
}

class VisitorRecord {
  String? inId;
  String? stGuid;
  String? userId;
  String? salutation;
  String? firstName;
  String? lastName;
  String? organisation;
  String? country;
  String? state;
  String? city;
  String? address;
  String? address2;
  String? address3;
  String? pincode;
  String? website;
  String? telephone;
  String? emailId;
  String? mobileNo;
  String? designation;
  String? qrPath;

  VisitorRecord({
    this.inId,
    this.stGuid,
    this.userId,
    this.salutation,
    this.firstName,
    this.lastName,
    this.organisation,
    this.country,
    this.state,
    this.city,
    this.address,
    this.address2,
    this.address3,
    this.pincode,
    this.website,
    this.telephone,
    this.emailId,
    this.mobileNo,
    this.designation,
    this.qrPath,
  });

  factory VisitorRecord.fromJson(Map<String, dynamic> json) => VisitorRecord(
    inId: json["InID"]?.toString(),
    stGuid: json["stGuid"],
    userId: json["UserId"]?.toString(),
    salutation: json["Salutation"],
    firstName: json["FirstName"],
    lastName: json["LastName"],
    organisation: json["Organisation"],
    country: json["Country"],
    state: json["State"],
    city: json["City"],
    address: json["Address"],
    address2: json["Address2"],
    address3: json["Address3"],
    pincode: json["Pincode"],
    website: json["Website"],
    telephone: json["Telephone"],
    emailId: json["EmailId"],
    mobileNo: json["MobileNo"],
    designation: json["Designation"],
    qrPath: json["QRPath"],
  );

  Map<String, dynamic> toJson() => {
    "InID": inId,
    "stGuid": stGuid,
    "UserId": userId,
    "Salutation": salutation,
    "FirstName": firstName,
    "LastName": lastName,
    "Organisation": organisation,
    "Country": country,
    "State": state,
    "City": city,
    "Address": address,
    "Address2": address2,
    "Address3": address3,
    "Pincode": pincode,
    "Website": website,
    "Telephone": telephone,
    "EmailId": emailId,
    "MobileNo": mobileNo,
    "Designation": designation,
    "QRPath": qrPath,
  };
}
