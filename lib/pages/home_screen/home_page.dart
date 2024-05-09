import 'package:flutter/material.dart';
import 'package:games_wiki/core/inject.dart';
import 'package:games_wiki/pages/home_screen/home_page_store.dart';
import 'package:games_wiki/services/game_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => HomePageStore(service: inject<GameService>()),
      child: const HomePage(),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageStore? store;

  @override
  void initState() {
    store = context.read();
    _load();
    super.initState();
  }

  _load() async {
    store!.getGames();
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
                            Container(
                              decoration:const BoxDecoration(color: Colors.white),
                              child: store!.games[index].backgroundImage!.isNotEmpty ? SizedBox(
                                height: 150,
                                width: 200,
                                child: Image.network(
                                    '${store!.games[index].backgroundImage}')) : const Icon(Icons.image),
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
