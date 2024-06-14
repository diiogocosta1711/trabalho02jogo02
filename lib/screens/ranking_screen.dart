import 'package:flutter/material.dart';
import 'package:jogo/services/db_service.dart';

class RankingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Top Scores')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DBService.instance.getTopScores(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final scores = snapshot.data!;
          return ListView.builder(
            itemCount: scores.length,
            itemBuilder: (context, index) {
              final score = scores[index];
              return ListTile(
                title: Text('User ID: ${score['userId']}'),
                subtitle: Text('Score: ${score['score']}'),
              );
            },
          );
        },
      ),
    );
  }
}
