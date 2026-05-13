# Dragoon Armor for Adult

I was helping fuzion and BabaJeanmel with the technical parts of an English translation of "Dragoon Armor for Adult" by Fairytale.
The original goal was to patch the game to support displaying half-width characters, but along the way I did a bit of additional research as well.

The translation can be found [here on GBAtemp](https://gbatemp.net/download/pc-98-dragoon-armor-for-adult-english-patch.39859/) or [here on romhack.ing](https://romhack.ing/database/content/entry/lKZT9B8zSA63F_zGxJnnRA/dragoon-armor-for-adult-english-translation)

- `DUNGEON.EXE` protection removal tool: see `dafa_dec` from my [extractors and decoders repository](https://github.com/ValleyBell/ExtractorsDecoders)
- [archive with game executables](executables.7z) (`DUNGEON.EXE` in its original form, as `DEC1` without protection, as `DEC2` without EXEPACK)
- `DUNGEON.EXE` disassembly: [ASM file](DUNGEON.asm) / [IDB file](DUNGEON.idb)
- a tool to dump nearly all text strings from `DUNGEON.EXE`: [dungeon2asm.py](dungeon2asm.py)
- an [English patch](DUNGEON-EN.asm) for `DUNGEON.EXE`
  - A prepatched version is included as [DUNGEON-EN.EXE](DUNGEON-EN.EXE).
  - Thanks to BabaJeanmel for allowing me to use all of the English texts from the final translation.
  - **Note:** This EXE patch works only with the ASCII-patched `MESPUT.COM`, because the COM driver does the actual text rendering.
- `MESPUT.COM` disassembly: [ASM file](MESPUT.asm) / [IDB file](MESPUT.idb)
- a [patch to support half-width and ASCII text](MESPUT-ASC.asm) in `MESPUT.COM`
  - A prepatched version is included as [MESPUT-ASC.COM](MESPUT-ASC.COM).

## Gameplay tricks and algorithms

### Cheat Codes

The game features a cheat code that allows you to start the game with high stats:
- After the opening, hold they keys `P` and `S` simultaneously until the "Start Game" text appears.
- select "Start Game"
- accept the rolled stats (They don't matter anyway)
- Ignore that the stats are still the prerolled ones and "Enter the Tower".
- Once you see the 3D dungeon, your stats should be:
  - HP: 255
  - gold: 60 000
  - level: 1
  - character Strength: 255 (shown as "STR 075" due to equipment)
  - character Dexterity: 255 (shown as "DEX 235" due to equipment)
  - equipped weapon: Silver Bastard (ID 9)
  - equipped armor: Silver Plate (ID 9)
  - equipped shield: Silver Shield (ID 7)

### Strength and Dexterity

Your character has a specific "strength" and "dexterity". Those character properties are shown while you are in the item shop.

Once you enter the dungeon, "effective" STR and DEX values are calculated as follows:

```
DEX(equipment) = DEX(armor) + DEX(shield)
STR(equipment) = STR(armor) + STR(shield) + STR(weapon) + [50 if you have Ring of Strength]
STR(character) >= STR(equipment) →
    STR(final) = STR(character) - STR(equipment)
STR(character) < STR(equipment) →
    STR(final) = 0
    DEX(equipment) += (STR(equipment) - STR(character))
DEX(final) = DEX(character) - DEX(equipment)
```

After every addition or subtraction, the resulting value is clamped to a range of [0..255].

The `STR(final)` and `DEX(final)` values are shown on the right side of the screen when traveling through the dungeon.  
`STR(final)` has no further effects.

### Equipment Properties

| Weapons           |  Gold | STR   | rolls |rollDmg|baseDmg| final ATK |
|:------------------|------:|------:|------:|------:|-------|:---------:|
| none\*            |     0 |   0   |    1  |    4  |    0  |   1..  4  |
| Dagger            |    10 |   5   |    1  |    6  |    0  |   1..  6  |
| Hammer            |    20 |  15   |    1  |    8  |    2  |   3.. 10  |
| Short Sword       |    50 |  20   |    2  |    6  |    0  |   2.. 12  |
| Long Sword        |   100 |  35   |    3  |    6  |    6  |   9.. 24  |
| Broad Sword       |   500 |  40   |    3  |    8  |    8  |  11.. 32  |
| Falchion          |   600 |  40   |    4  |    6  |    8  |  12.. 32  |
| Bastard Sword     |  1500 |  60   |    6  |    6  |   10  |  16.. 46  |
| Great Sword       | 10000 | 100   |   10  |    6  |   10  |  20.. 70  |
| Silver Bastard\*  | 30000 |  60   |   10  |   10  |   20  |  30..120  |
| Dragon Slayer\*   | 60000 |  40   |   10  |   20  |   30  |  40..230  |

| Armor             |  Gold | STR   |  DEX  |  DEF  |
|:------------------|------:|------:|------:|------:|
| none\*            |     0 |    0  |    0  |    0  |
| Robe              |    10 |    2  |    2  |    2  |
| Leather Armor     |    30 |    4  |    1  |    5  |
| Ring Mail         |    50 |   12  |    3  |   10  |
| Scale Mail        |   100 |   20  |    5  |   15  |
| Half Plate        |   500 |   60  |    7  |   20  |
| Chain Mail        |   800 |   70  |   10  |   30  |
| Plate Mail        |  1500 |  120  |   20  |   40  |
| Mithril Mail      |  5000 |  100  |   20  |   60  |
| Silver Plate\*    | 10000 |  100  |   15  |  100  |
| Dragon Armor\*    | 50000 |   60  |    0  |  150  |

| Shield            |  Gold | STR   |  DEX  |  DEF  |
|:------------------|------:|------:|------:|------:|
| none\*            |     0 |    0  |    0  |    0  |
| Cutter Shield     |    10 |    2  |    0  |    2  |
| Wood Shield       |    50 |    5  |    1  |    5  |
| Small Shield      |   100 |   10  |    3  |   10  |
| Round Shield      |   200 |   20  |    6  |   15  |
| Large Shield      |   500 |   30  |   10  |   20  |
| Wall Shield       |  1000 |   50  |   30  |   30  |
| Silver Shield\*   |  5000 |   20  |    5  |   50  |
| Dragon Scale Shield\*| 30000 | 10 |    0  |   50  |

\*not available in item shop

*Note:* The Gold values above are the ones internally defined for the equipment.
Most of them match the shop's buy/sell values. However the "Silver" and "Dragon" eqipment can be sold for only 5 gold. (probably to discourage the player from doing so)

For an explanation about "rolls", "rollDmg" and "baseDmg", see the section "Player Attack" below.

### Battle Algorithms

For the battle, there are separate "attack" and "defense" values.
The player's values are calculated using the equipment and character stats. They are recalculated each turn.
Monsters have fixed values set in `M1.DAT` to `M6.DAT`.

The order of turns is determined by the player's `DEX(final)` and the monster's DEX value. (There seems to be some sort of randomization to the latter.) Higher DEX means your turn starts earlier.

```
DEF(equipment) = DEF(armor) + DEF(shield)
DEF(player) = DEF(equipment) + [20 if you have Ring of Defense]
ATK(player) = floor(STR(character) / 10) + ATK(weapon)
```

#### Player Attack

Weapon attack is randomized using a Random-Number-Generator (RNG). Each weapon has 3 different properties to describe the randomization:

- base damage
- number of RNG rolls
- RNG range (results in 1..N inclusive)

The game calls the RNG `numRolls` times. Each call returns a number of `[1 .. range]`. All RNG results and the base damage are sumed together.  
Thus the effective weapon attack is `[baseDamage + numRolls*1 .. baseDamage + numRolls*range]`.

When attacking, there is 2% chance of missing, as well as a 5% chance of landing a critical hit.

Player attack, normal hit:

The monster has a chance of evading the attack. (see `sub_1EF7C`)
```
damage to monster = ATK(player) - DEF(monster)
```

Player attack, critical hit:

The monster can not evade this and the attack goes ignores the monster's defense.

```
damage to monster = ATK(player) * 2
```

When a monster gets defeated, there is a 40% chance of the player immediately attacking the next monster during the same turn.

For defeating a monster, a player gains experience points and gold. The amount is fixed per monster type, but is multiplied with the number of monsters defeated in the current battle.
This means for the first monster, you get `1*N` gold and EXP. For the second monster you get `2*N` gold and EXP, etc.

#### Monster Attack

There is a chance that the monster attack can be evaded.

The monster's attack is randomized with 3 parameters like the player's weapon.

```
damage to player = ATK(monster) - DEF(player) - DEF(guard)
```

`DEF(guard)` is an additional "defense" value that increases by a certain amount every time Fin uses the "Guard" spell.

Selecting the "Defend" action multiplies the player's defense with 2.

### Level Up

You need `20 * current level` experience points for levelling up.

When gaining a new level, your MaxHP, STR and DEX are increased by `random[5..10]`.

The following limits apply:

- maximum level: 200
- maximum HP: 999
- maximum strength: 255
- maximum dexterity: 255
