class BannerModel {
  final String logoUrl;
  final String link;

  BannerModel({
    required this.logoUrl,
    required this.link,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      logoUrl: json['LogoUrl'],
      link: json['Link'],
    );
  }
}