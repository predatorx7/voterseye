import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:voterseye/serializers.dart';

class ListVotesSliver extends StatelessWidget {
  const ListVotesSliver({super.key});

  @override
  Widget build(BuildContext context) {
    final topicsCollectionSnapshot =
        FirebaseFirestore.instance.collection('topics').snapshots();

    return StreamBuilder(
      stream: topicsCollectionSnapshot,
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
            final data = topic.data();
            return VotingTopicListTile(data: data);
          },
        );
      },
    );
  }
}

class VotingTopicListTile extends StatefulWidget {
  const VotingTopicListTile({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  State<VotingTopicListTile> createState() => _VotingTopicListTileState();
}

class _VotingTopicListTileState extends State<VotingTopicListTile> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final List options = widget.data['options'] ?? [];

    return ExpansionTile(
      title: Text(
        widget.data['label'] ?? '-',
        style: textTheme.titleLarge,
      ),
      subtitle: Text(
        widget.data['description'] ?? '-',
        style: textTheme.bodyLarge,
      ),
      initiallyExpanded: true,
      children: List.generate(
        options.length,
        (index) {
          final DocumentReference option = options[index];

          return StreamBuilder(
            stream: option.snapshots(),
            builder: (context, snapshot) {
              final snapdata = snapshot.data;
              if (snapdata == null) return SizedBox();
              final Map value = snapdata.data() as Map;
              return ListTile(
                title: Text(
                  value['label'] ?? '-',
                  style: textTheme.bodyLarge,
                ),
                leading: Icon(Icons.radio_button_off),
              );
            },
          );
        },
      ),
    );
  }
}
