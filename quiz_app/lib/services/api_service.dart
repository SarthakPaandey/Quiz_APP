import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';
// import '../models/models.dart';
import 'dart:io' show Platform;

class ApiService {
  final String baseUrl =
      Platform.isAndroid ? 'http://10.0.2.2:8080' : 'http://localhost:8080';

  Future<void> submitScore(String name, int score, int health) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/leaderboard'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'score': score, 'health': health}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to submit score: ${response.statusCode}');
      }
    } catch (e) {
      print('Error submitting score: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getLeaderboard() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/leaderboard'))
          .timeout(Duration(seconds: 10)); // Add a 10-second timeout

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data
            .map((entry) => {
                  'name': entry['name'],
                  'score': entry['score'],
                  'health': entry['health'],
                })
            .toList();
      } else {
        throw Exception('Failed to load leaderboard: ${response.statusCode}');
      }
    } on TimeoutException catch (_) {
      print('Connection timed out');
      throw Exception('Connection timed out');
    } catch (e) {
      print('Error loading leaderboard: $e');
      throw Exception('Failed to load leaderboard: $e');
    }
  }
}
