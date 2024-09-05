import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:okra_distributer/bloc/fetchdataaBloc/fectDataState.dart';
import 'package:okra_distributer/bloc/fetchdataaBloc/fetchDataBloc.dart';
import 'package:okra_distributer/bloc/fetchdataaBloc/fetchdataevent.dart';

class CompletionScreen extends StatefulWidget {
  @override
  State<CompletionScreen> createState() => _CompletionScreenState();
}

class _CompletionScreenState extends State<CompletionScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompletionBloc()..add(FetchData()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Completion Screen'),
        ),
        body: BlocBuilder<CompletionBloc, CompletionState>(
          builder: (context, state) {
            if (state is InitialState) {
              return const Center(child: Text("Initializing..."));
            } else if (state is LoadingState) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(value: state.progress),
                      const SizedBox(height: 20),
                      Text(
                        "${(state.progress * 100).toStringAsFixed(0)}% Completed",
                        style: const TextStyle(fontSize: 18),
                      ),
                      ...state.taskStatuses.map((taskStatus) {
                        return ListTile(
                          title: Text(taskStatus.name),
                          subtitle: Text("Status: ${taskStatus.status}"),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              );
            } else if (state is SuccessState) {
              return const Center(
                  child: Text("All tasks completed successfully!"));
            } else if (state is FailureState) {
              return Center(child: Text("Error: ${state.error}"));
            } else {
              return const Center(child: Text("Unexpected state"));
            }
          },
        ),
      ),
    );
  }
}

class TaskStatus {
  final String name;
  String status;

  TaskStatus({required this.name, required this.status});
}
