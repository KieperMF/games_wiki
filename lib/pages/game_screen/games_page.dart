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
                store!.games.isEmpty ? IconButton(onPressed: (){
                  _load();
                }, icon: const Icon(Icons.refresh)) :
                ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemCount: store!.games.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 150,
                              width: 380,
                              child: ElevatedButton(
                                onPressed: () {
                                  gameSelected = store!.games[index];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              GamePage.create()));
                                },
                                child: Row(children: [
                                  SizedBox(
                                      height: 110,
                                      width: 160,
                                      child: Image.network(
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.red,
                                              ),
                                            );
                                          }
                                        },
                                        '${store!.games[index].backgroundImage}',
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(
                                            Icons.image,
                                            size: 140,
                                          );
                                        },
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                      width: 100,
                                      child: Text(
                                        "${store!.games[index].name}",
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ))
                                ]),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       nextGamePage != null ?
                    TextButton(onPressed: (){
                      store!.getGamesNextPage();
                      setState(() {});
                    }, child: const Text('Load More')) : const Text(''),
                    const SizedBox(width: 20,),
                    store!.previousPage != null ?
                    TextButton(onPressed: (){
                      store!.getGamesPreviousPage();
                    }, child: const Text('Less')) : const Text(''),
                    ],
                   )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
