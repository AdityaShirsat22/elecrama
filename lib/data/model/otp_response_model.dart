class OtpResponseModel {
  String? code;
  String? message;
  String? otp;
  String? guid;
  String? exhibitorUserId;
  String? exhibitorBadgeNo;
  String? exhibitorId;
  String? stName;
  String? stCompany;
  String? stDesignation;
  String? stEmailId;
  String? stMobileNo;
  String? qrPath;

  OtpResponseModel({
    this.code,
    this.message,
    this.otp,
    this.guid,
    this.exhibitorUserId,
    this.exhibitorBadgeNo,
    this.exhibitorId,
    this.stName,
    this.stCompany,
    this.stDesignation,
    this.stEmailId,
    this.stMobileNo,
    this.qrPath,
  });
  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpResponseModel(
      code: json['Code']?.toString(),
      message: json['Message']?.toString(),
      otp: json['OTP']?.toString(),
      guid: json['Guid']?.toString(),
      exhibitorUserId: json['ExhibitorUserId']?.toString(),
      exhibitorBadgeNo: json['ExhibitorBadgeNo']?.toString(),
      exhibitorId: json['ExhibitorId']?.toString(),
      stName: json['stName']?.toString(),
      stCompany: json['stCompany']?.toString(),
      stDesignation: json['stDesignation']?.toString(),
      stEmailId: json['stEmailId']?.toString(),
      stMobileNo: json['stMobileNo']?.toString(),
      qrPath: json['QRPath']?.toString(),
    );
  }
}
