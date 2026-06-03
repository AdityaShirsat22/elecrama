// To parse this JSON data, do
//
//     final exhibitorMeetingModel = exhibitorMeetingModelFromJson(jsonString);

import 'dart:convert';

List<ExhibitorMeetingModel> exhibitorMeetingModelFromJson(String str) =>
    List<ExhibitorMeetingModel>.from(
      json.decode(str).map((x) => ExhibitorMeetingModel.fromJson(x)),
    );

String exhibitorMeetingModelToJson(List<ExhibitorMeetingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExhibitorMeetingModel {
  int? meetingId;
  String? meetingdate;
  String? meetingTime;
  int? blExhibitorStatus;
  String? visitorName;
  String? stGuid;
  String? organisation;
  String? designation;
  String? emailId;
  String? mobileNo;
  int? requested;
  String? meetingWith;
  int? blMailNotification;
  int? blNotifictnStatus;
  int? myRequest;

  ExhibitorMeetingModel({
    this.meetingId,
    this.meetingdate,
    this.meetingTime,
    this.blExhibitorStatus,
    this.visitorName,
    this.stGuid,
    this.organisation,
    this.designation,
    this.emailId,
    this.mobileNo,
    this.requested,
    this.meetingWith,
    this.blMailNotification,
    this.blNotifictnStatus,
    this.myRequest,
  });

  factory ExhibitorMeetingModel.fromJson(Map<String, dynamic> json) =>
      ExhibitorMeetingModel(
        meetingId: json["MeetingId"],
        meetingdate: json["Meetingdate"],
        meetingTime: json["MeetingTime"],
        blExhibitorStatus: json["blExhibitorStatus"],
        visitorName: json["VisitorName"],
        stGuid: json["stGuid"],
        organisation: json["Organisation"],
        designation: json["Designation"],
        emailId: json["EmailId"],
        mobileNo: json["MobileNo"],
        requested: json["Requested"],
        meetingWith: json["MeetingWith"],
        blMailNotification: json["blMailNotification"],
        blNotifictnStatus: json["blNotifictnStatus"],
        myRequest: json["MyRequest"],
      );

  Map<String, dynamic> toJson() => {
    "MeetingId": meetingId,
    "Meetingdate": meetingdate,
    "MeetingTime": meetingTime,
    "blExhibitorStatus": blExhibitorStatus,
    "VisitorName": visitorName,
    "stGuid": stGuid,
    "Organisation": organisation,
    "Designation": designation,
    "EmailId": emailId,
    "MobileNo": mobileNo,
    "Requested": requested,
    "MeetingWith": meetingWith,
    "blMailNotification": blMailNotification,
    "blNotifictnStatus": blNotifictnStatus,
    "MyRequest": myRequest,
  };
}
