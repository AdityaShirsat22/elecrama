// To parse this JSON data, do
//
//     final exhibitorFavouriteModel = exhibitorFavouriteModelFromJson(jsonString);

import 'dart:convert';

List<ExhibitorFavouriteModel> exhibitorFavouriteModelFromJson(String str) =>
    List<ExhibitorFavouriteModel>.from(
      json.decode(str).map((x) => ExhibitorFavouriteModel.fromJson(x)),
    );

String exhibitorFavouriteModelToJson(List<ExhibitorFavouriteModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExhibitorFavouriteModel {
  final int inid;
  final String guid;
  final String txtUserId;
  final String txtComName;
  final String hallNo;
  final String stallNo;
  final String contactPerson;
  final String pcDesignation;
  final String pcMobile;
  final int exhlogId;
  final String pcEmail;
  final String address;
  final String state;
  final String city;
  final String pin;
  final String website;
  final String txtcountry;
  final String productList;
  final String productCatIds;
  final int visitorLikes;
  final int hallId;
  final String stStallId;

  ExhibitorFavouriteModel({
    required this.inid,
    required this.guid,
    required this.txtUserId,
    required this.txtComName,
    required this.hallNo,
    required this.stallNo,
    required this.contactPerson,
    required this.pcDesignation,
    required this.pcMobile,
    required this.exhlogId,
    required this.pcEmail,
    required this.address,
    required this.state,
    required this.city,
    required this.pin,
    required this.website,
    required this.txtcountry,
    required this.productList,
    required this.productCatIds,
    required this.visitorLikes,
    required this.hallId,
    required this.stStallId,
  });

  factory ExhibitorFavouriteModel.fromJson(Map<String, dynamic> json) =>
      ExhibitorFavouriteModel(
        inid: json["inid"],
        guid: json["Guid"],
        txtUserId: json["TxtUserID"],
        txtComName: json["txtComName"],
        hallNo: json["HallNo"],
        stallNo: json["StallNo"],
        contactPerson: json["ContactPerson"],
        pcDesignation: json["PC_Designation"],
        pcMobile: json["PC_Mobile"],
        exhlogId: json["exhlogID"],
        pcEmail: json["PC_Email"],
        address: json["Address"],
        state: json["State"],
        city: json["City"],
        pin: json["Pin"],
        website: json["Website"],
        txtcountry: json["txtcountry"],
        productList: json["Product_List"],
        productCatIds: json["ProductCatIds"],
        visitorLikes: json["VisitorLikes"],
        hallId: json["HallId"],
        stStallId: json["stStallId"],
      );

  Map<String, dynamic> toJson() => {
    "inid": inid,
    "Guid": guid,
    "TxtUserID": txtUserId,
    "txtComName": txtComName,
    "HallNo": hallNo,
    "StallNo": stallNo,
    "ContactPerson": contactPerson,
    "PC_Designation": pcDesignation,
    "PC_Mobile": pcMobile,
    "exhlogID": exhlogId,
    "PC_Email": pcEmail,
    "Address": address,
    "State": state,
    "City": city,
    "Pin": pin,
    "Website": website,
    "txtcountry": txtcountry,
    "Product_List": productList,
    "ProductCatIds": productCatIds,
    "VisitorLikes": visitorLikes,
    "HallId": hallId,
    "stStallId": stStallId,
  };
}
