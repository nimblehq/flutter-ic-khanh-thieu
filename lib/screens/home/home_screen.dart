import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/model/survey_model.dart';
import 'package:survey_flutter/screens/home/home_header_widget.dart';
import 'package:survey_flutter/screens/home/home_pages_widget.dart';
import 'package:survey_flutter/screens/home/home_page_indicator_widget.dart';
import 'package:survey_flutter/screens/home/home_shimmer_loading.dart';
import 'package:survey_flutter/screens/home/home_view_model.dart';
import 'package:survey_flutter/utils/build_context_ext.dart';
import 'package:survey_flutter/widgets/alert_dialog.dart';

const routePathHomeScreen = '/home';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

final _surveysStreamProvider = StreamProvider.autoDispose<List<SurveyModel>>(
    (ref) => ref.watch(homeViewModelProvider.notifier).surveys);

final _errorStreamProvider = StreamProvider.autoDispose<String?>(
    (ref) => ref.watch(homeViewModelProvider.notifier).error);

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _currentPage = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    ref.read(homeViewModelProvider.notifier).loadCachedSurveys();
    ref.read(homeViewModelProvider.notifier).loadSurveys();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(homeViewModelProvider).when(
          init: () => _buildHomeScreen(isLoading: true),
          loading: () => _buildHomeScreen(isLoading: true),
          error: () => _buildHomeScreen(),
          loadCachedSurveysSuccess: () => _buildHomeScreen(),
          loadSurveysSuccess: () => _buildHomeScreen(),
        );
  }

  Widget _buildHomeScreen({bool isLoading = false}) {
    final surveys = ref.watch(_surveysStreamProvider).value ?? [];
    final errorMessage = ref.watch(_errorStreamProvider).value ?? "";

    if (errorMessage.isNotEmpty) {
      showAlertDialog(
        context: context,
        title: context.localizations.errorText,
        message: errorMessage,
        actions: [
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.black),
            ),
            child: Text(context.localizations.okText),
            onPressed: () => Navigator.pop(context),
          )
        ],
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          if (surveys.isNotEmpty) ...[
            HomePagesWidget(
              surveys: surveys,
              currentPage: _currentPage,
            ),
            const HomeHeaderWidget(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 220),
                child: HomePageIndicatorWidget(
                    surveysLength: surveys.length, currentPage: _currentPage),
              ),
            )
          ],
          if (surveys.isEmpty || isLoading) _buildShimmerLoading(),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      child: Container(
        color: Colors.black,
        child: const HomeShimmerLoading(),
      ),
    );
  }

  @override
  void dispose() {
    _currentPage.dispose();
    super.dispose();
  }
}
