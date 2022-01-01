final String tableLanguage = 'language';

class LanguageFields {
  static final List<String> values = [id, countryId, language];

  static final String id = '_id';
  static final String countryId = 'country_id';
  static final String language = 'language';
}

class Language {
  Language({
    required this.id,
    required this.countryId,
    required this.language,
  });

  int? id;
  String countryId;
  String language;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json[LanguageFields.id],
        countryId: json[LanguageFields.countryId],
        language: json[LanguageFields.language],
      );

  Map<String, Object?> toJson() => {
        LanguageFields.id: id,
        LanguageFields.countryId: countryId,
        LanguageFields.language: language,
      };
}
