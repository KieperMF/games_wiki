import 'package:flutter/material.dart';
import 'package:games_wiki/core/inject.dart';
import 'package:games_wiki/pages/creators_screen/creator_store.dart';
import 'package:games_wiki/services/creators_service.dart';
import 'package:provider/provider.dart';

class CreatorPage extends StatefulWidget {
  const CreatorPage({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => CreatorStore(service: inject<CreatorsService>()),
      child: const CreatorPage(),
    );
  }

  @override
  State<CreatorPage> createState() => _CreatorPageState();
}

class _CreatorPageState extends State<CreatorPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Creator'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Opacity(
                          opacity: 0.7,
                          child: Image.network(
                            '${creatorSelected!.backgroundImage}',
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 120),
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            height: 150,
                            child: Image.network('${creatorSelected!.image}')),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '${creatorSelected!.name}',
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Games Maded",
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 5,
                ),
                for (int i = 0;
                    i < creatorSelected!.gamesMaded!.length;
                    i++) ...[
                  Text(
                    creatorSelected!.gamesMaded![i],
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Positions",
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 5,
                ),
                for (int i = 0;
                    i < creatorSelected!.positions!.length;
                    i++) ...[
                  Text(
                    creatorSelected!.positions![i],
                    style: const TextStyle(fontSize: 20),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
