import 'package:flutter/material.dart';
import 'package:games_wiki/core/inject.dart';
import 'package:games_wiki/pages/creators_screen/creator_page.dart';
import 'package:games_wiki/pages/creators_screen/creator_store.dart';
import 'package:games_wiki/services/creators_service.dart';
import 'package:provider/provider.dart';

class CreatorsPage extends StatefulWidget {
  const CreatorsPage({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => CreatorStore(service: inject<CreatorsService>()),
      child: const CreatorsPage(),
    );
  }

  @override
  State<CreatorsPage> createState() => _CreatorsPageState();
}

class _CreatorsPageState extends State<CreatorsPage> {
  CreatorStore? creatorStore;

  @override
  void initState() {
    creatorStore = context.read();
    _load();
    super.initState();
  }

  _load() async {
    await creatorStore!.getCreators();
  }

  @override
  Widget build(BuildContext context) {
    creatorStore = context.watch();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(100, 116, 139, 1),
          title: const Text("Creators", style: TextStyle(color: Colors.white),),
        ),
        backgroundColor: const Color.fromRGBO(71, 85, 105, 1),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                creatorStore!.creators.isEmpty
                    ? IconButton(
                        onPressed: () {
                          _load();
                        },
                        icon: const Icon(Icons.refresh))
                    : GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: creatorStore!.creators.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                decoration:
                                    const BoxDecoration(color: Color.fromRGBO(148, 163, 184, 1)),
                                width: 159,
                                child: Column(children: [
                                  TextButton(
                                    onPressed: () {
                                      creatorSelected =
                                          creatorStore!.creators[index];
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreatorPage.create()));
                                    },
                                    child: SizedBox(
                                      height: 150,
                                      child: Image.network(
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return const Center(
                                              child: Icon(
                                                Icons.image,
                                                size: 100,
                                                color: Colors.black,
                                              ),
                                            );
                                          }
                                        },
                                        cacheWidth: 400,
                                        "${creatorStore!.creators[index].image}",
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(
                                            Icons.error,
                                            size: 150,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${creatorStore!.creators[index].name}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ]),
                              ),
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
