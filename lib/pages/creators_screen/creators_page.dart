import 'package:flutter/material.dart';
import 'package:games_wiki/core/inject.dart';
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
  bool _isLoading = true;

  @override
  void initState() {
    creatorStore = context.read();
    _load();
    super.initState();
  }

  _load() async {
    await creatorStore!.getCreators();
    setState(() {
      _isLoading = false;
    });
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
              children: [
                _isLoading ? const CircularProgressIndicator(color: Colors.red,) :
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics:const BouncingScrollPhysics(),
                      itemCount: creatorStore!.creators.length,
                      itemBuilder: (context, index){
                        return Column(
                          children: [
                            SizedBox(
                              height: 150,
                              child: Image.network("${creatorStore!.creators[index].image}"),
                            ),
                            Text("${creatorStore!.creators[index].name}"),
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
