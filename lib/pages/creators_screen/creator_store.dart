import 'package:flutter/material.dart';
import 'package:games_wiki/models/creators_model.dart';
import 'package:games_wiki/services/creators_service.dart';

CreatorsModel? creatorSelected;

class CreatorStore with ChangeNotifier{
  List<CreatorsModel> creators = [];
  CreatorsService service;
  CreatorStore({
    required this.service
  });

  getCreators()async{
    try{
      creators = await service.getCreators();
    notifyListeners();
    }catch(e){
      debugPrint("erro $e");
    }
  }

  getCreatorsNextPage() async{
    try{
      creators = await service.getNextCreators();
      notifyListeners();
    }catch(e){
      debugPrint("erro next creators $e");
    }
  }

  getCreatorsPreviousPage() async{
    try{
      List<CreatorsModel>? newCreators = await service.getPreviousCreators();
      if(newCreators.isNotEmpty){
        creators.clear();
        creators.addAll(newCreators);
      }
      notifyListeners();
    }catch(e){
      debugPrint("erro next creators $e");
    }
  }
}