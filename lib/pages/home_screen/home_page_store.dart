import 'package:flutter/material.dart';
import 'package:games_wiki/services/game_service.dart';
import 'package:games_wiki/models/game_model.dart';

class HomePageStore with ChangeNotifier{
  List<GameModel> games = [];
  GameService service;
  HomePageStore({
    required this.service
  });

  getGames()async{
    try{
      games = (await service.getAllGames())!;
    notifyListeners();
    }catch(e){
      debugPrint("erro $e");
    }
  }

  List<String>? screenshots;

  getGameScreenShots(int? id)async{
    try{
      screenshots = (await service.getGameScreenShots(id!))!;
    notifyListeners();
    }catch(e){
      debugPrint("erro get screenshot $e");
    }
  }
}