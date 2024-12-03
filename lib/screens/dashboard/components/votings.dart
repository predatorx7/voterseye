import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListVotesSliver extends StatelessWidget {
  const ListVotesSliver({super.key});

  @override
  Widget build(BuildContext context) {
    final topicsCollectionSnapshot =
        FirebaseFirestore.instance.collection('topics').get();

    return StreamBuilder(
      stream: topicsCollectionSnapshot.asStream(),
      builder: (context, snapshot) {
        final topics = snapshot.data?.docs;
        if (topics == null) {
          return const SliverFillRemaining(
            child: Text('No topics found'),
          );
        }
        return SliverList.builder(
          itemCount: topics.length,
          itemBuilder: (context, index) {
            final topic = topics[index];
            return ListTile(
              title: Text(topic.data().toString()),
            );
          },
        );
      },
    );
  }
}
