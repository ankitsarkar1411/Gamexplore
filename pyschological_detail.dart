import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamexplore/global.dart';
import 'package:gamexplore/model_pyschological.dart';

class PsychologicalDetailPage extends StatelessWidget {
  Stream<QuerySnapshot> getPyschologicalStreamBySport(String sport) {
    try {
      var query = FirebaseFirestore.instance
          .collection('/pyschological')
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
        title: Text('Psychology of ' + global.sport_name.toUpperCase()),
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
                stream: getPyschologicalStreamBySport(global.sport_name),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final List<Pyschological> pyschologicalList =
                      snapshot.data!.docs.map((doc) {
                    debugPrint("In record function");
                    String sport = doc['sport'] ?? 'Unknown Sport';
                    String title = doc['title'] ?? 'Untitled';
                    String description = '';
                    try {
                      description = doc['description'] ?? 'No Description';
                    } catch (e) {
                      description = 'error';
                    }

                    return Pyschological(
                      sport: sport,
                      title: title,
                      description: description,
                    );
                  }).toList();

                  return ListView.builder(
                    itemCount: pyschologicalList.length,
                    itemBuilder: (context, index) {
                      final pyschological = pyschologicalList[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: RichText(
                              text: TextSpan(
                                  text: pyschological.title + '\n',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color:
                                        const Color.fromARGB(255, 59, 59, 159),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: <TextSpan>[
                                TextSpan(
                                  text:
                                      '${pyschological.description.replaceAll('\\n', '\n')}',
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
