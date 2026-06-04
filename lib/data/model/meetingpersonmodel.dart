// To parse this JSON data, do
//
//     final meetingPersonModel = meetingPersonModelFromJson(jsonString);

import 'dart:convert';

List<MeetingPersonModel> meetingPersonModelFromJson(String str) =>
    List<MeetingPersonModel>.from(
      json.decode(str).map((x) => MeetingPersonModel.fromJson(x)),
    );

String meetingPersonModelToJson(List<MeetingPersonModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MeetingPersonModel {
  String? txtUserId;
  String? directoryEmail;
  String? companyProfile;
  String? exhibitorProducts;
  String? exhibitorFiles;
  String? exhibitorConnect;

  MeetingPersonModel({
    this.txtUserId,
    this.directoryEmail,
    this.companyProfile,
    this.exhibitorProducts,
    this.exhibitorFiles,
    this.exhibitorConnect,
  });

  factory MeetingPersonModel.fromJson(Map<String, dynamic> json) =>
      MeetingPersonModel(
        txtUserId: json["TxtUserID"],
        directoryEmail: json["DirectoryEmail"],
        companyProfile: json["CompanyProfile"],
        exhibitorProducts: json["ExhibitorProducts"],
        exhibitorFiles: json["ExhibitorFiles"],
        exhibitorConnect: json["ExhibitorConnect"],
      );

  Map<String, dynamic> toJson() => {
    "TxtUserID": txtUserId,
    "DirectoryEmail": directoryEmail,
    "CompanyProfile": companyProfile,
    "ExhibitorProducts": exhibitorProducts,
    "ExhibitorFiles": exhibitorFiles,
    "ExhibitorConnect": exhibitorConnect,
  };
}
