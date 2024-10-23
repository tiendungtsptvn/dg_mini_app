import 'dart:convert';

import 'package:dg_mini_app/data/services/telegram_service.dart';
import 'package:dg_mini_app/presentation/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'global_state.dart';

export 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(const GlobalState());

  final _telegramService = TelegramService();

  void init() {
    getTelegramData();
  }

  /// Change tab.
  changeTab(int index) {
    emit(state.copyWith(tabIndex: index));
  }

  /// Increment coins.
  void incrementCoins({int amount = 1}) {
    emit(state.copyWith(
      coins: state.coins + amount,
    ));
  }

  /// Upgrade spaceship.
  void incrementHP(BuildContext context) {
    var availableCoins = state.coins;
    var hp = state.hp;
    if (availableCoins >= AppConstants.hpCost) {
      availableCoins -= AppConstants.hpCost;
      hp += 1;
    } else {
      // Get.snackbar('Error', 'Not enough coins to buy HP!');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not enough coins to buy HP!'),
        ),
      );
    }
    emit(state.copyWith(
      coins: availableCoins,
      hp: hp,
    ));
  }

  /// Buy HP.
  void reduceHp({int amount = 1}) {
    emit(state.copyWith(
      hp: state.hp - amount,
    ));
  }

  /// Get Telegram data.
  void getTelegramData() {
    final telegramData = _telegramService.initTelegramWebApp();
    if (telegramData != null) {
      debugPrint('Telegram Data: $telegramData');
      emit(state.copyWith(
        telegramData: telegramData,
      ));
    } else {
      debugPrint('Telegram data is null.');
    }
  }
}
