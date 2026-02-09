import 'package:flutter_riverpod/flutter_riverpod.dart';

final toggleSwitch = StateProvider<bool>((ref) => true);

class ToggleSwitch {
  final bool isToggle;

  ToggleSwitch({this.isToggle = false});

  ToggleSwitch copyWith({bool? isToggle}) {
    return ToggleSwitch(isToggle: isToggle ?? this.isToggle);
  }
}

final toggleProvider = StateNotifierProvider<ToggleProvider, ToggleSwitch>(
  (ref) => ToggleProvider(),
);

class ToggleProvider extends StateNotifier<ToggleSwitch> {
  ToggleProvider() : super(ToggleSwitch());

  Future<void> isToggle(bool value) async {
    state = state.copyWith(isToggle: !state.isToggle);
  }
}
