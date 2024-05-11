import 'package:flutter/material.dart';
import 'package:games_wiki/pages/creators_screen/creators_page.dart';
import 'package:games_wiki/pages/home_screen/games_page.dart';

class NavigationBarController extends StatefulWidget {
  const NavigationBarController({super.key});

  @override
  State<NavigationBarController> createState() => _NavigationBarControllerState();
}

class _NavigationBarControllerState extends State<NavigationBarController> {
  int selectedItem = 0;
  Widget bodyController(int selectedpage){
    if(selectedpage == 0){
      return GamesPage.create();
    }else {
      return CreatorsPage.create();
    }
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
      body: bodyController(selectedItem),
      bottomNavigationBar: BottomNavigationBar(currentIndex: selectedItem,
      backgroundColor: const Color.fromRGBO(12, 74, 110, 1.0),
      fixedColor: Colors.white,
      items:const[
        BottomNavigationBarItem(
          icon: Icon(Icons.home,),
          label: 'Home',
        ),
          BottomNavigationBarItem(
          icon:  Icon(Icons.person),
          label: 'Carrinho',
          backgroundColor: Colors.white
        ),
      ],
      onTap: (value){
        setState(() {
          selectedItem = value;
        });
      },),
      ),
    );
  }
}