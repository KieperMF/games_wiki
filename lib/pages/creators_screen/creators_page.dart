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
          title: const Text("Creators"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                creatorStore!.creators.isEmpty
                    ? IconButton(
                        onPressed: () {
                          _load();
                        },
                        icon: const Icon(Icons.refresh))
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemCount: creatorStore!.creators.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              SizedBox(
                                width: 380,
                                height: 170,
                                child: ElevatedButton(
                                  onPressed: () {
                                    creatorSelected =
                                        creatorStore!.creators[index];
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CreatorPage.create()));
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: SizedBox(
                                          height: 120,
                                          width: 100,
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
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "${creatorStore!.creators[index].name}",
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              )
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
