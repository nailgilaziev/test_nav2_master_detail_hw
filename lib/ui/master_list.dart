import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_text_controller/data.dart';

class MasterList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final users = watch(usersProvider);
    final selected = watch(selectedUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Master'),
        actions: [
          IconButton(
            tooltip: 'unselect item',
            icon: const Icon(Icons.tab_unselected),
            onPressed: () {
              print('unselect');
              context.read(selectedStateProvider).state = null;
            },
          ),
        ],
      ),
      body: ListView(
          children: users
              .map((e) => ListTile(
                    selected: e.id == selected?.id,
                    title: Text(e.name),
                    subtitle: Text('${e.id}'),
                    onTap: () {
                      print('select ${e.id}');
                      context.read(selectedStateProvider).state = e.id;
                    },
                  ))
              .toList()),
    );
  }
}
