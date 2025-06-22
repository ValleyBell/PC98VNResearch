# Gameplay notes and algorithms

## TOC

- [General](#general)
- [Battle](#battle)
- [Black Rose](#black-rose)
- [Character Building](CharacterBuilding.md) (separate file)
- [Debug Mode](#debug-mode)
- [Food and Drinks](#food-and-drinks)
- [Items](Items.md)
- [Magic Tablet](#magic-tablet)
- [Maps and locations](Maps.md) (separate file)
- [Night Safe 777](#night-safe-777)
- [Random Number Generation](#random-number-generation)
- [Shops](#shops)
- [Time System](#time-system)
- [Trust Level and Endings](#trust-level-and-endings)
- [Walkthrough](Walkthrough.md)

## General

**Note:** The documents here use texts from saintttimmy's English translation of MIME.

## Ancient Language

There is an "ancient language" in the game that only Tear can read.
She will usually translate it for everyone else, except for monster dialogues.

The language is actually just Romanized Japanese words, with a font that has heavily stylized Latin letters.
You can see the letters A..Z in the last two rows of the image below:

![image of the custom MIME glyphs](../font.png)

Internally, the game uses the JIS "ASCII mirror" codes to encode the ancient language (Shift-JIS codes 8561..857A), so they are easily readable in the decompiled scripts.

Example for the ancient language from floor 2F, map location 11,9:

- ingame:  
  ![image](ancient-lang-example.png)
- Latin letters:  
  「FUTATABI HOROBINO‥‥」  
  「KAZEGA FUKU‥‥」
- Tear's in-game translation:  
  “Once again, the winds of ruin blow...”

## Battle

- There are no encounters for 3 actions\* after returning to the dungeon screen after an event or battle.  
  After that, the enemy encounter rate is 1/16 for each step.
  The internal formula is: `(random() % 16) == 7` (see Z0001.DAT/loc\_227F)
  - *\ One "action" can be making a step or turning around. So if you turn 3 times and then make a step, you may encounter another enemy after just 1 step.
  - The "action counter" gets reset as soon as the dungeon script is reloaded - which is not only after events, but also after viewing the map or inventory screens.
- When defeating a monster, the characters gain:
  - exactly the amount of experience points defined by the monster table (register 10120)
  - the amount of RING defined by the monster table (register 10134) + an additional random 0..5 RING
- Register r388 is the "boss flag". It is 0 for normal enemies and 1 for bosses.
  When it is on, you can not talk to the enemies and escaping is impossible.
- When entering a battle, there is a 50% chance that the monster can talk to you.
- When entering a battle, there is a 10% chance of your party getting an extra attack, as well as a 10% chance of the monsters getting an extra attack.
- [List of monsters](Monsters.tsv) - list of all monsters and their attributes
- [List of monster groups](MonsterGroups.tsv) - list of all groups of monsters that can be encountered on each floor
- [Monster Talks](MonsterTalk.md) - list of all monster groups and their reply when you talk to them
- The required experience for a level up are: `655 * level`
- Attribute changes during level up:

  | Attribute     | Eagle | Tear  | Henzou | Eldelyca |
  |:-------------:|:-----:|:-----:|:-----:|:---------:|
  |    Max. HP    |  +12  |   +7  |  +10  |     +8    |
  |    Max. MP    |   +7  |  +10  |   +7  |     +8    |
  |    Attack     |   +2  |   +1  |   +2  |     +2    |
  |    Defense    |   +1  |   +1  |   +1  |     +1    |
  | Intelligence  |   +1  |   +3  |   +1  |     +1    |
  |    Agility    |   +2  |   +2  |   +2  |     +2    |

### Battle Fight Algorithms

- Determining the order of attacks (BATTLE1.DAT/sub\_664C):
  - Start with the order:
    - Eagle, Tear, Henzou, Eldelyca, monster 1, monster 2, monster 3, monster 4
  - Then sort them by their agility value, high to low agility. For equal agility values, the starting order acts as a tie breaker.
  - trivia: The game scripts uses bubble sort for sorting. It goes through all entries 7 times.
- Determining the monster attacks:
  - A random number in the range of `[1..10]` is generated.
  - result = 3 (10% chance) → use attack 1
  - result = 5 (10% chance) → use attack 2
  - result = 7 (10% chance) → use attack 3
  - other values (70% chance) → use attack 4
- Summary:
  - For "normal" attacks, the ratio of the *agility* of attacker and defender defines whether or not an attack misses.
    - An attack misses (or gets dodged), when the attacker's agility is lower than approximately 80% of the defender's agility.
    - When a player attacks a monster and his agility is >=150% of the monster's agility, the hit is critical and the damage is doubled.
  - Spells use the same formula as attacks for dodging, but calculate the ratio of *intelligence*.
    - There are no critical hits for spells.
  - Attack damage: `damage = attacker's attack - target's defense`
    - For "strong" monster attacks, the damage is multiplied with 1.5.
  - Spell damage: `damage = spell base damage + (attacker's intelligence / 2) + random[0..15]`
  - During most of the calculations, a random number is added to the attributes:
    - dodge calculation: add random[0..3] to agility or intelligence
      - When monsters attack, their agility is increased by random[0..10] instead.
    - attack damage: add random[0..5]
      - This happens *before* damage is modified by the "critical hit" or "strong attack" effects.
- Details:
  - player: normal attack

    ```
    # calculate dodge chance (sub_6BEE)
    atk_agl = attacker_agility + random(4)
    tgt_agl = target_agility + random(4)
    damage_chance = (atk_agl * 100 + 1) / (tgt_agl + 1)
    if (damage_chance < 80)
      # -> dodge attack
      damage = 0
    else if (damage_chance >= 80)
      # -> receive attack
      # calculate damage (sub_6C78)
      att_atk = attacker_attack + random(6)
      tgt_def = target_defense + 0
      damage = att_atk - tgt_def
      if (damage < 0)
        damage = 0
      if (damage_chance >= 150 && random(10) == 7)
        damage = damage * 2
        message "Critical hit"
    ```

  - player: attack spell

    ```
    # calculate dodge chance (sub_6C33)
    atk_int = attacker_intelligence + random(4)
    tgt_int = target_intelligence + random(4)
    damage_chance = (atk_int * 100 + 1) / (tgt_int + 1)
    if (damage_chance < 80)
      # -> dodge attack
      damage = 0
    else if (damage_chance >= 80)
      # -> receive attack
      # calculate damage (loc_6D1F/loc_6D8B)
      damage = spell_damage + floor(attacker_intelligence / 2) + random(16)
    ```

  - monster attacks:
    - attack types:
      - `action_id = random(4)`
      - `action_type = monster_action[action_id]`
      - ID 0/7: normal attack
      - ID 1/2/8/9: strong attack
      - ID 3/4/5: multi-target attack (targets all player characters)
      - ID 6: flee
    - target calculation: `random(4) + 1` where 1 = Eagle .. 4 = Eldelyca
      - The game repeats this until it points to the ID of a conscious player character.
  - monster: normal attack / multi-target attack (sub\_6994)

    ```
    # calculate dodge chance (sub_6E7D)
    atk_agl = attacker_agility + random(11)
    tgt_agl = target_agility + random(4)
    damage_chance = (atk_agl * 100 + 1) / (tgt_agl + 1)
    # Note that for the 7F boss "Arachne", the attack always succeeds.
    if (damage_chance < 80 && not (floor == 7 && monster_group == 14 && boss_flag == 1))
      # -> dodge attack
      damage = 0
    else if (damage_chance >= 80)
      # -> receive attack
      # calculate damage (sub_6ED6)
      atk_atk = attacker_attack + random(6)
      tgt_def = target_defense + 0
      if (floor == 7 && monster_group == 14 && boss_flag == 1))
        # 7F boss "Arachne": ignore any defense, add [0..24] damage
        tgt_def = 0
        atk_atk += random(25)
      damage = att_atk - tgt_def
    ```

  - monster: strong attack (sub\_6A33)

    ```
    # calculate dodge chance (sub_6E7D)
    atk_agl = attacker_agility + random(11)
    tgt_agl = target_agility + random(4)
    damage_chance = (atk_agl * 100 + 1) / (tgt_agl + 1)
    # Note that for the 7F boss "Arachne", the attack always succeeds.
    if (damage_chance < 80 && not (floor == 7 && monster_group == 14 && boss_flag == 1))
      # -> dodge attack
      damage = 0
    else if (damage_chance >= 80)
      # -> receive attack
      # calculate damage (sub_6F61)
      atk_atk = attacker_attack + random(6)
      tgt_def = target_defense + 0
      atk_atk = atk_atk * 15 / 10
      
      if (floor == 7 && monster_group == 14 && boss_flag == 1))
        # 7F boss "Arachne": ignore any defense, add [0..127] damage
        tgt_def = 0
        atk_atk += random(128)
      damage = att_atk - tgt_def
    ```

- list of work registers:
  - r192/r193/r194/r195: current player agility/attack/defence/intelligence
  - r196/r197/r198/r199: current monster agility/attack/defence/intelligence
  - r208/r209/r210/r211/r212/r213/r214/r215: entity order (1 = eagle ... 8 = monster 4)
  - r216/r217/r218/r219: Eagle agility/attack/defence/intelligence (modified by current hour)
  - r220/r221/r222/r223: Tear agility/attack/defence/intelligence (modified by current hour)
  - r224/r225/r226/r227: Henzou agility/attack/defence/intelligence (modified by current hour)
  - r228/r229/r230/r231: Eldelyca agility/attack/defence/intelligence (modified by current hour)
  - r232/r233/r234/r235: monster 1 agility/attack/defence/intelligence (modified by current hour)
  - r236/r237/r238/r239: monster 2 agility/attack/defence/intelligence (modified by current hour)
  - r240/r241/r242/r243: monster 3 agility/attack/defence/intelligence (modified by current hour)
  - r244/r245/r246/r247: monster 4 agility/attack/defence/intelligence (modified by current hour)
  - r248: counter for currently acting entity (1..8)
  - r249: ID of currently acting entity (1..8)
  - r273: damage result
  - r252/r253/r271/r272: monster 1..4 HP
  - r319/r320/r321/r322: monster 1..4 ID
  - r355/r356/r357/r358: Eagle/.../Eldelyca action (1 = attack, 2 = magic, 3 = flee)
  - r359: spell ID (during calculations)
  - r360/r361/r362/r363: Eagle/.../Eldelyca spell ID (1..6)
  - r364/r365/r366/r367: monster 1..4 attack type
  - r368: target (during calculations)
  - r369/r370/r371/r372: Eagle/.../Eldelyca target (1..4)

### Fleeing from Battle

- Each way of escaping has different actions with varying chances. The results are determined by RNG in the range of `[1..10]` or `[1..20]`, depending on the action.
- For some actions, there is a chance of obtaining or losing RING. The exactl amount is also determined by RNG and is always in the range of `[10..100]`.
- Flee actions:
  - Bolt Away:
    - summary: 50% success, 50% failure, 40% chance of losing RING
    - 2/10: "The monsters followed behind!!" "And caught up!!" (failure)
    - 2/10: "But the monsters shrieked and matched their movements!!" (failure)
    - 1/10: "But the monsters caught up with them!" (failure)
    - 1/10: "The monsters bolted away and ran as well!" (success)
    - 4/10: "But they ran too fast and dropped # RING in the process!" (success, lose 10..100 RING)
  - Back Away:
    - summary: 80% success, 20% failure, 15% chance of losing RING
    - 1/20: "But backed around back into the monsters!!" (failure)
    - 1/20: "\[Player\] slipped on a banana peel!!" "While also scattering # RING across the floor!" (failure, lose 10..100 RING)
    - 1/20: "\[Player\] tripped on a pebble!!" "While also scattering # RING across the floor!" (failure, lose 10..100 RING)
    - 1/20: "\[Player\] fell on their back!!" "While also scattering # RING across the floor!" (failure, lose 10..100 RING)
    - 16/20: "The monsters also backed away until they couldn't be seen again!!" (success)
    - *Possible bug:* The RNG is probably supposed to be in the range of only `[1..10]` here.  
      This would double the chance for each of the "failure" actions and decrease the success rate to 40%, which is similar to the probabilities of the other choices.
  - Turn Away:
    - summary: 40% success, 60% failure, 20% chance of gaining RING
    - 5/20: "The monsters watched and got dizzy!!" (success)
    - 2/20: "But the monsters did a somersault and caught up!!" (failure)
    - 1/20: "The monsters clapped in amusement." "They threw # RING at them!!" (success, gain 10..100 RING)
    - 1/20: "The monsters stared at them in silence." "The monsters sighed, tapped \[Player\] on their shoulder, and gave them # RING." (success, gain 10..100 RING)
    - 1/20: "The monsters tried imitating them by spinning in place!" "And were left there!" (success)
    - 10/20: "\[Player\] got dizzy and fell down!!" (failure)
  - Handstand:
    - summary: 40% success, 60% failure, 40% chance of losing RING, 20% chance of gaining RING
    - 2/10: "But the contents of their pockets fell onto the floor!!" "# RING were lost!" (failure, lose 10..100 RING)
    - 2/10: "But # RING fell out onto the floor!!" "The monsters snatched them up!" (success, lose 10..100 RING)
    - 2/10: "The monsters tried to imitate the act!" "The monsters successfully learned how to do a handstand!!" "The monsters shook \[Player\]'s hand, gave them "# RING and left." (success, gain 10..100 RING)
    - 1/10: "The monsters tried to imitate the act!" "But they couldn't seem to get it down!!" "The monsters get angry at \[Player\]!" (failure)
    - 3/10: "\[Player\] couldn't avoid the monsters catching up to them!!" (failure)
  - Recommendations:
    - "Back Away" has the highest chance of success (80%).
    - "Turn Away" is the least risky choice, if you care about your money, as you can not lose RING there.

## Black Rose

Each of the girls in the Black Rose brothel has its own requirement before serving you.

- "The Twin Sisters" (Dana and Donna): pay 999 RING (Note: Works only *before* beating the final boss.)
- "The Relaxed Girl" (Stella): pay 999 RING
- "The Little Devil" (Elvira): have item "Rare Skull", then item "Super Rare Skull" (Note: The requirements mean that she is accessable only after beating the final boss.)
- "The Sadist" (Chloture): be level 30 or higher (Note: Allows only 1 "successful" visit.)
- "The Warrior" (Ashley): have item "Evil Sword" (Note: Allows only 1 "successful" visit.)
- "The Elf Girl" (Cass): pay 999 RING
- "???????" (Tenko-chan): defeat the Chimera boss (Note: Allows only 1 "successful" visit.)

## Debug Mode

There is a debug mode left in the game's release version. It has the following features:

- during dungeon movement:
  - allow you to instantly quit the game by holding Shift + clicking in the region (0,0)..(32,32) (top left edge of the screen)
  - open a debug menu by holding Shift + clicking in the region (0,368)..(32,400) (bottom left edge of the screen)
  - jump to the "Window Girl" by holding Shift + clicking in the region (608,0)..(640,32) (top right edge of the screen)
  - enter test mode by holding Shift + clicking in the region (608,368)..(640,400) (bottom right edge of the screen)
- allow you to warp to any maze on the "Window Girl" screen
- add rune stone descriptions to the magic stone tablet screen
- give you extra options in the battle:
  - "I love Morrigan" - restores all HP and MP to all characters
  - "End" - instantly ends the battle

In order to enable debug mode, you have to enter one of the following 7 names as your player's name and hold the Shift key while confirming the name.
The game will play a special sound effect to confirm the cheat code and change the player's name to another name as shown below.

- `のぎやま` (Nogiyama) → `野木山❤` (Nogiyama❤)
- `おきやま` (Okiyama) → `爆音小僧` (Bakuon Kozou)
- `あさい` (Asai) → `レイレイ` (Lei-Lei)
- `マサキＤ` (MasakiD) → `三石ﾕ渠` (Mitsuishi Yuko)
- `むっち～` (Mucchi~) → `火野レイ` (Hino Rei)
- `メイロン` (MEIRONG) → `リュウ` (Ryuu)
- `だば` (Daba) → `天陳影久` (Tenchin Eikyuu)
- Thanks to saintttimmy for transcribing the names.

Internally, debug mode is enabled by setting a flag in script register 394. (offset 0x314 in the saved game)
There is a separate bit set for each name, but the game generally only checks whether or not the register is set to 0, so all of the names have the same effect.

## Food and Drinks

Each type of food, drink and dessert reduces the Hunger Level by a certain amount.

### Noah's Bar

| Food / Drink / Dessert| Cost  | Huger reduction |
|:--------------------- | ----- | --- |
| Noah Bowl             |  30   |  40 |
| Noah Soba             |  30   |  40 |
| Noah Pizza            |  40   |  50 |
| Noah Burger           |  40   |  50 |
| Noah Chanko           |  50   |  60 |
| Noah Curry            |  50   |  60 |
| Noah Ramen            |  50   |  60 |
| Noah Stew             |  50   |  60 |
| Noah Steak            |  70   |  80 |
| Noah Full Course      |  90   | 100 |
| Noah Yum Cha          |  90   | 100 |
| Green Tea             |   8   |  10 |
| Oolong Tea            |   8   |  10 |
| Juice                 |   8   |  10 |
| No-Ah Sake            |  35   |  50 |
| Noah Beer             |  35   |  50 |
| Noah Whiskey          |  35   |  50 |
| Noah Special Cocktail |  35   |  50 |
| Noah Parfait          |  40   |  60 |
| Pudding Noah la Mode  |  40   |  60 |
| Black Tea + Noah Cake |  35   |  50 |
| Coffee + Noah Cake    |  35   |  50 |

### Antonio's Inn

It should be noted that the "Noah"-Drinks are a bit more expensive in Antonio's Inn than they are in Noah's Bar.

| Food / Drink / Dessert| Cost  | Huger reduction |
|:--------------------- | ----- | --- |
| No-Ah Sake            |  50   |  50 |
| Noah Beer             |  50   |  50 |
| Noah Whiskey          |  50   |  50 |
| Manbattan             |  80   |  80 |
| Screwanton SP         | 100   | 100 + make drunk |

Being drunk does not have any effect on the gameplay, except for the changed music and faces.

## Magic Tablet

At coordinate 2,0 on floor 2F, there is a Magic Tablet that allows you to learn spells and craft items.  
This is done by placing 6 rune stones on the tablet.

You can find a list of all spells and items and their requirements here:
[MagicTablet-List.tsv](MagicTablet-List.tsv)

Note that even though the the list (which was generated from the game's script file) may suggest that the order matters, it does not.
You can place the stones in any order and it will work as long as you place the correct number of each stone.

## Night Safe 777

### "High Low" prizes

The prices are determined by a random number in the range of `[1..226]`.

| Chance            | Prize              |
|:-----------------:|:-------------------|
| 70.80 % (160/226) | 100 RING           |
| 13.27 %  (30/226) | 150 RING           |
|  4.42 %  (10/226) | 200 RING           |
|  1.33 %   (3/226) | Turbo Garnlic      |
|  1.33 %   (3/226) | Mom's Rice Ball    |
|  1.33 %   (3/226) | Mabo-chin          |
|  1.33 %   (3/226) | Great Mabochin     |
|  1.33 %   (3/226) | Yosaku's Rice Ball |
|  0.88 %   (2/226) | Magic Nut Alpha    |
|  0.88 %   (2/226) | Magic Nut Beta     |
|  0.88 %   (2/226) | Life Berry         |
|  0.44 %   (1/226) | Arm Training Wraps |
|  0.44 %   (1/226) | Sage's Toenail     |
|  0.44 %   (1/226) | Agile Berry        |
|  0.44 %   (1/226) | Strength Berry     |
|  0.44 %   (1/226) | Ring of Dispelling |

## Random Number Generation

- The game has a global random number generator (RNG) that it uses to determine many of its actions.
  - initialization

    ```
    word_1DD52 = [value based on current date and time]
    word_1DD54 = 0
    ```

  - RNG step: (I will just quote the x86 assembly for now.)

    ```asm
    RNG_GetNext:
            mov     cx, word_1DD54
            mov     bx, word_1DD52
            mov     dx, 16838
            mov     ax, 20077
            call    RNG_Advance
            add     ax, 12345
            adc     dx, 0       ; add overflow of previous addition
            mov     word_1DD54, dx
            mov     word_1DD52, ax
            mov     ax, word_1DD54
            and     ax, 7FFFh   ; return (word_1DD54 & 7FFFh)
            retf

    RNG_Advance:
            push    si
            
            xchg    ax, si  ; SI = 20077
            xchg    ax, dx  ; AX = 16838
            
            test    ax, ax
            jz      short loc_10B23
            mul     bx      ; AX = 16838 * word_1DD52, DX = high 16 bits of the result
    loc_10B23:
            
            jcxz    short loc_10B2A ; skip when word_1DD54 == 0
            xchg    ax, cx
            mul     si
            add     ax, cx  ; AX = word_1DD54 * 20077 + AX, DX = high 16 bits of the mult. result
    loc_10B2A:
            
            xchg    ax, si
            mul     bx      ; AX = 20077 * word_1DD52
            add     dx, si  ; DX += 20077
            
            pop     si
            retf
    ```

  - The scripts usually request the result to be in a specific range.
    The 15-bit result of the RNG is limited using a simple modulo operation: `result = random() % range`

## Shops

### Sadao's Shop

|   ID  | item name             | availability  |
| -----:|:--------------------- |:------------- |
|    0  | Cheap Candy           | *before* Henzou joins |
|    1  | Candy                 | *before* Henzou joins |
|    2  | Garlic                | |
|    3  | Turbo Garlic          | after Henzou joins |
|    4  | Super Garlic          | after Henzou joins |
|    6  | Ponky Stick           | |
|    7  | Fairy Dust            | after Henzou joins |
|    9  | Guarana Chocolate     | after Henzou joins |
|   11  | Chocolate             | *before* Henzou joins |
|   12  | Cookie                | |
|   13  | Rice Ball             | *before* Henzou joins |
|   14  | Mom's Rice Ball       | after Henzou joins |
|   16  | Great Mabo-chin       | after Henzou joins |
|   88  | Dagger                | |
|   89  | Shortsword            | |
|   93  | Longsword             | |
|   91  | Monkish Monk Staff    | |
|   90  | Kunai (L)             | |
|   92  | Kodachi (R)           | |
|  170  | Clothes               | |
|  176  | Leather Armor         | |
|  181  | Chainmail             | |
|  175  | Pretty Dress          | |
|  177  | Monkish Monk Robes    | |
|  179  | Training Attire       | |
|  148  | Small Shield          | |
|  150  | Heater Shield         | |
|  149  | Stylish Bracelet      | |
|  219  | Face Mask             | |
|  220  | Ribbon                | |
|  268  | Agile Piercings       | |
|  252  | Coin of Power         | |
|   74  | Wind Rune             | |
|   77  | Water Rune            | |
|   80  | Fire Rune             | |
|   83  | Earth Rune            | |
|   79  | Accuracy Rune         | after Tear joins |
|   82  | Scatter Rune          | after Tear joins |
|   84  | Light Rune            | after Tear joins |
|   78  | Harmony Rune          | after Eldelyca joins |

Out of the 3 shops, Sadao is the only one that changes his shop's supplies throughout the game.
The offered products change slightly every time you get a new character into your party.

It should be noted that he removes some items when Henzou joins your party:

- item 0: Cheap Candy (heal 25 HP)
- item 1: Candy (heal 50 HP)
- item 11: Chocolate (reduce Hunger level by 10)
- item 13: Rice Ball (reduce Hunger level by 30)

Those items get replaced with stronger (but more expensive) equivalents.

### Twins Toy Shop

|   ID  | item name             |
| -----:|:--------------------- |
|    2  | Garlic                |
|    3  | Turbo Garlic          |
|    4  | Super Garlic          |
|    6  | Ponky Stick           |
|    7  | Fairy Dust            |
|   14  | Mom's Rice Ball       |
|   15  | Mabo-chin             |
|  102  | Master Sword          |
|  109  | Harp of The End       |
|   97  | Shuriken (L)          |
|  100  | Ninja Sword (R)       |
|  101  | Rapier                |
|  104  | Scimitar              |
|  180  | Trenchcoat            |
|  184  | Master Armor          |
|  182  | Cat Pajamas           |
|  185  | Waitress Outfit       |
|  154  | Master Shield         |
|  151  | Charming Bracelet     |
|  226  | Master Helmet         |
|  224  | Cat Hat               |
|  257  | Stylish Panties       |
|  259  | Sexy Lingerie         |
|  260  | Yosaku's Fundoshi     |
|  258  | Master Briefs         |
|   84  | Light Rune            |
|   76  | Shadow Rune           |
|   79  | Accuracy Rune         |
|   82  | Scatter Rune          |

### Donkey's Shop

|   ID  | item name             |
| -----:|:--------------------- |
|    4  | Super Garlic          |
|    7  | Fairy Dust            |
|    9  | Guarana Chocolate     |
|   14  | Mom's Rice Ball       |
|   16  | Great Mabo-chin       |
|   22  | Mandrake Elixir       |
|  113  | Storm Sword           |
|  114  | Angel Mace            |
|  103  | Shadow Sword (R)      |
|  106  | 卍 Shuriken (L)       |
|  107  | Demon Slayer          |
|  192  | Storm Armor           |
|  188  | Charming Dress        |
|  189  | Ninja Attire          |
|  190  | Armor of The Sun      |
|  158  | Storm Shield          |
|  155  | Crystal Bracelet      |
|  231  | Storm Helmet          |
|  234  | Angel's Ribbon        |
|  232  | Genji's Headband      |
|  233  | Red Dragon Helmet     |
|   75  | Protection Rune       |
|   78  | Harmony Rune          |
|   81  | Holy Rune             |
|   86  | Evil Rune             |
|  171  | White Tuxedo          |
|  172  | Black Tuxedo          |
|  173  | White Dress           |
|  174  | Black Dress           |

## Tea Party Work

Tear and Eldelyca may work at the Tea Party on floor 6F.

They must have at least 26 HP before they are allowed to work.
Working once consumes 20 HP is the respective character.

You get a reward for working, which is chosen based on a random number in the range of `[1..2048]`.

| Chance              | Prize              |
|:-------------------:|:-------------------|
| 73.14 % (1498/2048) | 10 RING            |
|  4.88 %  (100/2048) | Candy              |
|  0.98 %   (20/2048) | Super Garlic       |
|  1.95 %   (40/2048) | Fairy Dust         |
|  0.98 %   (20/2048) | Guarana Chocolate  |
|  0.98 %   (20/2048) | Steamed Bun        |
|  0.98 %   (20/2048) | Mom's Rice Ball    |
|  0.98 %   (20/2048) | Mabo-chin          |
|  0.98 %   (20/2048) | Great Mabochin     |
|  0.98 %   (20/2048) | Mandrake Elixir    |
|  1.22 %   (25/2048) | Life Berry         |
|  0.24 %    (5/2048) | Arm Training Wraps |
|  0.24 %    (5/2048) | Sage's Toenail     |
|  0.24 %    (5/2048) | Agile Berry        |
|  0.24 %    (5/2048) | Strength Berry     |
|  0.73 %   (15/2048) | Wallet of Doom     |
|  0.98 %   (20/2048) | Hunger Drum        |
|  0.49 %   (10/2048) | Nightmare Whispers |
|  0.49 %   (10/2048) | Magic Mirror       |
|  0.98 %   (20/2048) | Chapa Chaps        |
|  0.98 %   (20/2048) | Actress Autograph  |
|  0.24 %    (5/2048) | Cursed Harmonica   |
|  0.24 %    (5/2048) | Spirit's Blessing  |

Trivia:

- "10 RING" covers two ranges of the random number: `[1..100]` and `[651..2048]`
- "Candy" covers three ranges of the random number: `[101..220]`, `[321..380]` and `[441..480]`

## Time System

### Hours of the day

The game has a time system. It works by counting steps, hours and days.

- 1 step = moving one field forward or backward (turning does not advance time)
- 1 hour = 32 steps
- 1 day = 13 hours

Every hour of the week has a specific element. They are:

- 1: wind
- 2: protection
- 3: shadow
- 4: water
- 5: harmony
- 6: accuracy
- 7: fire
- 8: holy
- 9: scatter
- 10: earth
- 11: light
- 12: destruction
- 13: evil

When entering a battle during the hour of a player character's or monster's element, its attributes for attack, defence, intelligence and agility will be increased by 50%.

### Hunger Level

Every character has a "hunger level", which ranges from 0% to 100%.

The hunger level is increased by 1% every 10 steps you take.
Characters will complain about being hungry when reaching 70%, 80%, 90% and 100%.

When the hunger level reaches 100%, the respective character's HP decreases by 1 with each step until he collapses or eats.

### Poision and drunkenness

There are a few traps on floor B1F that can poison your characters.
When poisoned, the character's HP decreases by 1 with each step.
Poison wears off after 64 steps. (The duration is set by the respective event and the only one event causing poison sets it to 64.)

The characters can get drunk either by drinking a "Screwanton SP" in Antonio's Inn, or randomly by drinking from the spring in the 5F Tear Maze.
Being drunk has no effect on gameplay mechanics. It just changes the music and the character images.
Drunkenness wears off after 64 steps. (The duration is set by the respective event, but they all set the duration to 64.)

## Trust Level and Endings

The game features a "trust level" for the relation of Eagle to other members of the parts.
It is increased at certain points in the game, when you can pick between the three characters.

The trust level determines dialogue and images during the second part of the ending: You get the ending with character with the highest trust level.
For breaking ties, Tear gets the highest preference, then Eldelyca.

The ingame algorithm is:

- Tear's trust level is >= Henzou's and Eldelyca's → Ending 1 (Tear Ending)
- Henzou's trust level is > Tear's and it is > Eldelyca's → Ending 2 (Henzou Ending)
- Eldelyca's trust level is > Tear's and it is >= Henzou's → Ending 3 (Eldelyca Ending)

The trust level is increased during the following scenes:

- A112 "Stella" (brothel):
  - After the dialogue "Listening to Stella's words, one person came to the front of my mind.", you get to choose whom of your party members you are thinking of.
    - Tear
    - Henzou
    - Eldelyca
    - no one
  - The chosen person's trust level is increased by 1.
- A200A "The Three Dwarfs":
  - After the dialogue "Listen, Eagle... which are ya aiming for?", you must choose between:
    - Tear
    - Eldelyca
    - Henzou
    - Dwarf
  - The chosen person's trust level is increased by 1.
- A201B "Phantom Castle" (Tear only)
  - When you give Maid Toppo the golden apple and thus save Tear, her trust level is increased by 10.
  - Note: This is a mandatory story event.
- A503 "Crystal Forest"
  - When Alaia asks you to search for her gemstone, you get to choose:
    - Yes
    - on Tear's behalf
    - on Henzou's behalf
    - on Eldelyca's behalf
  - The chosen person's trust level is increased by 2. Agreeing without conditions does not increase any trust level.
  - Later, when everybody is sleeping and you wake up, you can:
    - Go back to sleep
    - Look for Tear → increases Tear's trust level by 1
- A602 "Black Ball" / A605 "White Ball"
  - You can do various tasks with your party members here.
    - dance → increase trust level by 1
    - eat → increase trust level by 1
- A607 "Music Box Boy":
  - When get asked, who takes the doll, the first choice ("Take the doll") increases the trust level for all 3 parters by 1.
  - All other choices (i.e. not taking the doll or wanting a kiss) have no effect.

Due to the story event of Tear's awakening, she effectively starts with a trust level of 10 while Henzou and Eldelyca start at 0.
This means that in order to get the alternate ending scenes, you have to repeat the dance/eat tasks during the black and white ball a few times in order to increase the respective member's trust level.
Right after freeing Eldelyca, you can also repeat the dwarf dialogue multiple times to increase the trust level.
