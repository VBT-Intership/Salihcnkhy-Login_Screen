import 'package:http/http.dart' as http;
import 'dart:convert';

enum TaskType { Login, Register }

extension on TaskType {
  String getURL() {
    switch (this) {
      case TaskType.Login:
        return "http://192.168.1.104:3000/login";
        break;
      case TaskType.Register:
        return "http://192.168.1.104:3000/register";
        break;
      default:
        return "";
    }
  }
}

class Task {
  static Future<bool> makeRequest(TaskType type, Map<String, String> body) async {
    final http.Response response = await http.post(
      type.getURL(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
