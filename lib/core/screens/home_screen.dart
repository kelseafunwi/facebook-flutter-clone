import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:practice_flutter/core/constants/app_colors.dart';
import 'package:practice_flutter/features/auth/providers/auth_provider.dart';
import 'package:practice_flutter/widgets/round_icon_button.dart';
import 'package:practice_flutter/core/constants/constants.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with TickerProviderStateMixin {

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    // TabController uses the TickerProvider inside of its function initialization.
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: AppColors.grey,
        appBar: AppBar(
          backgroundColor: AppColors.realWhiteColor,
          title: _buildFacebookText(),
          elevation: 0,
          actions: [
            _buildMessengerWidget(),

            GestureDetector(
              onTap: () async {
                _showDialog();
              },
              child: _buildSearchWidget()
            ),
          ],
          bottom: TabBar(
            tabs: Constants.getHomeScreenTabs(_tabController.index),
            controller: _tabController,
            onTap: (index) {
              setState(() { });
            },
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: Constants.screens,
        )
      ),
    );
  }

  Widget _buildFacebookText() => const Text(
    "Facebook",
    style:  TextStyle(
      fontWeight: FontWeight.bold,
      color: AppColors.blueColor,
      fontSize: 30,
    ),
  );

  Widget _buildSearchWidget() => const  RoundIconButton(icon: FontAwesomeIcons.magnifyingGlass);

  Widget _buildMessengerWidget() => const  RoundIconButton(
      icon: FontAwesomeIcons.facebookMessenger
  );

  void _showDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 20,
          backgroundColor: Colors.grey,
          title: const Text('Warning...'),
          content: const Text("Are you sure you want to logout of the account ?."),
          icon: const Icon(Icons.warning),
          actions: [
            MaterialButton(
              onPressed: () async{
                await ref.read(authProvider).signOut();
              },
              child: const Text("Yes"),
            ),

            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            )
          ],
        );
      }
    );
  }
}
