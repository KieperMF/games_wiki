import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:games_wiki/core/interfaces/http_interface.dart';
import 'package:games_wiki/models/creators_model.dart';

class CreatorsService{
  CreatorsService({required this.http});
  List<CreatorsModel>? creators;
  HttpInterface http;

  getAllCreators() async {
    try {
      final response = await http.getData(path:'https://api.rawg.io/api/creators?key=f40f66dd22c542d2b422b922b714f749');
      final decode = jsonDecode(response.body)['results'] as List;
      creators = decode.map((e) => CreatorsModel.fromJson(e)).toList();
      return creators;
    } catch (e) {
      debugPrint('erro service: $e');
      return [];
    }
  }
}