class ExhibitorConnectModel {
  int? id;
  String? staffName;
  String? designation;

  ExhibitorConnectModel({
    this.id,
    this.staffName,
    this.designation,
  });

  factory ExhibitorConnectModel.fromJson(Map<String, dynamic> json) {
    return ExhibitorConnectModel(
      id: json['ID'],
      staffName: json['StaffName'],
      designation: json['Designation'],
    );
  }
}