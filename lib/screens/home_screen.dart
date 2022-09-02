import 'package:flutter/material.dart';
import 'package:persistence1/helpers/database_helper.dart';
import 'package:persistence1/models/cat_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite Database"),
        elevation: 0,
      ),
      body: Center(
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
    );
  }
}