import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> generateOTP(String email) async {
  final url = Uri.parse('http://212.47.65.193:8888/api/v1/auth/generate-otp');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'email': email,
      'otpType': 'EMAIL_VERIFICATION',
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['success']) {
      return data['result'];
    }
  }

  throw Exception('Failed to generate OTP');
}
Future<String> verifyOTP(String email, String otpCode) async {
  final url = Uri.parse('http://212.47.65.193:8888/api/v1/auth/verify-otp');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'email': email,
      'otpCode': otpCode,
      'otpType': 'EMAIL_VERIFICATION',
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['success']) {
      return data['result']['token'];
    }
  }

  throw Exception('Failed to verify OTP');
}
