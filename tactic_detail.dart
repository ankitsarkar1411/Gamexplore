import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamexplore/global.dart';
import 'package:gamexplore/model_tactics.dart';

class TacticsDetailPage extends StatelessWidget {
  Stream<QuerySnapshot> getTacticStreamBySport(String sport) {
    try {
      var query = FirebaseFirestore.instance
          .collection('/tactics')
          .where('sport', isEqualTo: sport)
          .orderBy('title');
      var stream = query.snapshots();
      debugPrint("Stream created successfully ");
      return stream;
    } catch (e) {
      debugPrint("Error in query: $e");
      return Stream.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tactics of ' + global.sport_name.toUpperCase()),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: getTacticStreamBySport(global.sport_name),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final List<Tactic> tacticList =
                      snapshot.data!.docs.map((doc) {
                    debugPrint("In record function");
                    return Tactic(
                      sport: doc['sport'],
                      title: doc['title'],
                      description: doc['description'],
                    );
                  }).toList();

                  return ListView.builder(
                    itemCount: tacticList.length,
                    itemBuilder: (context, index) {
                      final tactic = tacticList[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: RichText(
                              text: TextSpan(
                                  text: tactic.title + '\n',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color:
                                        const Color.fromARGB(255, 59, 159, 59),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: <TextSpan>[
                                TextSpan(
                                  text:
                                      '${tactic.description.replaceAll('\\n', '\n')}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.lightBlueAccent,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ])),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
