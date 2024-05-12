import 'package:flutter/material.dart';
import 'package:games_wiki/models/creators_model.dart';
import 'package:games_wiki/services/creators_service.dart';

class CreatorStore with ChangeNotifier{
  List<CreatorsModel> creators = [];
  CreatorsService service;
  CreatorStore({
    required this.service
  });

  getCreators()async{
    try{
      creators = await service.getAllCreators();
    notifyListeners();
    }catch(e){
      debugPrint("erro $e");
    }
  }
}