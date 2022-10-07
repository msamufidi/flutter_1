import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> createAlbum(String name, String job) async {
  final response = await http.post(
    Uri.parse('https://reqres.in/api/users'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'name': name, 'job': job}),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final String name;
  final String job;
  final String id;
  final String createdAt;

  const Album(
      {required this.name,
      required this.job,
      required this.id,
      required this.createdAt});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['name'],
      job: json['job'],
      id: json['id'],
      createdAt: json['createdAt'],
    );
  }
}
