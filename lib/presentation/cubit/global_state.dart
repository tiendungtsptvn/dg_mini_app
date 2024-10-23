import 'package:equatable/equatable.dart';

class GlobalState extends Equatable {
  const GlobalState({
    this.tabIndex = 0,
    this.telegramData,
    this.coins = 0,
    this.hp = 0,
  });

  final int tabIndex;
  final Map<String, dynamic>? telegramData;
  final int coins;
  final int hp;

  GlobalState copyWith({
    int? tabIndex,
    Map<String, dynamic>? telegramData,
    int? coins,
    int? hp,
  }) {
    return GlobalState(
      tabIndex: tabIndex ?? this.tabIndex,
      telegramData: telegramData ?? this.telegramData,
      coins: coins ?? this.coins,
      hp: hp ?? this.hp,
    );
  }

  @override
  List<Object?> get props => [
        tabIndex,
        telegramData,
        coins,
        hp,
      ];
}
