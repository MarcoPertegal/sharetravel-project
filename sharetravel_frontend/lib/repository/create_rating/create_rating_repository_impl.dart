import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetravel_frontend/model/dto/new_rating_dto.dart';
import 'package:sharetravel_frontend/model/response/create_rating_response/create_rating_response.dart';
import 'package:sharetravel_frontend/repository/create_rating/create_rating_repository.dart';

class CreateRatingRepositoryImpl extends CreateRatingRepository {
  final Client _httpClient = Client();

  @override
  Future<CreateRatingResponse> createRating(NewRatingDto newRatingDto) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found or something go wrong');
    }

    final jsonBody = jsonEncode(newRatingDto.toJson());

    final response = await _httpClient.post(
      Uri.parse('http://localhost:8080/rating/new'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonBody,
    );
    //ESTOY PROBANDO si el errorMessage devuelve el mensaje desde la api y este cambia dependiendo
    //de el status code si esto funciona significaria que los if no harían falta y con poner un else
    //y un thow exception valdria pq el mensaje iria cambiando desde la api
    if (response.statusCode == 201) {
      print(response.body);
      return CreateRatingResponse.fromJson(response.body);
    } else {
      final jsonResponse = json.decode(response.body);
      final errorMessage =
          jsonResponse['message'] as String? ?? "Unknown error";
      throw Exception(errorMessage);
    }
  }
}
