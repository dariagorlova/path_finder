import 'package:flutter/material.dart';
import 'package:path_finder/features/preview/presentation/preview_screen.dart';
import 'package:path_finder/features/process/domain/model/result_model.dart';

class ResultListScreen extends StatelessWidget {
  const ResultListScreen({
    required this.data,
    super.key,
  });

  final List<ResultModel> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result list screen'),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: data.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PreviewScreen(data: data[index]),
              ),
            );
          },
          title: Text(
            data[index].steps.map((e) => e.toString()).toList().join('->'),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
