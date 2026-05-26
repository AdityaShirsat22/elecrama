class VisitorFavoriteModel {
  final int exhibitorId;
  final String companyName;
  final String hallNo;
  final String stallNo;
  bool isFavorite;

  VisitorFavoriteModel({
    required this.exhibitorId,
    required this.companyName,
    required this.hallNo,
    required this.stallNo,
    this.isFavorite = true,
  });

  factory VisitorFavoriteModel.fromJson(Map<String, dynamic> json) {
    return VisitorFavoriteModel(
      exhibitorId: int.tryParse(json['inid']?.toString() ?? '') ?? 0,
      companyName: json['txtComName'] ?? json['CompanyName'] ?? '',
      hallNo: json['HallNo'] ?? '',
      stallNo: json['StallNo'] ?? '',
      isFavorite: true,
    );
  }
}
