import 'dart:math';
import '../models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _authenticator(
      String email, String password, String urlSpec) async {
    final url = Uri.parse(urlSpec);
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticator(
      email,
      password,
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBFxE6Z_MEzZEdWdCHOM4zai9Qu5aNLV5k',
    );
  }

  Future<void> logIn(String email, String password) async {
    return _authenticator(
      email,
      password,
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBFxE6Z_MEzZEdWdCHOM4zai9Qu5aNLV5k',
    );
  }
}
