import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStudent {
  final String _name = "name";
  final String _phone = "phone";
  final String _password = "password";
  final String _address = "address";
  final String _stateRegion = "stateRegion";
  final String _hobbies = "hobbies";
  final String _gender = "gender";
  final String _openForJob = "openForJob";

  void safeStudent({
    required String name,
    required String phone,
    required String password,
    required String address,
    required String stateRegion,
    required List<String> hobbies,
    required String gender,
    required bool openForJob,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString(_name, name);
    sharedPreferences.setString(_phone, phone);
    sharedPreferences.setString(_password, password);
    sharedPreferences.setString(_address, address);
    sharedPreferences.setString(_stateRegion, stateRegion);
    sharedPreferences.setStringList(_hobbies, hobbies);
    sharedPreferences.setString(_gender, gender);
    sharedPreferences.setBool(_openForJob, openForJob);
  }
}
