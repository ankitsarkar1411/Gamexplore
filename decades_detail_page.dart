import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamexplore/global.dart';
import 'package:gamexplore/model_history.dart';

class DecadeDetailPage extends StatelessWidget {
  final String decade;

  DecadeDetailPage({required this.decade});

  Stream<QuerySnapshot> getHistoryStreamBySport(String sport) {
    try {
      var query = FirebaseFirestore.instance
          .collection('/history')
          .where('sport', isEqualTo: sport)
          .where('decade', isEqualTo: decade);
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
        title: Text('History'),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: getHistoryStreamBySport(global.sport_name),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final List<History> historyList =
                      snapshot.data!.docs.map((doc) {
                    debugPrint("In record function");
                    return History(
                      sport: doc['sport'],
                      decade: doc['decade'],
                      description: doc['description'],
                    );
                  }).toList();

                  return ListView.builder(
                    itemCount: historyList.length,
                    itemBuilder: (context, index) {
                      final history = historyList[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: RichText(
                              text: TextSpan(
                                  text: history.sport.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 24,
                                    color:
                                        const Color.fromARGB(255, 59, 59, 59),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: <TextSpan>[
                                TextSpan(
                                  text: '\n\nDecade: ${history.decade}\n\n',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Highlights: \n ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blueAccent,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${history.description.replaceAll('\\n', '\n')}',
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
