import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:persistence1/helpers/database_helper.dart';
import 'package:persistence1/models/cat_model.dart';
import 'package:persistence1/screens/taken_picture_screen.dart';

class HomeScreen extends StatefulWidget {
  final CameraDescription camera;

  const HomeScreen({Key? key, required this.camera}) : super(key: key);

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
            ElevatedButton(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(
                      camera: widget.camera,
                      id: catId,
                    ),
                  ),
                );
              },
              style:  ElevatedButton.styleFrom(
                primary: const Color(0xFFFFC107)
              ),
              child: const Text('Take Picture')
            ),
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
                        child: Card(
                          color: catId == cat.id ? const Color(0xB37600BA) : Colors.white,
                          child: Stack(
                            children: [ListTile(
                            textColor: catId == cat.id ? Colors.white : Colors.black,
                            title: Text('Race: ${cat.race} | Name: ${cat.name} '),
                            
                            onTap: () {
                              setState(() {
                                if(catId == null) {
                                  textControllerName.text = cat.name;
                                  textControllerRace.text = cat.race;
                                  catId = cat.id;
                                }
                                else {
                                  textControllerName.clear();
                                  textControllerRace.clear();
                                  catId = null;
                                }
                              });
                            },
                            onLongPress: () {
                              setState(() {
                                DatabaseHelper.instance.delete(cat.id!);
                              });
                            },
                            ),
                            Text(cat.image!)
                            ]
                                                
                          ),
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