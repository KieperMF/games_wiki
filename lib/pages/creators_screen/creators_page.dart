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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Creators"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              _isLoading ? CircularProgressIndicator() :
              SizedBox(
                height: 300,
                width: 200,
                child: ListView.builder(
                  itemCount: creatorStore!.creators.length,
                  itemBuilder: (context, index){
                    return Column(
                      children: [
                        Text("${creatorStore!.creators[index].name}")
                      ],
                    );
                  }),
              )
            ],
          ),
        ),
      )),
    );
  }
}
