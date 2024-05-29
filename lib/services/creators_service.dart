import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:games_wiki/core/interfaces/http_interface.dart';
import 'package:games_wiki/models/creators_model.dart';

String? nextCreatorsPage;
String? previousCreatorsPage;

class CreatorsService{
  CreatorsService({required this.http});
  List<CreatorsModel> creators = [];
  HttpInterface http;

  Future<List<CreatorsModel>> getCreators() async {
    try {
      final response = await http.getData(path:'https://api.rawg.io/api/creators?key=f40f66dd22c542d2b422b922b714f749');
      nextCreatorsPage = jsonDecode(response.body)['next'];
      final decode = jsonDecode(response.body)['results'] as List;
      creators = decode.map((e) => CreatorsModel.fromJson(e)).toList();
      return creators;
    } catch (e) {
      debugPrint('erro service: $e');
      return [];
    }
  }

  Future<List<CreatorsModel>> getNextCreators() async{
    try{
      final response = await http.getData(path:'$nextCreatorsPage');
      nextCreatorsPage = jsonDecode(response.body)['next'];
      previousCreatorsPage = jsonDecode(response.body)['previous'];
      final decode = jsonDecode(response.body)['results'] as List;
      creators = decode.map((e) => CreatorsModel.fromJson(e)).toList();
      return creators;
    }catch(e){
      debugPrint('erro service next creators: $e');
      return [];
    }
  }

  Future<List<CreatorsModel>> getPreviousCreators() async{
    try{
      if(previousCreatorsPage != null){
        final response = await http.getData(path:'$previousCreatorsPage');
        nextCreatorsPage = jsonDecode(response.body)['next'];
        previousCreatorsPage = jsonDecode(response.body)['previous'];
        final decode = jsonDecode(response.body)['results'] as List;
        creators = decode.map((e) => CreatorsModel.fromJson(e)).toList();
      }
      return creators;
    }catch(e){
      debugPrint('erro service next creators: $e');
      return [];
    }
  }
}