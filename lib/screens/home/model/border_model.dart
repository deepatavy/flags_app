final String tableBorder = 'border';

class BorderFields {
  static final List<String> values = [id, countryId, neighbourId];

  static final String id = '_id';
  static final String countryId = 'country_id';
  static final String neighbourId = 'neighbour_id';
}

class Border {
  Border({
    this.id,
    required this.countryId,
    required this.neighbourId,
  });

  int? id;
  String countryId;
  String neighbourId;

  factory Border.fromJson(Map<String, dynamic> json) => Border(
        countryId: json[BorderFields.countryId],
        neighbourId: json[BorderFields.neighbourId],
      );

  Map<String, Object?> toJson() => {
        BorderFields.id: id,
        BorderFields.countryId: countryId,
        BorderFields.neighbourId: neighbourId,
      };
}
