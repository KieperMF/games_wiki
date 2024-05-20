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
          title: const Text(
            'Creator',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
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
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      '${creatorSelected!.name}',
                      style: const TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        const Text(
                          "Games Maded",
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        for (int i = 0;
                            i < creatorSelected!.gamesMaded!.length;
                            i++) ...[
                          Text(
                            creatorSelected!.gamesMaded![i],
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        const Text(
                          "Positions",
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        for (int i = 0;
                            i < creatorSelected!.positions!.length;
                            i++) ...[
                          Text(
                            creatorSelected!.positions![i],
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
