import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gamexplore/global.dart';
import 'package:gamexplore/model_injuries.dart';
import 'package:gamexplore/you_tube_player.dart';

class CommonInjuriesPage extends StatelessWidget {
  Stream<QuerySnapshot> getInjuryStreamBySport(String sport) {
    try {
      var query = FirebaseFirestore.instance
          .collection('/injuries')
          .where('sport', isEqualTo: sport);
      var stream = query.snapshots();
      debugPrint("Stream created successfully");
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
        title: Text('Common Injuries of ' + global.sport_name.toUpperCase()),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Add detailed content for common injuries
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: getInjuryStreamBySport(global.sport_name),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData) {
                    debugPrint("No data Found");
                    return Center(child: Text('No Data'));
                  }
                  debugPrint("Total Records=" + snapshot.data!.size.toString());
                  final List<Injury> injuryList =
                      snapshot.data!.docs.map((doc) {
                    debugPrint("In record function");
                    return Injury(
                      sport: doc['sport'],
                      title: doc['title'],
                      description: doc['description'],
                      link: "NA",
                      videoLink: doc['videoLink'],
                    );
                  }).toList();
                  return ListView.builder(
                    itemCount: injuryList.length,
                    itemBuilder: (context, index) {
                      final injury = injuryList[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: RichText(
                            text: TextSpan(
                              text: injury.title + '\n',
                              style: TextStyle(
                                fontSize: 18,
                                color: const Color.fromARGB(255, 159, 59, 59),
                                fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      '${injury.description.replaceAll('\\n', '\n')}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.lightBlueAccent,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: '\n See Video',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      global.injuriesVideoLink =
                                          injury.videoLink;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              YoutubePlayerDemoApp(),
                                        ),
                                      );
                                    },
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blueAccent,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
