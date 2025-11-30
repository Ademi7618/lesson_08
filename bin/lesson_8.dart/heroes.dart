import 'game_character.dart';
import 'super_ability.dart';
import 'boss.dart';
import 'rpg_game.dart';

abstract class Hero extends GameCharacter {
  SuperAbility ability;
  Hero(super.name, super.health, super.damage, this.ability);

  void attack(Boss boss) {
    boss.health -= damage;
  }

  void applySuperPower(Boss boss, List<Hero> heroes);
}

class Warrior extends Hero {
  Warrior(String name, int health, int damage)
    : super(name, health, damage, SuperAbility.criticalDamage);

  @override
  void applySuperPower(Boss boss, List<Hero> heroes) {
    int crit = damage * (RpgGame.random.nextInt(5) + 2);
    boss.health -= crit;
    print('Warrior $name hits critically with $crit');
  }
}

class Magic extends Hero {
  Magic(String name, int health, int damage)
    : super(name, health, damage, SuperAbility.magic);

  @override
  void applySuperPower(Boss boss, List<Hero> heroes) {
    if (RpgGame.roundNumber <= 4) {
      int boost = RpgGame.random.nextInt(11) + 5;
    }
    for (Hero hero in heroes) {
      if (hero.health > 0 && hero != this) {
        hero.damage += 4;
      }
    }
    print('$Magic усилил атаку героев на + 4.');
  }
}

class Golem extends Hero {
  Golem(String name, int health, int damage)
    : super(name, health, damage, SuperAbility.protection);

  @override
  void applySuperPower(Boss boss, List<Hero> heroes) {
    for (var hero in heroes) {
      damage = boss.damage ~/ 5;
      hero.health += damage;
      health -= damage;
    }
    print('$Golem взал на себя 1/5 урона нанесённым боссом.');
  }
}

class Lucky extends Hero {
  Lucky(String name, int health, int damage)
    : super(name, health, damage, SuperAbility.luck);

  @override
  void applySuperPower(Boss boss, List<Hero> heroes) {}
}

class Berserk extends Hero {
  int blockedDamage = 0;
  Berserk(String name, int health, int damage)
    : super(name, health, damage, SuperAbility.blockRevert);

  @override
  void applySuperPower(Boss boss, List<Hero> heroes) {
    boss.health -= blockedDamage;
    print('Berserk $name reverted $blockedDamage');
  }
}

class Witcher extends Hero {
  Witcher(String name, int health, int damage)
    : super(name, health, damage, SuperAbility.witcher);

  @override
  void applySuperPower(Boss boss, List<Hero> heroes) {
    for (var hero in heroes) {
      if (!hero.isAlive()) {
        print('Witcher $name sacrificed himself to resurrect ${hero.name}');
      }
    }
  }
}

class Thor extends Hero {
  Thor(String name, int health, int damage)
    : super(name, health, damage, SuperAbility.stunned);

  @override
  void applySuperPower(Boss boss, List<Hero> heroes) {
    if (RpgGame.random.nextBool()) {
      boss.isStunned = true;
      print('Thor $name stunned the boss!');
    }
  }
}

class Medic extends Hero {
  int _healPoints;
  Medic(String name, int health, int damage, this._healPoints)
    : super(name, health, damage, SuperAbility.heal);

  @override
  void applySuperPower(Boss boss, List<Hero> heroes) {
    for (var hero in heroes) {
      if (hero.isAlive() && this != hero) {
        hero.health += _healPoints;
      }
    }
  }
}
