import 'package:flutter/material.dart';
import 'package:games_wiki/core/inject.dart';
import 'package:games_wiki/pages/game_screen/game_page.dart';
import 'package:games_wiki/pages/game_screen/game_page_store.dart';
import 'package:games_wiki/services/game_service.dart';
import 'package:provider/provider.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => GamePageStore(service: inject<GameService>()),
      child: const GamesPage(),
    );
  }

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  GamePageStore? store;

  @override
  void initState() {
    store = context.read();
    _load();
    super.initState();
  }

  _load() async {
    await store!.getGames();
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: store!.games.length,
                      itemBuilder: (context, index) {
                        return Column( 
                          children: [
                            ElevatedButton(
                              onPressed: (){
                                gameSelected = store!.games[index];
                                Navigator.push(context, MaterialPageRoute(builder: (context) => GamePage.create()));
                              },
                              child: Container(
                                decoration:const BoxDecoration(color: Colors.white),
                                child: store!.games[index].backgroundImage!.isNotEmpty ? SizedBox(
                                  height: 150,
                                  width: 200,
                                  child: Image.network(
                                      '${store!.games[index].backgroundImage}')) : const Icon(Icons.image),
                              ),
                            ),
                            const SizedBox(height: 10,)
                          ],
                        );
                      }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
