import 'package:flutter/material.dart';
import 'package:persistence1/helpers/database_helper.dart';
import 'package:persistence1/models/cat_model.dart';

import '../widgets/custom_item_widget.dart';

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
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            TextFormField(controller: textControllerRace, decoration: const InputDecoration(
              icon: Icon(Icons.view_comfortable),
              labelText: "Input the Race"
   
            ),),
            TextFormField(controller: textControllerName, decoration: const InputDecoration(
              icon: Icon(Icons.text_format_outlined),
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
                  return Center(
                    child:  Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: const Text('Loading...')
                    )
                  );
                }
                else {
                  return snapshot.data!.isEmpty
                  ? Center(child: Container(padding: const EdgeInsets.only(top: 10.0), child: const Text('No cats in the list')))
                  : ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: snapshot.data!.map((cat) {
                      return Center(
                        child: CustomItem(cat: cat)
                      );
                    }).toList(),
                  );
                }
              },
            )
          ),
        ),
        ]),
      ),
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