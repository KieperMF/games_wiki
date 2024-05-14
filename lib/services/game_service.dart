import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:games_wiki/core/interfaces/http_interface.dart';
import 'package:games_wiki/models/game_model.dart';

String? nextGamePage;
String? previousGamePage;

class GameService {
  GameService({required this.http});
  List<GameModel>? games;
  HttpInterface http;

  Future<List<GameModel>?> getAllGames() async {
    try {
      final response = await http.getData(path:'https://api.rawg.io/api/games?key=f40f66dd22c542d2b422b922b714f749');
      nextGamePage = jsonDecode(response.body)['next'];
      final decode = jsonDecode(response.body)['results'] as List;
      games = decode.map((e) => GameModel.allGameFromJson(e)).toList();
      return games;
    } catch (e) {
      debugPrint('erro service: $e');
      return [];
    }
  }

  Future<List<GameModel>?> getNextPageGames() async {
    try {
      final response = await http.getData(path: '$nextGamePage');
      nextGamePage = jsonDecode(response.body)['next'];
      previousGamePage = jsonDecode(response.body)['previous'];
      final decode = jsonDecode(response.body)['results'] as List;
      games = decode.map((e) => GameModel.allGameFromJson(e)).toList();
      return games;
    } catch (e) {
      debugPrint('erro service: $e');
      return [];
    }
  }

  getPreviousPageGames() async {
    try {
      final response = await http.getData(path: '$previousGamePage');
      nextGamePage = jsonDecode(response.body)['next'];
      previousGamePage = jsonDecode(response.body)['previous'] ;
      final decode = jsonDecode(response.body)['results'] as List;
      games = decode.map((e) => GameModel.allGameFromJson(e)).toList();
      return games;
    } catch (e) {
      debugPrint('erro service: $e');
    }
  }

  getGameScreenShots(int gameId) async {
    try {
      List<String> screenShotsGame = [];
      final response = await http.getData(
          path:
              'https://api.rawg.io/api/games/$gameId/screenshots?key=f40f66dd22c542d2b422b922b714f749');
      final decode = jsonDecode(response.body);
      List<dynamic> results = decode['results'] as List;
      for (var result in results) {
        screenShotsGame.add(result['image']);
      }
      return screenShotsGame;
    } catch (e) {
      debugPrint('erro screenshot service: $e');
      return [];
    }
  }
}
