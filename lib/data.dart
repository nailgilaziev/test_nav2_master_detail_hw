import 'package:riverpod/riverpod.dart';

class User {
  int id;
  String name;
  bool active;

  User(this.id, this.name, {this.active = true});
}

final selectedStateProvider = StateProvider<int?>((ref) => null);

final selectedUserProvider = Provider<User?>((ref) {
  final users = ref.watch(usersProvider);
  final id = ref.watch(selectedStateProvider).state;
  return id == null ? null : users.firstWhere((e) => e.id == id);
});

final usersProvider = Provider((ref) => [
      User(1, 'name1'),
      User(2, 'name2'),
      User(3, 'name3'),
    ]);
