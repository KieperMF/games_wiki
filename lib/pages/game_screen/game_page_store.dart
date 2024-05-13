import 'package:flutter/material.dart';
import 'package:games_wiki/models/game_model.dart';
import 'package:games_wiki/services/game_service.dart';

GameModel gameSelected = GameModel();

class GamePageStore with ChangeNotifier{
  List<GameModel> games = [];
  GameService service;
  GamePageStore({
    required this.service
  });
  List<String>? screenshots;
  String? previousPage;

  getGames()async{
    try{
      games = (await service.getAllGames())!;
    notifyListeners();
    }catch(e){
      debugPrint("erro $e");
    }
  }

  getGamesNextPage()async{
    try{
      List<GameModel>? moreGames = await service.getNextPageGames();
      games.addAll(moreGames!);
      previousPage = previousGamePage;
    notifyListeners();
    }catch(e){
      debugPrint("erro $e");
    }
  }

  getGamesPreviousPage()async{
    try{
      int i = 0;
      previousPage = await service.getPreviousPageGames();
      while(i < 20){
        games.removeLast();
        i++;
      }
    notifyListeners();
    }catch(e){
      debugPrint("erro $e");
    }
  }

  getGameScreenShots(int? id)async{
    try{
      screenshots = (await service.getGameScreenShots(id!))!;
    notifyListeners();
    }catch(e){
      debugPrint("erro get screenshot $e");
    }
  }
}