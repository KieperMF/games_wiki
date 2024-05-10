import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:games_wiki/core/inject.dart';
import 'package:games_wiki/pages/game_screen/game_page_store.dart';
import 'package:games_wiki/services/game_service.dart';
import 'package:provider/provider.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => GamePageStore(service: inject<GameService>()),
      child: const GamePage(),
    );
  }

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  GamePageStore? gamePageStore;
  bool _isLoading = true;
  int length = 0;

  @override
  void initState() {
    gamePageStore = context.read();
    _load();
    super.initState();
  }

  _load() async {
    await gamePageStore!.getGameScreenShots(gameSelected.id);
    setState(() {
      length = gamePageStore!.screenshots!.length;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    gamePageStore = context.watch();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Game Page'),
        ),
        backgroundColor: Colors.grey,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: 200,
                    child: Image.network("${gameSelected.backgroundImage}")),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${gameSelected.name}',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Metacritic: ${gameSelected.rating}',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Avalable Plataforms:',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                for (String plataform in gameSelected.plataformNames!) ...[
                  Text(plataform,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
                
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Game Screenshots",
                          style: TextStyle(fontSize: 22, color: Colors.black),
                        ))),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              _isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.red,
                                    )
                                  : gamePageStore!.screenshots!.isNotEmpty
                                      ? Container(
                                          height: 180,
                                          width: 320,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.white)),
                                          child: Image.network(
                                            gamePageStore!.screenshots![index],
                                            height: 170,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.image,
                                          size: 180,
                                        ),
                            ],
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 300,
                  child: Text(
                    '${gameSelected.requirementsRecommended}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const Divider(color: Colors.black,),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 300,
                  child: Text(
                    '${gameSelected.requirementsMinimum}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
