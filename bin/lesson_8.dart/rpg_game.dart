import 'dart:math';
import 'boss.dart';
import 'heroes.dart';

class RpgGame {
  static final random = Random();
  static var roundNumber = 0;

  static void startGame() {
    final boss = Boss('Satana', 10000, 50);

    final warrior1 = Warrior('Ahiles', 280, 10);
    final warrior2 = Warrior('Lucifer', 290, 15);
    final magic = Magic('Maga', 270, 10);
    final berserk = Berserk('Viking', 260, 20);
    final doc = Medic('Aibolit', 250, 5, 15);
    final assistant = Medic('Laoma', 300, 5, 5);
    final lucky = Lucky('Sultan', 250, 15);
    final thor = Thor('Thor', 260, 22);
    final witcher = Witcher('Sasha', 150, 0);
    final golem = Golem('Sergey', 500, 5);
    final heroes = [
      warrior1,
      doc,
      magic,
      warrior2,
      thor,
      witcher,
      berserk,
      assistant,
      golem,
      lucky,
    ];

    _printStatistics(boss, heroes);

    while (!_isGameOver(boss, heroes)) {
      _playRound(boss, heroes);
    }
  }

  static bool _isGameOver(Boss boss, List<Hero> heroes) {
    if (!boss.isAlive()) {
      print('Heroes won!!!');
      return true;
    }

    bool allHeroesDead = true;
    for (var hero in heroes) {
      if (hero.isAlive()) {
        allHeroesDead = false;
        break;
      }
    }
    if (allHeroesDead) {
      print('Boss won!!!');
      return true;
    }

    return false;
  }

  static void _printStatistics(Boss boss, List<Hero> heroes) {
    print('------ ROUND $roundNumber ------');
    print(boss);
    for (var hero in heroes) {
      print(hero);
    }
  }

  static void _playRound(Boss boss, List<Hero> heroes) {
    roundNumber++;
    boss.chooseDefence();
    if (boss.isStunned) {
      boss.attack(heroes);
      boss.isStunned = false;
    }
    for (var hero in heroes) {
      if (hero.isAlive() && boss.isAlive() && hero.ability != boss.defence) {
        hero.attack(boss);
        hero.applySuperPower(boss, heroes);
      }
    }
    _printStatistics(boss, heroes);
  }
}
