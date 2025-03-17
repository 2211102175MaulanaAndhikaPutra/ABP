import 'dart:convert';
import 'models/user_model.dart';

void main() {
  // Contoh JSON response
  String jsonResponse = '''
  {
    "user_id": 1,
    "id": 13,
    "title": "Bedroom Pop"
  }
  ''';

  // Konversi JSON ke objek User
  Map<String, dynamic> userMap = json.decode(jsonResponse);
  User user = User.fromJson(userMap);

  // Cetak data hasil konversi
  print("User ID: ${user.userId}");
  print("ID: ${user.id}");
  print("Title: ${user.title}");

  // Konversi kembali dari objek User ke JSON
  String userToJson = json.encode(user.toJson());
  print("User dalam format JSON: $userToJson");
}
