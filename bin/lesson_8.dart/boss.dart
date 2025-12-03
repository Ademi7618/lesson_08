import 'game_character.dart';
import 'super_ability.dart';
import 'rpg_game.dart';
import 'heroes.dart';

class Boss extends GameCharacter {
  bool isStunned = false;
  SuperAbility? defence;
  Boss(super.name, super.health, super.damage);

  void takeDamage(int dmg) {
    health -= dmg;
    if (health < 0) health = 0;
    print('Босс потерял $dmg  здоровья осталось: $health');
  }

  void attack(List<Hero> heroes) {
    for (var hero in heroes) {
      if (hero.isAlive()) {
        if (hero is Lucky && RpgGame.random.nextInt(4) == 1) {
          print('Lucky ${hero.name} dodged the attack!');
          continue;
        }
        if (hero is Berserk && defence != hero.ability) {
          hero.blockedDamage = (RpgGame.random.nextInt(2) + 1) * 5; // 5,10
          hero.health -= damage - hero.blockedDamage;
        } else {
          hero.health -= damage;
        }
      }
    }
  }

  void chooseDefence() {
    var abilities =
        SuperAbility.values; // heal, criticalDamage, blockRevert, boosting
    final randomIndex = RpgGame.random.nextInt(abilities.length); // 0,1,2,3
    defence = abilities[randomIndex];
  }

  @override
  String toString() {
    // String defenceType = 'No defence';
    // if (defence != null) {
    //   defenceType = defence!.name;
    // }
    return 'BOSS ${super.toString()} defence: ${defence == null ? 'No defence' : defence!.name}';
  }
}
