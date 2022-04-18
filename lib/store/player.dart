import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notebox/utils/player/state.dart';

final playerProvider = StateNotifierProvider<PlayerController, PlayerState>(
    (ref) => PlayerController.instance());
