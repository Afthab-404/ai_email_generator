import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<String> generateEmail({
    required String purpose,
    required String tone,
  }) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/generate-email'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'purpose': purpose,
        'tone': tone,
        'email_type': 'leave request'
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['generated_email'];
    }

    throw Exception('Failed to generate email');
  }
}