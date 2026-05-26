class ApiConstants {
  static const String baseurl =
      "https://elecrama25.ngauge.co.in/ElecramaService.svc";
  static const String bannerurl = "$baseurl/GetBannerList";
  static const String visitorLogin = "$baseurl/GetVisitorLogin";
  static const String exhibitorLogin = "$baseurl/getExhibitorUserLoginDetails";
  static const String otpgeneration = "$baseurl/GenerateOTPV2";
  static const String exhibitorlist = "$baseurl/SearchExhibitorNew";
  static const String exhibitorfavlist =
      "$baseurl/GetMyExhibitorListByExhibitor";
  static const String visitorfavlist = "$baseurl/GetMyExhibitorList";
  static const String visitorfavlistadddelete =
      "$baseurl/SaveDeleteStarVisitorbyExhibitor";
}
