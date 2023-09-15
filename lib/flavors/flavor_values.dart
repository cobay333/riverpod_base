import 'package:flutter_dotenv/flutter_dotenv.dart';

class FlavorValues {
  final String apiBaseUrl;
  final String apiKey;
  final String title;


  const FlavorValues(this.title, {
    required this.apiBaseUrl,
    required this.apiKey
  });

  static FlavorValues fromEnvironment() {
    return FlavorValues(
        dotenv.get("TITLE"),
        apiKey: dotenv.get("API_KEY"),
        apiBaseUrl: dotenv.get("HOST"));
  }
}