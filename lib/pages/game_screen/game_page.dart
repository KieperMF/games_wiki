import 'package:flutter/material.dart';
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

  void disposePage(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    gamePageStore = context.watch();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Game Details',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(8, 47, 73, 1),
        ),
        backgroundColor: const Color.fromRGBO(8, 47, 73, 1),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: _isLoading
                            ? const Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Center(
                                    child: Icon(Icons.image)),
                              )
                            : Opacity(
                                opacity: 0.7,
                                child: Image.network(
                                  cacheWidth: 480,
                                  gamePageStore!.screenshots!.last,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.error,
                                      size: 150,
                                    );
                                  },
                                ),
                              )),
                    Padding(
                      padding: const EdgeInsets.only(top: 130),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                            height: 130,
                            child: Image.network(loadingBuilder:
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
                            cacheWidth: 480,
                            "${gameSelected.backgroundImage}")),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 380,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        '${gameSelected.name}',
                        style: const TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Metacritic: ${gameSelected.rating}',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(children: [
                  for (int i = 0; i < gameSelected.genres!.length; i++) ...[
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          gameSelected.genres![i],
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ]),
                const SizedBox(
                  height: 10,
                ),
                Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Avalable Plataforms:',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        for (String plataform
                            in gameSelected.plataformNames!) ...[
                          Text(
                            plataform,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ],
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                const SizedBox(
                  width: 10,
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Game Screenshots",
                          style: TextStyle(fontSize: 22, color: Colors.white),
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
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.red,
                                                  ),
                                                );
                                              }
                                            },
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
