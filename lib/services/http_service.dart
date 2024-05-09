import 'package:flutter/material.dart';
import 'package:games_wiki/core/interfaces/http_interface.dart';
import 'package:http/http.dart' as http;

class HttpService implements HttpInterface{
  
  @override
  Future getData({required String path, Map<String, dynamic>? queryParam}) async{
    try{
      final response = await http.get(Uri.parse(path));
      return response;
    }catch(e){
      debugPrint("erro: $e");
    }
    
  }
}