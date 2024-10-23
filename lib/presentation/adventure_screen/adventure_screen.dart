import 'package:dg_mini_app/presentation/adventure_screen/gameplay.dart';
import 'package:dg_mini_app/presentation/cubit/global_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AdventureScreen extends StatefulWidget {
  const AdventureScreen({super.key});

  @override
  State<AdventureScreen> createState() => _AdventureScreenState();
}

class _AdventureScreenState extends State<AdventureScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalCubit, GlobalState>(
      bloc: GetIt.I<GlobalCubit>(),
      buildWhen: (previous, current) => previous.hp != current.hp,
      builder: (context, state) {
        if (state.hp < 1) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/broken.jpg",
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),
                const Text(
                    "Your spaceship not ready to ship!\nMinimum HP is 5 to play this game.")
              ],
            ),
          );
        }
        return const GameScreen();
      },
    );
  }
}
