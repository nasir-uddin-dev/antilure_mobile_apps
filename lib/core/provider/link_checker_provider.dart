import 'package:antilure_mobile_apps/core/services/advanced_link_checker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Link checker service provider
final linkCheckerServiceProvider = Provider<AdvancedLinkChecker>((ref) {
  return AdvancedLinkChecker();
});

// Link analysis state
class LinkCheckState {
  final bool isLoading;
  final LinkAnalysisResult? result;
  final String? error;

  LinkCheckState({
    this.isLoading = false,
    this.result,
    this.error,
  });

  LinkCheckState copyWith({
    bool? isLoading,
    LinkAnalysisResult? result,
    String? error,
  }) {
    return LinkCheckState(
      isLoading: isLoading ?? this.isLoading,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}

// Link checker state notifier
class LinkCheckerNotifier extends StateNotifier<LinkCheckState> {
  final AdvancedLinkChecker _checker;

  LinkCheckerNotifier(this._checker) : super(LinkCheckState());

  Future<void> checkLink(String url) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _checker.analyzeUrl(url);
      state = state.copyWith(isLoading: false, result: result);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void clearResult() {
    state = LinkCheckState();
  }
}

// Link checker provider
final linkCheckerProvider =
    StateNotifierProvider<LinkCheckerNotifier, LinkCheckState>((ref) {
  final checker = ref.watch(linkCheckerServiceProvider);
  return LinkCheckerNotifier(checker);
});

// History provider
final historyProvider = FutureProvider<List<LinkAnalysisResult>>((ref) async {
  final checker = ref.watch(linkCheckerServiceProvider);
  return await checker.getHistory();
});
