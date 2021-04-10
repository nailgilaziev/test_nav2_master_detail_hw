import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_text_controller/data.dart';

class DetailEditorHW extends HookWidget {
  const DetailEditorHW({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedUser = useProvider(selectedUserProvider);
    final name = useTextEditingController(text: selectedUser?.name);
    final active = useState(selectedUser?.active ?? true);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
        ),
        body: Column(
          children: [
            Text('id ${selectedUser?.id}'),
            Text('name ${selectedUser?.name}'),
            TextField(
              controller: name,
            ),
            SwitchListTile(
                value: active.value, onChanged: (v) => active.value = v),
          ]
              .map((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: e,
                  ))
              .toList(),
        ));
  }
}
