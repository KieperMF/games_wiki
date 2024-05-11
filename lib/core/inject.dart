import 'package:games_wiki/core/interfaces/http_interface.dart';
import 'package:games_wiki/services/creators_service.dart';
import 'package:games_wiki/services/http_service.dart';
import 'package:games_wiki/services/game_service.dart';
import 'package:get_it/get_it.dart';
  
final inject = GetIt.instance;

class  Injenction{
  static void setup(){
    inject.registerFactory<HttpInterface>(() => HttpService());
    inject.registerFactory<GameService>(() => GameService(http: inject <HttpInterface>()));
    inject.registerFactory<CreatorsService>(() => CreatorsService(http: inject<HttpInterface>()));
  }
}