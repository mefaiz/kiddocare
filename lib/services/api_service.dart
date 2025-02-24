import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/kindergarten.dart';

class ApiService {
  
  static const String baseUrl = 'https://flutter-test.kiddocare.my';

  // to get the list of kindergartens
  Future<List<Kindergarten>> getKindergartens({
    required int page,
    required int perPage,
  }) async {

    try {
      final queryParams = {
        '_page': page.toString(),
        '_per_page': perPage.toString(),
      };

      final uri = Uri.parse('$baseUrl/kindergartens?')
          .replace(queryParameters: queryParams);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['data'].map<Kindergarten>((json) => Kindergarten.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load kindergartens');
      }
    } catch (e) {
      throw Exception('Error fetching kindergartens: $e');
    }
  }

  // to get the details of a kindergarten
  Future<Kindergarten> getKindergartenDetails(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/kindergartens/$id'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Kindergarten.fromJson(data);
      } else {
        throw Exception('Failed to load kindergarten details');
      }
    } catch (e) {
      throw Exception('Error fetching kindergarten details: $e');
    }
  }
} 