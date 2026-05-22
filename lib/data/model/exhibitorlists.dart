// To parse this JSON data, do
//
//     final exhibitorLists = exhibitorListsFromJson(jsonString);

import 'dart:convert';

List<ExhibitorLists> exhibitorListsFromJson(String str) =>
    List<ExhibitorLists>.from(
      json.decode(str).map((x) => ExhibitorLists.fromJson(x)),
    );

String exhibitorListsToJson(List<ExhibitorLists> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExhibitorLists {
  final int inid;
  final String guid;
  final String exhibitorType;
  final String companyName;
  final String txtConPerson;
  final String txtConPreDesi;
  final String address;
  final String txtTelNo;
  final String txtMobile;
  final String email;
  final String stallNo;
  final String hallNo;
  final String txtUserEmailId;
  final String txtUserId;
  final String memType;
  final String chairmanname;
  final String chairmandesig;
  final String txtcountry;
  final String ddlRegion;
  final String ddlState;
  final String ddlCity;
  final String txtPin;
  final String productList;
  final String productListCatId;
  final int visitorLikes;
  final int hallId;
  final String stStallId;
  final String pavilion;

  ExhibitorLists({
    required this.inid,
    required this.guid,
    required this.exhibitorType,
    required this.companyName,
    required this.txtConPerson,
    required this.txtConPreDesi,
    required this.address,
    required this.txtTelNo,
    required this.txtMobile,
    required this.email,
    required this.stallNo,
    required this.hallNo,
    required this.txtUserEmailId,
    required this.txtUserId,
    required this.memType,
    required this.chairmanname,
    required this.chairmandesig,
    required this.txtcountry,
    required this.ddlRegion,
    required this.ddlState,
    required this.ddlCity,
    required this.txtPin,
    required this.productList,
    required this.productListCatId,
    required this.visitorLikes,
    required this.hallId,
    required this.stStallId,
    required this.pavilion,
  });

  ExhibitorLists copyWith({
    int? inid,
    String? guid,
    String? exhibitorType,
    String? companyName,
    String? txtConPerson,
    String? txtConPreDesi,
    String? address,
    String? txtTelNo,
    String? txtMobile,
    String? email,
    String? stallNo,
    String? hallNo,
    String? txtUserEmailId,
    String? txtUserId,
    String? memType,
    String? chairmanname,
    String? chairmandesig,
    String? txtcountry,
    String? ddlRegion,
    String? ddlState,
    String? ddlCity,
    String? txtPin,
    String? productList,
    String? productListCatId,
    int? visitorLikes,
    int? hallId,
    String? stStallId,
    String? pavilion,
  }) => ExhibitorLists(
    inid: inid ?? this.inid,
    guid: guid ?? this.guid,
    exhibitorType: exhibitorType ?? this.exhibitorType,
    companyName: companyName ?? this.companyName,
    txtConPerson: txtConPerson ?? this.txtConPerson,
    txtConPreDesi: txtConPreDesi ?? this.txtConPreDesi,
    address: address ?? this.address,
    txtTelNo: txtTelNo ?? this.txtTelNo,
    txtMobile: txtMobile ?? this.txtMobile,
    email: email ?? this.email,
    stallNo: stallNo ?? this.stallNo,
    hallNo: hallNo ?? this.hallNo,
    txtUserEmailId: txtUserEmailId ?? this.txtUserEmailId,
    txtUserId: txtUserId ?? this.txtUserId,
    memType: memType ?? this.memType,
    chairmanname: chairmanname ?? this.chairmanname,
    chairmandesig: chairmandesig ?? this.chairmandesig,
    txtcountry: txtcountry ?? this.txtcountry,
    ddlRegion: ddlRegion ?? this.ddlRegion,
    ddlState: ddlState ?? this.ddlState,
    ddlCity: ddlCity ?? this.ddlCity,
    txtPin: txtPin ?? this.txtPin,
    productList: productList ?? this.productList,
    productListCatId: productListCatId ?? this.productListCatId,
    visitorLikes: visitorLikes ?? this.visitorLikes,
    hallId: hallId ?? this.hallId,
    stStallId: stStallId ?? this.stStallId,
    pavilion: pavilion ?? this.pavilion,
  );

  factory ExhibitorLists.fromJson(Map<String, dynamic> json) => ExhibitorLists(
    inid: json["inid"] ?? 0,
    guid: json["Guid"] ?? "",
    exhibitorType: json["exhibitorType"] ?? "",
    companyName: json["CompanyName"] ?? "",
    txtConPerson: json["txtConPerson"] ?? "",
    txtConPreDesi: json["txtConPreDesi"] ?? "",
    address: json["Address"] ?? "",
    txtTelNo: json["txtTelNo"] ?? "",
    txtMobile: json["txtMobile"] ?? "",
    email: json["Email"] ?? "",
    stallNo: json["StallNo"] ?? "",
    hallNo: json["HallNo"] ?? "",
    txtUserEmailId: json["TxtUserEmailId"] ?? "",
    txtUserId: json["TxtUserID"] ?? "",
    memType: json["MEMType"] ?? "",
    chairmanname: json["chairmanname"] ?? "",
    chairmandesig: json["chairmandesig"] ?? "",
    txtcountry: json["txtcountry"] ?? "",
    ddlRegion: json["DDLRegion"] ?? "",
    ddlState: json["DDLState"] ?? "",
    ddlCity: json["DDLCity"] ?? "",
    txtPin: json["txtPin"] ?? "",
    productList: json["Product_List"] ?? "",
    productListCatId: json["Product_List_Cat_ID"] ?? "",
    visitorLikes: json["VisitorLikes"] ?? 0,
    hallId: json["HallId"] ?? 0,
    stStallId: json["stStallId"] ?? "",
    pavilion: json["Pavilion"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "inid": inid,
    "Guid": guid,
    "exhibitorType": exhibitorType,
    "CompanyName": companyName,
    "txtConPerson": txtConPerson,
    "txtConPreDesi": txtConPreDesi,
    "Address": address,
    "txtTelNo": txtTelNo,
    "txtMobile": txtMobile,
    "Email": email,
    "StallNo": stallNo,
    "HallNo": hallNo,
    "TxtUserEmailId": txtUserEmailId,
    "TxtUserID": txtUserId,
    "MEMType": memType,
    "chairmanname": chairmanname,
    "chairmandesig": chairmandesig,
    "txtcountry": txtcountry,
    "DDLRegion": ddlRegion,
    "DDLState": ddlState,
    "DDLCity": ddlCity,
    "txtPin": txtPin,
    "Product_List": productList,
    "Product_List_Cat_ID": productListCatId,
    "VisitorLikes": visitorLikes,
    "HallId": hallId,
    "stStallId": stStallId,
    "Pavilion": pavilion,
  };
}
