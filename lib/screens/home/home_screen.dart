import 'package:flutter/material.dart';
import 'package:survey_flutter/screens/home/home_header_widget.dart';
import 'package:survey_flutter/screens/home/home_pages_widget.dart';
import 'package:survey_flutter/screens/home/home_page_indicator_widget.dart';
import 'package:survey_flutter/screens/home/home_shimmer_loading.dart';

const routePathHomeScreen = '/home';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _openHomeWithShimmerLoading();
  }

  Future<void> _openHomeWithShimmerLoading() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HomePagesWidget(),
          const HomeHeaderWidget(),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 220),
              child: HomePageIndicatorWidget(),
            ),
          ),
          // TODO: Handle only show shimmer loading after user login
          if (_isLoading) _buildShimmerLoading(),
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
}
