import 'package:dg_mini_app/presentation/adventure_screen/adventure_screen.dart';
import 'package:dg_mini_app/presentation/cubit/global_cubit.dart';
import 'package:dg_mini_app/presentation/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  late List<Widget> _widgetOptions;
  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      const HomeScreen(),
      const AdventureScreen(),
      const Text('Earn Tab - Coming Soon'),
      const Text('Friend Tab - Coming Soon'),
      const Text('Airdrop Tab - Coming Soon'),
    ];
  }

  void _onItemTapped(int index) {
    GetIt.I<GlobalCubit>().changeTab(index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalCubit, GlobalState>(
      bloc: GetIt.I<GlobalCubit>(),
      buildWhen: (previous, current) => previous.tabIndex != current.tabIndex,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 20,
            // title: Text(
            //   'Expedition to the Moon',
            //   style: TextStyle(fontSize: 18),
            // ),
          ),
          body: _widgetOptions.elementAt(state.tabIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Garage',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.videogame_asset_rounded),
                label: 'Adventure',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.monetization_on),
                label: 'Earn',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group),
                label: 'Friend',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard_rounded),
                label: 'Airdrop',
              ),
            ],
            currentIndex: state.tabIndex,
            selectedItemColor: Colors.amber[800],
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
            showUnselectedLabels: true,
          ),
        );
      },
    );

  }
}
