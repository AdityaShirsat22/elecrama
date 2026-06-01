class ExhibitionDateModel {
  String? eventDate;

  ExhibitionDateModel({this.eventDate});

  ExhibitionDateModel.fromJson(Map<String, dynamic> json) {
    eventDate = json['EventDate'];
  }
}