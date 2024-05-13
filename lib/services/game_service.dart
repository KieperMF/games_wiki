import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:games_wiki/core/interfaces/http_interface.dart';
import 'package:games_wiki/models/game_model.dart';

class GameService {
  GameService({required this.http});
  List<GameModel>? games;
  HttpInterface http;

  Future<List<GameModel>?> getAllGames() async {
    try {
      final response = await http.getData(path:'https://api.rawg.io/api/games?key=f40f66dd22c542d2b422b922b714f749');
      final decode = jsonDecode(response.body)['results'] as List;
      games = decode.map((e) => GameModel.allGameFromJson(e)).toList();
      return games;
    } catch (e) {
      debugPrint('erro service: $e');
      return [];
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
