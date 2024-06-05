import 'package:flutter/material.dart';
import 'package:games_wiki/models/game_model.dart';
import 'package:games_wiki/services/game_service.dart';

GameModel gameSelected = GameModel();

class GamePageStore with ChangeNotifier{
  List<GameModel> games = [];
  List<GameModel> releatedGames = [];
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

  /*getReleatedGames()async{
    try{
      releatedGames = (await service.getReleatedGames(gameSelected.id!))!;
    notifyListeners();
    }catch(e){
      debugPrint("erro $e");
    }
  }*/

  getGamesNextPage()async{
    try{
        games.clear();
        List<GameModel>? moreGames = await service.getNextPageGames();
        games= moreGames!;
        previousPage = previousGamePage;
        notifyListeners();
    }catch(e){
      debugPrint("erro $e");
    }
  }

  getGamesPreviousPage()async{
    try{
      List<GameModel>? moreGames = await service.getPreviousPageGames();
      games = moreGames!;
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

  getAchievements()async{
    await service.getGameAchievements();
  }

}