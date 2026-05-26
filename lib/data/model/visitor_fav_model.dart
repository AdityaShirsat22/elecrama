class VisitorFavoriteModel {
  final int exhibitorId;
  final String guid;
  final String txtUserID;
  final String companyName;
  final String hallNo;
  final String stallNo;
  final String contactPerson;
  final String designation;
  final String mobile;
  final String email;
  final String address;
  final String state;
  final String city;
  final String pin;
  final String website;
  final String country;
  final String productList;
  final String productCatIds;
  final int visitorLikes;
  final int hallId;
  final String stallId;

  bool isFavorite;

  VisitorFavoriteModel({
    required this.exhibitorId,
    required this.guid,
    required this.txtUserID,
    required this.companyName,
    required this.hallNo,
    required this.stallNo,
    required this.contactPerson,
    required this.designation,
    required this.mobile,
    required this.email,
    required this.address,
    required this.state,
    required this.city,
    required this.pin,
    required this.website,
    required this.country,
    required this.productList,
    required this.productCatIds,
    required this.visitorLikes,
    required this.hallId,
    required this.stallId,
    this.isFavorite = true,
  });

  factory VisitorFavoriteModel.fromJson(Map<String, dynamic> json) {
    return VisitorFavoriteModel(
      exhibitorId: int.tryParse(json['inid']?.toString() ?? '') ?? 0,
      guid: json['Guid'] ?? '',
      txtUserID: json['TxtUserID'] ?? '',
      companyName: json['txtComName'] ?? json['CompanyName'] ?? '',
      hallNo: json['HallNo'] ?? '',
      stallNo: json['StallNo'] ?? '',
      contactPerson: json['ContactPerson'] ?? '',
      designation: json['PC_Designation'] ?? '',
      mobile: json['PC_Mobile'] ?? '',
      email: json['PC_Email'] ?? '',
      address: json['Address'] ?? '',
      state: json['State'] ?? '',
      city: json['City'] ?? '',
      pin: json['Pin'] ?? '',
      website: json['Website'] ?? '',
      country: json['txtcountry'] ?? '',
      productList: json['Product_List'] ?? '',
      productCatIds: json['ProductCatIds'] ?? '',
      visitorLikes: int.tryParse(json['VisitorLikes']?.toString() ?? '') ?? 0,
      hallId: int.tryParse(json['HallId']?.toString() ?? '') ?? 0,
      stallId: json['stStallId'] ?? '',
      isFavorite: true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "inid": exhibitorId,
      "Guid": guid,
      "TxtUserID": txtUserID,
      "txtComName": companyName,
      "HallNo": hallNo,
      "StallNo": stallNo,
      "ContactPerson": contactPerson,
      "PC_Designation": designation,
      "PC_Mobile": mobile,
      "PC_Email": email,
      "Address": address,
      "State": state,
      "City": city,
      "Pin": pin,
      "Website": website,
      "txtcountry": country,
      "Product_List": productList,
      "ProductCatIds": productCatIds,
      "VisitorLikes": visitorLikes,
      "HallId": hallId,
      "stStallId": stallId,
    };
  }
}
