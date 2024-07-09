import 'package:flutter_riverpod/flutter_riverpod.dart';

class IsReadNotifier extends StateNotifier<List<int>> {
  IsReadNotifier() : super([0, 1, 4, 6, 7, 9]);

  // remove the index from the list
  void remove(int index) {
    state = state.where((element) => element != index).toList();
  }
}

final isReadProvider =
    AutoDisposeStateNotifierProvider<IsReadNotifier, List<int>>(
  (ref) => IsReadNotifier(),
);
