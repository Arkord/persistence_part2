import 'package:flutter/material.dart';
import 'package:persistence1/helpers/database_helper.dart';
import 'package:persistence1/models/cat_model.dart';
import 'package:persistence1/widgets/cats_list_widget.dart';

import '../widgets/custom_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? catId;
    final textControllerRace = TextEditingController();
    final textControllerName = TextEditingController();
    
  @override
  Widget build(BuildContext context) {
    
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
                        child: ListTile(
                        title: Text('Race: ${cat.race} | Name: ${cat.name} '),
                        onTap: () {
                          setState(() {
                            textControllerName.text = cat.name;
                            textControllerRace.text = cat.race;
                            catId = cat.id;
                          });
                        },
                        onLongPress: () {
                          setState(() {
                            DatabaseHelper.instance.delete(cat.id!);
                          });
                        },
                      )
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
          if(catId != null) {
            await DatabaseHelper.instance.update(
              Cat(id: catId, race: textControllerRace.text, name: textControllerName.text)
            );
          }
          else {
            await DatabaseHelper.instance.add(
              Cat(race: textControllerRace.text, name: textControllerName.text)
            );
          }
          
          setState(() {
            textControllerRace.clear();
            textControllerName.clear();
          });
        },
      ),
    );
  }
}