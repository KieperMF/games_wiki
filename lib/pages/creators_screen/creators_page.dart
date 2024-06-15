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
        backgroundColor: const Color.fromRGBO(23, 23, 23, 1),
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
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(38, 38, 38, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                width: 159,
                                child: Column(children: [
                                  TextButton(
                                    onPressed: () {
                                      creatorSelected =
                                          creatorStore!.creators[index];
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreatorPage.create()));
                                    },
                                    child: SizedBox(
                                      height: 140,
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
                                                color: Colors.grey,
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
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ]),
                              ),
                            ],
                          );
                        }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    previousCreatorsPage != null
                        ? IconButton(
                            onPressed: () {
                              creatorStore!.getCreatorsPreviousPage();
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
                    nextCreatorsPage != null
                        ? IconButton(
                            onPressed: () async {
                              await creatorStore!.getCreatorsNextPage();
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