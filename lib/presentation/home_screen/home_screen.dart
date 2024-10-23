// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:dg_mini_app/presentation/common_widget/hud_view.dart';
import 'package:dg_mini_app/presentation/constant.dart';
import 'package:dg_mini_app/presentation/cubit/global_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shake_detector/shake_detector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ShakeDetectWrap(
      onShake: () {
        GetIt.I<GlobalCubit>().incrementCoins(amount: 3);
      },
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                BlocBuilder<GlobalCubit, GlobalState>(
                  bloc: GetIt.I<GlobalCubit>(),
                  buildWhen: (previous, current) => previous.telegramData != current.telegramData,
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            const CircleAvatar(
                              backgroundImage: AssetImage('assets/captain.jpg'),
                              radius: 30.0,
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Capt. ' +
                                  (state.telegramData?['user']
                                  ?['username'] ??
                                      'Unknown'),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        (state.telegramData != null &&
                            state.telegramData!['user'] !=
                                null)
                            ? Column(
                          children: [
                            Text(
                              state.telegramData?['user']
                              ?['first_name'] ??
                                  'Unknown',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              state.telegramData?['user']
                              ?['id']
                                  .toString() ??
                                  'Unknown',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        )
                            : Container(),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                BlocBuilder<GlobalCubit, GlobalState>(
                  bloc: GetIt.I<GlobalCubit>(),
                  buildWhen: (previous, current) => previous.hp != current.hp,
                  builder: (context, state) {
                    return Row(
                      children: <Widget>[
                        const HudView(
                          label: 'Earn Per tap: 2',
                          icon: Icon(
                            Icons.monetization_on,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        HudView(
                          label: 'HP ${state.hp}',
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        const HudView(
                          label: 'Coin per shake: +3',
                          icon: Icon(
                            Icons.monetization_on,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              GetIt.I<GlobalCubit>().incrementCoins(amount: 2);
            },
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              height: 300.0,
              curve: Curves.easeInOut,
              child: Image.asset(
                'assets/spaceship.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.monetization_on, color: Colors.amber),
                    const SizedBox(width: 8),
                    BlocBuilder<GlobalCubit, GlobalState>(
                      bloc: GetIt.I<GlobalCubit>(),
                      buildWhen: (previous, current) => previous.coins != current.coins,
                      builder: (context, state) {
                        return Text(
                          'Coins: ${state.coins}',
                          style: const TextStyle(fontSize: 20),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    GetIt.I<GlobalCubit>().incrementHP(context);
                  },
                  child: const Text(
                      '${'Buy HP (-${AppConstants.hpCost}'} coins)'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
