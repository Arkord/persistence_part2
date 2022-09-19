import 'package:flutter/material.dart';
import 'package:persistence1/widgets/custom_item_widget.dart';
import '../helpers/database_helper.dart';
import '../models/cat_model.dart';

class CatsList extends StatefulWidget {
  //final Future<List<Cat>> catsSource;
  const CatsList({Key? key}) : super(key: key);

  @override
  State<CatsList> createState() => _CatsListState();
}

class _CatsListState extends State<CatsList> {
  @override
  Widget build(BuildContext context) {
    Future<List<Cat>>source = DatabaseHelper.instance.getCats();
    
    return FutureBuilder<List<Cat>>(
              future: source,
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
            );
          
  }
}