import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamexplore/global.dart';
import 'model_rules.dart';

class RulesDetailPage extends StatelessWidget {
  Stream<QuerySnapshot> getRuleStreamBySport(String sport) {
    try {
      var query = FirebaseFirestore.instance
          .collection('/rules')
          .where('sport', isEqualTo: sport)
          .orderBy('title');
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
        title: Text('Rules for ' + global.sport_name.toUpperCase()),
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
                stream: getRuleStreamBySport(global.sport_name),
                builder: (context, snapshot) {
                  // Check if there's an error
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'));
                  }

                  // Display loading spinner while waiting for data
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  // Check if snapshot has data and is not null
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                        child: Text('No rules found for this sport.'));
                  }

                  // Map Firestore documents to Rule objects with null checks
                  final List<Rule> ruleList = snapshot.data!.docs.map((doc) {
                    debugPrint("In record function");

                    // Use null checks for fields
                    String sport = doc['sport'] ?? 'Unknown Sport';
                    String title = doc['title'] ?? 'Untitled';
                    String description = doc['description'] ?? 'No Description';

                    return Rule(
                      sport: sport,
                      title: title,
                      description: description,
                    );
                  }).toList();

                  // Build list of rules
                  return ListView.builder(
                    itemCount: ruleList.length,
                    itemBuilder: (context, index) {
                      final rule = ruleList[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: RichText(
                            text: TextSpan(
                              text: rule.title + '\n',
                              style: TextStyle(
                                fontSize: 18,
                                color: const Color.fromARGB(255, 159, 59, 59),
                                fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      '${rule.description.replaceAll('\\n', '\n')}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.lightBlueAccent,
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
