import 'package:flags_app/commons/constants.dart';
import 'package:flags_app/screens/home/model/border_model.dart';
import 'package:flags_app/screens/home/model/country_model.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class CountryDatabase {
  static final CountryDatabase instance = CountryDatabase._init();

  static Database? _database;

  CountryDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(Constants.DB_NAME);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final countryIdType = 'TEXT PRIMARY KEY NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''CREATE TABLE $tableCountry ( 
          ${CountryFields.id} $countryIdType, 
          ${CountryFields.name} $textType,
          ${CountryFields.region} $textType,
          ${CountryFields.flagUrl} $textType,
          ${CountryFields.capital} $textType,
          ${CountryFields.languages} $textType
          )''');

    await db.execute('''CREATE TABLE $tableBorder ( 
          ${BorderFields.id} $idType, 
          ${BorderFields.countryId} $textType, 
          ${BorderFields.neighbourId} $textType
          )''');
  }

  /// Storing Country Data To Respective Tables
  Future<void> insertAllCountries(List<Country> countryList) async {
    final db = await instance.database;
    Batch batch = db.batch();
    countryList.forEach((country) {
      batch.insert(
        tableCountry,
        country.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      if (country.borderList != null && country.borderList!.length > 0) {
        country.borderList!.forEach((border) {
          batch.insert(
            tableBorder,
            {
              BorderFields.countryId: country.id,
              BorderFields.neighbourId: border,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        });
      }
    });
    batch.commit();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(Constants.KEY_DATA_LOADED, true);
  }

  Future<List<Country>> getAllCountries() async {
    final db = await instance.database;
    final orderBy = '${CountryFields.name} ASC';
    final result = await db.query(
      tableCountry,
      orderBy: orderBy,
    );
    return result.map((json) => Country.fromDBJson2(json)).toList();
  }

  Future<List<Country>> getCountriesForRegion(String region) async {
    final db = await instance.database;
    final orderBy = '${CountryFields.name} ASC';
    final result =
        await db.query(tableCountry, orderBy: orderBy, where: '${CountryFields.region} = ?', whereArgs: [region]);
    return result.map((json) => Country.fromDBJson2(json)).toList();
  }

  Future<List<Country>> getBorderCountries(String countryId) async {
    final db = await instance.database;
    var resultSet = await db.rawQuery(
        "SELECT" +
            " $tableCountry.${CountryFields.id},$tableCountry.${CountryFields.name},$tableCountry.${CountryFields.flagUrl},$tableCountry.${CountryFields.capital},$tableCountry.${CountryFields.region},$tableCountry.${CountryFields.languages}" +
            " FROM $tableCountry JOIN $tableBorder ON  $tableBorder.neighbour_id = $tableCountry._id WHERE $tableBorder.country_id IS ? ORDER BY $tableCountry.name ASC",
        [countryId]);
    return resultSet.map((json) => Country.fromDBJson2(json)).toList();
  }

  Future<List<String>> getAllRegions() async {
    final db = await instance.database;
    var resultSet = await db.rawQuery(
      "SELECT DISTINCT ${CountryFields.region} FROM $tableCountry ORDER BY ${CountryFields.region} ASC",
    );
    return resultSet.map<String>((json) => json['region'].toString()).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
