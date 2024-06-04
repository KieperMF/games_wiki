import 'package:flutter/material.dart';
import 'package:games_wiki/pages/creators_screen/creators_page.dart';
import 'package:games_wiki/pages/game_screen/games_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavigationBarController extends StatefulWidget {
  const NavigationBarController({super.key});

  @override
  State<NavigationBarController> createState() =>
      _NavigationBarControllerState();
}

class _NavigationBarControllerState extends State<NavigationBarController> {
  int _selectedItem = 0;
  Widget bodyController(int selectedpage) {
    if (selectedpage == 0) {
      return GamesPage.create();
    } else {
      return CreatorsPage.create();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(38, 38, 38, 0.1), 
          body: IndexedStack(
            index: _selectedItem, children: [
              GamesPage.create(),
              CreatorsPage.create()
            ],
          ),
          bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Color.fromRGBO(38, 38, 38, 1)
                ),
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: GNav(
                    curve: Curves.easeInOut,
                    gap: 8,
                    activeColor: const Color.fromRGBO(10, 10, 10, 1),
                    iconSize: 24,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    duration: const Duration(milliseconds: 600),
                    tabBackgroundColor: Colors.white,
                    color: Colors.black,
                    tabs: const  [
                      GButton(
                        icon: Icons.videogame_asset_rounded,
                        iconColor: Colors.white,
                        text: 'Games',
                      ),
                       GButton(
                        icon: Icons.person,
                        iconColor: Colors.white,
                        text: 'Creators',
                      ),
                    ],
                    selectedIndex: _selectedItem,
                    onTabChange: (index) {
                      setState(() {
                        _selectedItem = index;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
    );
  }
  
}