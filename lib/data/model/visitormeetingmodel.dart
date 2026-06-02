// To parse this JSON data, do
//
//     final visitorMeetingModel = visitorMeetingModelFromJson(jsonString);

import 'dart:convert';

List<VisitorMeetingModel> visitorMeetingModelFromJson(String str) =>
    List<VisitorMeetingModel>.from(
      json.decode(str).map((x) => VisitorMeetingModel.fromJson(x)),
    );

String visitorMeetingModelToJson(List<VisitorMeetingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VisitorMeetingModel {
  String? txtComName;
  String? txtComChair;
  String? txtComDesi;
  String? txtComEmail;
  String? txtMobileCode;
  String? txtComMobile;
  String? txtConPerson;
  String? txtConDesi;
  String? txtConEmail;
  String? txtConMobile;
  int? meetingId;
  String? stGuid;
  int? exhibitorId;
  String? meetingTime;
  String? meetingdate;
  int? blExhibitorStatus;
  dynamic stExReason;
  String? dtExhibitordate;
  String? dtCreateddate;
  int? blMeetingStatus;
  dynamic stVisReason;
  String? exhibitorType;
  String? ddlExhTariff;
  String? ddlCorner;
  double? txtTotalArea;
  String? hallNo;
  String? stallNo;
  int? myRequest;
  int? blMailNotification;
  int? blNotifictnStatus;
  int? blExhibitorStatus2;

  VisitorMeetingModel({
    this.txtComName,
    this.txtComChair,
    this.txtComDesi,
    this.txtComEmail,
    this.txtMobileCode,
    this.txtComMobile,
    this.txtConPerson,
    this.txtConDesi,
    this.txtConEmail,
    this.txtConMobile,
    this.meetingId,
    this.stGuid,
    this.exhibitorId,
    this.meetingTime,
    this.meetingdate,
    this.blExhibitorStatus,
    this.stExReason,
    this.dtExhibitordate,
    this.dtCreateddate,
    this.blMeetingStatus,
    this.stVisReason,
    this.exhibitorType,
    this.ddlExhTariff,
    this.ddlCorner,
    this.txtTotalArea,
    this.hallNo,
    this.stallNo,
    this.myRequest,
    this.blMailNotification,
    this.blNotifictnStatus,
    this.blExhibitorStatus2,
  });

  factory VisitorMeetingModel.fromJson(Map<String, dynamic> json) =>
      VisitorMeetingModel(
        txtComName: json["txtComName"],
        txtComChair: json["txtComChair"],
        txtComDesi: json["txtComDesi"],
        txtComEmail: json["txtComEmail"],
        txtMobileCode: json["txtMobileCode"],
        txtComMobile: json["txtComMobile"],
        txtConPerson: json["txtConPerson"],
        txtConDesi: json["txtConDesi"],
        txtConEmail: json["txtConEmail"],
        txtConMobile: json["txtConMobile"],
        meetingId: json["MeetingId"],
        stGuid: json["stGuid"],
        exhibitorId: json["ExhibitorId"],
        meetingTime: json["MeetingTime"],
        meetingdate: json["Meetingdate"],
        blExhibitorStatus: json["blExhibitorStatus"],
        stExReason: json["stExReason"],
        dtExhibitordate: json["dtExhibitordate"],
        dtCreateddate: json["dtCreateddate"],
        blMeetingStatus: json["blMeetingStatus"],
        stVisReason: json["stVisReason"],
        exhibitorType: json["exhibitorType"],
        ddlExhTariff: json["ddlExhTariff"],
        ddlCorner: json["DDLCorner"],
        txtTotalArea: (json["txtTotalArea"] as num?)?.toDouble(),
        hallNo: json["HallNo"],
        stallNo: json["StallNo"],
        myRequest: json["MyRequest"],
        blMailNotification: json["blMailNotification"],
        blNotifictnStatus: json["blNotifictnStatus"],
        blExhibitorStatus2: json["blExhibitorStatus2"],
      );

  Map<String, dynamic> toJson() => {
    "txtComName": txtComName,
    "txtComChair": txtComChair,
    "txtComDesi": txtComDesi,
    "txtComEmail": txtComEmail,
    "txtMobileCode": txtMobileCode,
    "txtComMobile": txtComMobile,
    "txtConPerson": txtConPerson,
    "txtConDesi": txtConDesi,
    "txtConEmail": txtConEmail,
    "txtConMobile": txtConMobile,
    "MeetingId": meetingId,
    "stGuid": stGuid,
    "ExhibitorId": exhibitorId,
    "MeetingTime": meetingTime,
    "Meetingdate": meetingdate,
    "blExhibitorStatus": blExhibitorStatus,
    "stExReason": stExReason,
    "dtExhibitordate": dtExhibitordate,
    "dtCreateddate": dtCreateddate,
    "blMeetingStatus": blMeetingStatus,
    "stVisReason": stVisReason,
    "exhibitorType": exhibitorType,
    "ddlExhTariff": ddlExhTariff,
    "DDLCorner": ddlCorner,
    "txtTotalArea": txtTotalArea,
    "HallNo": hallNo,
    "StallNo": stallNo,
    "MyRequest": myRequest,
    "blMailNotification": blMailNotification,
    "blNotifictnStatus": blNotifictnStatus,
    "blExhibitorStatus2": blExhibitorStatus2,
  };
}
