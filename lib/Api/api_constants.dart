class ApiConstants {
  static const String baseurl =
      "https://elecrama25.ngauge.co.in/ElecramaService.svc";
  static const String bannerurl = "$baseurl/GetBannerList";
  static const String visitorLogin = "$baseurl/GetVisitorLogin";
  static const String exhibitorLogin = "$baseurl/getExhibitorUserLoginDetails";
  static const String otpgeneration = "$baseurl/GenerateOTPV2";
  static const String exhibitorlist = "$baseurl/SearchExhibitorNew";
  static const String visitorfavlist = "$baseurl/GetMyExhibitorList";
  static const String visitorfavlistadddelete =
      "$baseurl/SaveDeleteStarVisitorbyExhibitor";

  static const String exhibitorfavlist =
      "$baseurl/GetMyExhibitorListByExhibitor";
  static const String exhibitorfavlistadddelete =
      "$baseurl/SaveDeleteStarExhibitorbyExhibitor";

  static const String exhibitorhalllist = "$baseurl//getExhibitorHallList";
  static const String countrylist = "$baseurl/getCountryList";
  static const String subcategorylist = "$baseurl/GetsubCategoryList";

  static const String forgetvisitorpassword =
      "https://elecrama25.ngauge.co.in/Visitors/Visitor_Forgot_Password.aspx";

  static const String exhibitordates = "$baseurl/GetExhibitionDates";

  static const String visitormeetings = "$baseurl/GetVisitorMeeting";

  static const String exhibitormeetings = "$baseurl/GetExhibitorUserMeeting";

  static const String getexhibitorprofile = "$baseurl/GetExhibitorProfile";

  static const String saveVisitorMeeting = "$baseurl/SaveVisitorMeeting";

  static const String acceptExhibitorMeeting =
      "$baseurl/AcceptExhibitorMeeting";

  static const String cancelExhibitorMeeting =
      "$baseurl/CancelExhibitorMeeting";

  static const String cancelVisitorMeeting = "$baseurl/CancelVisitorMeeting";

  static const String getnotificationvisitor =
      "$baseurl/GetNotificationVisitor";
  static const String getnotificationexhibitor =
      "$baseurl/GetNotificationExhibitor";

  static const String updatevisitornotifications =
      "$baseurl/UpdateVisitorNotifications";
  static const String updateexhibitornotifications =
      "$baseurl/UpdateExhibitorNotifications";

  static const String updatevisitormailnotifications =
      "$baseurl/UpdateVisitorMailNotifications";
  static const String updateexhibitormailnotifications =
      "$baseurl/UpdateExhibitorMailNotifications";

  
}
