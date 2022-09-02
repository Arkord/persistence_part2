import 'package:flutter/material.dart';
import 'package:persistence1/helpers/database_helper.dart';
import 'package:persistence1/models/cat_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final textControllerRace = TextEditingController();
    final textControllerName = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite Database"),
        elevation: 0,
      ),
      body: Stack(
        children: [
          TextFormField(controller: textControllerRace, decoration: const InputDecoration(
            labelText: "Input the Race"
   
          ),),
          TextFormField(controller: textControllerName, decoration: const InputDecoration(
            labelText: "Input Name"
            
          ),),
          Center (
          child: (
          // Container(
          //   child: const Text('Main content'),
          // )
          FutureBuilder<List<Cat>>(
            future: DatabaseHelper.instance.getCats(),
            builder: (BuildContext context, AsyncSnapshot<List<Cat>> snapshot) {
              if(!snapshot.hasData) {
                return const Center(child:  Text('Loading...'));
              }
              else {
                return snapshot.data!.isEmpty
                ? const Center(child: Text('No cats in the list'))
                : ListView(
                  children: snapshot.data!.map((cat) {
                    return Center(
                      child: ListTile(
                        title: Text(cat.name),
                      ),
                    );
                  }).toList(),
                );
              }
            },
          )
        ),
      ),
      ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async {
          await DatabaseHelper.instance.add(
            Cat(race: textControllerRace.text, name: textControllerName.text)
          );
          setState(() {
            textControllerRace.clear();
            textControllerName.clear();
          });
        },
      ),
    );
  }
}