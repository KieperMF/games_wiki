import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:games_wiki/core/inject.dart';
import 'package:games_wiki/pages/game_screen/game_page.dart';
import 'package:games_wiki/pages/game_screen/game_page_store.dart';
import 'package:games_wiki/services/game_service.dart';
import 'package:provider/provider.dart';
import 'package:widget_zoom/widget_zoom.dart';

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
        backgroundColor: const Color.fromRGBO(23, 23, 23, 1),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Top Games',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  height: 10,
                ),
                CarouselSlider.builder(
                    itemCount: 7,
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) {
                      return Container(
                          width: 320,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: WidgetZoom(
                              heroAnimationTag: '$itemIndex',
                              zoomWidget:
                                  Image.asset('lib/assets/$itemIndex.jpg')));
                    },
                    options: CarouselOptions(
                        height: 180,
                        autoPlayCurve: Curves.easeInOut,
                        autoPlay: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 1500))),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'All Games',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  height: 10,
                ),
                store!.games.isEmpty
                    ? IconButton(
                        onPressed: () {
                          _load();
                        },
                        icon: const Icon(Icons.refresh))
                    : GridView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: store!.games.length,
                        itemBuilder: (context, index) {
                          return TextButton(
                            onPressed: () {
                              gameSelected = store!.games[index];
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GamePage.create()));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: SizedBox(
                                //height: 180,
                                child: Stack(
                                  children: [
                                    Image.network(
                                      cacheHeight: 500,
                                      cacheWidth: 470,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return const Center(
                                              child: Icon(
                                            Icons.image,
                                            size: 100,
                                            color: Colors.white,
                                          ));
                                        }
                                      },
                                      '${store!.games[index].backgroundImage}',
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(
                                          Icons.image_not_supported_rounded,
                                          size: 140,
                                        );
                                      },
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                          height: 50,
                                          decoration: const BoxDecoration(
                                            color: Color.fromRGBO(
                                                113, 113, 122, 0.5),
                                          ),
                                          width: 200,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "${store!.games[index].name}",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          )),
                                    )
                                    /*ElevatedButton(
                                                style: const ButtonStyle(
                                                    backgroundColor: WidgetStatePropertyAll(
                                                        Color.fromRGBO(38, 38, 38, 1))),
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
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(64),
                                                        child: Image.network(
                                                          cacheWidth: 400,
                                                          loadingBuilder: (context, child,
                                                              loadingProgress) {
                                                            if (loadingProgress == null) {
                                                              return child;
                                                            } else {
                                                              return const Center(
                                                                  child: Icon(
                                                                Icons.image,
                                                                size: 100,
                                                                color: Colors.white,
                                                              ));
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
                                                        ),
                                                      )),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  /*SizedBox(
                                                      width: 120,
                                                      child: Text(
                                                        "${store!.games[index].name}",
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                      ))*/
                                                ]),
                                              ),*/
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    store!.previousPage != null
                        ? IconButton(
                            onPressed: () {
                              store!.getGamesPreviousPage();
                            },
                            icon: const Icon(
                              Icons.arrow_circle_left_rounded,
                              size: 36,
                              color: Colors.white,
                            ))
                        : const Text(''),
                    const SizedBox(
                      width: 20,
                    ),
                    nextGamePage != null
                        ? IconButton(
                            onPressed: () async {
                              await store!.getGamesNextPage();
                            },
                            icon: const Icon(
                              Icons.arrow_circle_right_rounded,
                              size: 36,
                              color: Colors.white,
                            ))
                        : const Text(''),
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
