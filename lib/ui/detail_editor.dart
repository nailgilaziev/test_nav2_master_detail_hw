import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_text_controller/data.dart';

class DetailEditor extends StatefulWidget {
  const DetailEditor({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailEditorState();
  }
}

class _DetailEditorState extends State<DetailEditor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
        ),
        body: Consumer(builder: (BuildContext context, watch, Widget? child) {
          final selectedUser = watch(selectedUserProvider);
          return Column(
            children: [
              Text('id ${selectedUser?.id}'),
              Text('name ${selectedUser?.name}'),
              TextField(
                controller: name,
              ),
              SwitchListTile(
                  value: active, onChanged: (v) => setState(() => active = v)),
            ]
                .map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: e,
                    ))
                .toList(),
          );
        }));
  }

  late final TextEditingController name;
  late bool active;

  @override
  void initState() {
    final selectedUser = context.read(selectedUserProvider);
    name = TextEditingController(text: selectedUser?.name);
    active = selectedUser?.active ?? true;
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }
}
