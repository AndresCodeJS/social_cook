import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  List<String> lista = ["Queso", "Huevos", "Tocino"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.black,
              title: const Text("DETAILS"),
              expandedHeight: 320,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: const AssetImage("assets/pokemon.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.dstATop)),
                ),
              ),
              pinned: true,
              bottom: const TabBar(indicatorWeight: 4, tabs: [
                Tab(child: Text("Ingredientes")),
                Tab(
                  child: Text("Preparación"),
                )
              ]),
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.favorite),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.help),
                  onPressed: () {},
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            )
          ];
        },
        body: TabBarView(children: [
          ListView(children: [
            const Text("Ingredientes"),
            Column(
                children: List.generate(
                    lista.length,
                    (int index) => ListTile(
                          title: Text(lista[index]),
                          leading: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).primaryColor),
                            height: 15,
                            width: 15,
                          ),
                        )))
          ]),
          const Text("Pantalla 2")
        ]),
      ),
    ));
  }
}
