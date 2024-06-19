import 'package:flutter/material.dart';
import 'package:games_wiki/core/inject.dart';
import 'package:games_wiki/pages/game_screen/game_page_store.dart';
import 'package:games_wiki/services/game_service.dart';
import 'package:provider/provider.dart';
import 'package:widget_zoom/widget_zoom.dart';

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
    await gamePageStore!.getAchievements();
    await gamePageStore!.getReleatedGames();
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
          title: const Text(
            'Game Details',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          backgroundColor: const Color.fromRGBO(38, 38, 38, 1),
        ),
        backgroundColor: const Color.fromRGBO(23, 23, 23, 1),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: _isLoading
                            ? Center(
                                child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: Colors.grey),
                                child: const Icon(
                                  Icons.image,
                                  color: Colors.white,
                                  size: 90,
                                ),
                              ))
                            : Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 1.5)),
                                child: Opacity(
                                  opacity: 0.7,
                                  child: Image.network(
                                    cacheWidth: 480,
                                    gamePageStore!.screenshots!.last,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.error,
                                        color: Colors.white,
                                        size: 150,
                                      );
                                    },
                                  ),
                                ),
                              )),
                    Padding(
                      padding: const EdgeInsets.only(top: 130),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                            height: 130,
                            width: 300,
                            child: WidgetZoom(
                              heroAnimationTag: 'game',
                              zoomWidget: Image.network(
                                cacheWidth: 480,
                                "${gameSelected.backgroundImage}",
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
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        '${gameSelected.name}',
                        style:
                            const TextStyle(fontSize: 22, color: Colors.white),
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
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: gameSelected.genres!.length,
                      itemBuilder: (context, index) {
                        return Row(children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              gameSelected.genres![index],
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ]);
                      }),
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: gameSelected.plataformNames!.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                gameSelected.plataformNames![index],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Screenshots",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ))),
                length > 0
                    ? Column(
                        children: [
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
                                            : gamePageStore!
                                                    .screenshots!.isNotEmpty
                                                ? Container(
                                                    height: 180,
                                                    width: 320,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.white)),
                                                    child: WidgetZoom(
                                                      heroAnimationTag:
                                                          '$index',
                                                      zoomWidget: Image.network(
                                                        loadingBuilder: (context,
                                                            child,
                                                            loadingProgress) {
                                                          if (loadingProgress ==
                                                              null) {
                                                            return child;
                                                          } else {
                                                            return const Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        cacheWidth: 600,
                                                        gamePageStore!
                                                                .screenshots![
                                                            index],
                                                        height: 170,
                                                      ),
                                                    ),
                                                  )
                                                : const Icon(
                                                    Icons.image,
                                                    color: Colors.grey,
                                                    size: 180,
                                                  ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ],
                      )
                    : SizedBox(
                        height: 200,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Container(
                                        height: 180,
                                        width: 320,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            border: Border.all(
                                                color: Colors.white)),
                                        child: const Icon(
                                          Icons.image_not_supported_rounded,
                                          size: 50,
                                        ))
                                  ],
                                ),
                              );
                            }),
                      ),
                gameSelected.achievementImage != null
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Achievements",
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.white),
                                  ))),
                          const SizedBox(
                            height: 10,
                          ),
                          GridView.builder(
                              itemCount: gameSelected.achievementName!.length,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                        color: Colors.grey,
                                      )),
                                      width: 140,
                                      height: 140,
                                      child: Image.network(
                                          cacheWidth: 400,
                                          gameSelected
                                              .achievementImage![index]),
                                    ),
                                    SizedBox(
                                        width: 140,
                                        height: 60,
                                        child: Text(
                                          gameSelected.achievementName![index],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        )),
                                  ],
                                );
                              })
                        ],
                      )
                    : const Text(''),
                const SizedBox(
                  height: 10,
                ),
                gamePageStore!.releatedGames.isNotEmpty
                    ? Column(
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Releated Games",
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.white),
                                  ))),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 270,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemCount: gamePageStore!.releatedGames.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          height: 130,
                                          width: 250,
                                          child: Image.network(
                                            cacheWidth: 480,
                                            "${gamePageStore!.releatedGames[index].backgroundImage}",
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
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: SizedBox(
                                          width: 230,
                                          child: Text(
                                            '${gamePageStore!.releatedGames[index].name}',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      )
                                    ]),
                                  );
                                }),
                          ),
                        ],
                      )
                    : const Text(''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
