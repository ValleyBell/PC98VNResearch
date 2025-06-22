# Items

## General notes

- Items can only be used in "camp" mode. (Usage in battles was apparently intended at some point, but never made it into the game.)
- The game knows 7 different main types for items:
  - type 0: unused
  - type 1: consumables
  - type 2: special items
  - type 3: equipment - right hand
  - type 4: equipment - left hand
  - type 5: equipment - body
  - type 6: equipment - head
  - type 7: equipment - accessory
- Item types 1 and 2 feature a "sub-type" that control the specific behaviour of the items. Sub-type 0 means "not useable in camp mode".
  For equipment (item types 3..7), the value contains a bit mask describing which party member is allowed to equip the respective item.
- notes about the colums in the tables below:
  - `ID`: item ID used internally
  - `name`: name of the item from English translation
  - `price`: price at which the item can be bought in shops
    - Items can be sold at half of their price. (rounded down)
    - Items with a price of 0 can not be sold.
  - `obtain`: how the item can be obtained.
    - "S #F" - bought at a shop on floor #F
      - "(S 1F)" - only available in Sadao's Shop during the beginning of the game
    - "T #F" - found in a treasure chest on floor #F
    - "M" - created via Magic Tablet (2F)
    - "E #F" - story/side quest event that occours on floor #F
    - "H" - High/Low reward (Night Safe 777, 4F)
    - "K" - reward for talking to Kate in Noah's Bar (1F) between unlocking 5F and visiting the Siren.
    - "P" - Tea Party reward (6F)
  - `player` (equipment table): list of the party members that are allowed to equip the item
    - "Eg" - Eagle
    - "T" - Tear
    - "H" - Henzou
    - "El" - Eldelyca

## consumables

|  ID | name                    | price | obtain             | sub-type | effect        |
| ---:|:----------------------- | -----:|:--------------------- |:-----:|:------------- |
|   0 | Cheap Candy             |     5 | (S 1F)                |    1  | current HP +25 |
|   1 | Candy                   |    12 | (S 1F), P             |    1  | current HP +50 |
|   2 | Garlic                  |    45 | S 1F/4F               |    1  | current HP +100 |
|   3 | Turbo Garlic            |   170 | S 1F/4F, H            |    2  | current HP +9999 |
|   4 | Super Garlic            |   430 | S 1F/4F/6F, P         |    3  | restore all HP to all members |
|   6 | Ponky Stick             |    50 | S 1F/4F               |    4  | current MP +30 |
|   7 | Fairy Dust              |   300 | S 1F/4F/6F, P         |    5  | current MP +9999 |
|   9 | Guarana Chocolate       |   450 | S 1F/6F, P            |    7  | restore all HP and MP |
|  10 | Steamed Bun             |   200 | P                     |    8  | restore all HP, reduce Hunger Level to 0% (unused parameter 1: +100) |
|  11 | Chocolate               |    35 | (S 1F)                |    9  | Hunger Level -10% |
|  12 | Cookie                  |    39 | S 1F                  |    9  | Hunger Level -20% |
|  13 | Rice Ball               |    44 | (S 1F)                |    9  | Hunger Level -30% |
|  14 | Mom's Rice Ball         |    52 | S 1F/4F/6F, H, P      |    9  | Hunger Level -50% |
|  15 | Mabo-chin               |    82 | S 4F, H, P            |    9  | Hunger Level -80% |
|  16 | Great Mabo-chin         |   140 | S 1F/6F, H, P         |    9  | Hunger Level -100% |
|  17 | Yosaku's Rice Ball      |    50 | M, H                  |    9  | Hunger Level +50% |
|  18 | Fake Mabo-chin          |   127 | M                     |    9  | Hunger Level +50% |
|  22 | Mandrake Elixir         |   480 | S 4F, P               |   12  | heal drunk/poison status |
|  23 | Magic Nut Alpha         |    10 | T 2F, H               |   13  | maximum MP +1 |
|  24 | Magic Nut Beta          |    20 | T 6F, H               |   13  | maximum MP +2 |
|  25 | Life Berry              |    10 | T 3F, H, P            |   14  | maximum HP +3 |
|  26 | Arm Training Wraps      |    10 | T 2F, H, P            |   15  | attack +1 |
|  27 | Sage's Toenail          |    10 | T 2F, H, P            |   16  | intelligence +1 |
|  28 | Agile Berry             |    10 | T 1F/3F, H            |   17  | agility +1 |
|  29 | Strength Berry          |    10 | T 6F, H               |   15  | attack +1 |
|  30 | Wallet of Doom          |     1 | M, P                  |   21  | set current money to 1 RING |
|  31 | Devil's Breath          |     1 | M                     |   17  | agility +10 |
|  37 | Chapa Chaps             |    10 | T 4F                  |   26  | restore all HP and MP (*bug: (?)* should restore 5 HP/MP only) |
|  41 | Spirit's Blessing       |     1 | M, P                  |    8  | restore all HP, reduce Hunger Level to 0% (unused parameter 1: -100) |

## special items

|  ID | name                    | price | obtain             | sub-type | effect/use    |
| ---:|:----------------------- | -----:|:--------------------- |:-----:|:------------- |
|  32 | Sage's Scroll           |     1 | M                     |    5  | (single-use) current MP +9999 |
|  33 | Hero's Emblem           |     1 | M                     |    3  | (single-use) restore all HP to all members |
|  34 | Hunger Drum             |     1 | M                     |    9  | (single-use) set Hunger Level to 100% |
|  35 | Nightmare Whispers      |     1 | M, P                  |    0  | *unused* |
|  36 | Magic Mirror            |     1 | T 1F, P               |   23  | (single-use) teleport to 1F@1,15 (near Noah's Bar), facing west |
|  38 | Actress Autograph       |   200 | T 1F, P               |    0  | *unused* |
|  39 | Dice of Darkness        |     1 | M                     |   23  | (single-use) teleport to 1F@5,11, facing a random direction |
|  40 | Cursed Harmonica        |     1 | M, P                  |    0  | *unused* |
|  47 | Corn                    |     0 | E 1F                  |    0  | key item for main story |
|  48 | Golden Apple            |     0 | E 2F                  |    0  | key item for main story |
|  49 | Rainbow Jewel           |     0 | E 3F                  |    0  | key item for main story |
|  50 | Yutika's Horn           |     0 | E 3F                  |    0  | key item for main story |
|  51 | Diet Cookie             |     0 | E 4F                  |    0  | key item for main story |
|  52 | Drawer Key              |     0 | E 4F                  |    0  | key item for main story |
|  54 | Broken Doll Boy         |     0 |                       |    0  | key item "broken boy doll" sidequest, *bug:* unobtainable due to broken event in 6F |
|  64 | Water                   |     1 | E 3F                  |    0  | key item for main story |
|  66 | Hokekemoh Cure          |     0 | E 4F                  |    0  | key item for "curing White Lily" sidequest |
|  67 | Yutika's Earring        |     0 | E 3F                  |    0  | key item for main story |
|  68 | Rare Skull              |     0 | T 6F                  |    0  | key item for brothel H scene with "Elvira" |
|  69 | Super Rare Skull        |     0 | T 7F                  |    0  | key item for brothel H scene with "Elvira" |
|  74 | Wind Rune               |    25 | S 1F, T 1F, K         |    0  | use with Magic Tablet on 2F |
|  75 | Protection Rune         | 10000 | S 6F, T 11F, K        |    0  | use with Magic Tablet on 2F |
|  76 | Shadow Rune             |  1000 | S 4F, K               |    0  | use with Magic Tablet on 2F |
|  77 | Water Rune              |    25 | S 1F, T 1F, K         |    0  | use with Magic Tablet on 2F |
|  78 | Harmony Rune            |  1000 | S 1F/6F, T 9F, K      |    0  | use with Magic Tablet on 2F |
|  79 | Accuracy Rune           |  1000 | S 1F/4F, T 2F, K      |    0  | use with Magic Tablet on 2F |
|  80 | Fire Rune               |    25 | S 1F, T 1F, K         |    0  | use with Magic Tablet on 2F |
|  81 | Holy Rune               | 10000 | S 6F, T 3F/10F, K     |    0  | use with Magic Tablet on 2F |
|  82 | Scatter Rune            |  1000 | S 1F/4F, K            |    0  | use with Magic Tablet on 2F |
|  83 | Earth Rune              |    25 | S 1F, T 1F, K         |    0  | use with Magic Tablet on 2F |
|  84 | Light Rune              |  1000 | S 1F/4F, K            |    0  | use with Magic Tablet on 2F |
|  85 | Destruction Rune        |     1 | T 1F/6F/8F/9F/10F/11F/B1F | 0 | use with Magic Tablet on 2F, *only found in treasure chests* |
|  86 | Evil Rune               | 10000 | S 6F, T 1F/8F, K      |    0  | use with Magic Tablet on 2F |

There is also code for an unused item sub-type 22 that teleports to 1F@5,11, facing west.

## equipment

|  ID | name                  | equip. type   | price | obtain        | player  | effect        |
| ---:|:--------------------- |:------------- | -----:|:------------- |:------- |:------------- |
|  87 | Dull Sword (R)        | right hand    |    50 | T 4F          | H       | attack +1     |
|  88 | Dagger                | right hand    |     7 | S 1F          | Eg/T/El | attack +2     |
|  89 | Shortsword            | right hand    |    80 | S 1F          | Eg/El   | attack +4     |
|  90 | Kunai (L)             | left hand     |    80 | S 1F          | H       | attack +4     |
|  91 | Monkish Monk Staff    | right hand    |    70 | S 1F          | T       | attack +5     |
|  92 | Kodachi (R)           | right hand    |   100 | S 1F          | H       | attack +5     |
|  93 | Longsword             | right hand    |   180 | S 1F          | Eg/El   | attack +7     |
|  94 | Yosaku's Axe (L)      | left hand     |    40 | T 4F          | H       | attack +7     |
|  95 | Mace                  | right hand    |   200 | T 3F          | T/El    | attack +8     |
|  96 | Water Gun             | right hand    |    21 | T 4F          | Eg/T/El | attack +10    |
|  97 | Shuriken (L)          | left hand     |   600 | S 4F          | H       | attack +10    |
|  98 | Evil Sword            | right hand    |    30 | T 5F          | El      | attack +10, key item for brothel H scene with "Ashley" |
|  99 | Iron Pipe             | right hand    |    30 | T 4F          | Eg/T/El | attack +12    |
| 100 | Ninja Sword (R)       | right hand    |   800 | S 4F          | H       | attack +12    |
| 101 | Rapier                | right hand    |   900 | S 4F          | El      | attack +15    |
| 102 | Master Sword          | right hand    |  1000 | S 4F          | Eg      | attack +16    |
| 103 | Shadow Sword (R)      | right hand    |  2500 | S 6F          | H       | attack +18    |
| 104 | Scimitar              | right hand    |  1200 | S 4F          | El      | attack +19    |
| 105 | Jitte (R)             | right hand    |   800 | T 7F          | H       | attack +19    |
| 106 | 卍 Shuriken (L)       | left hand     |  1800 | S 6F          | H       | attack +19    |
| 107 | Demon Slayer          | right hand    |  3000 | S 6F          | El      | attack +22    |
| 108 | Aqua Sword            | right hand    |   100 | T 5F          | Eg/El   | attack +22    |
| 109 | Harp of The End       | right hand    |  1200 | S 4F          | T       | attack +22    |
| 110 | MC Hammer             | right hand    |   500 | T 6F          | Eg      | attack +25    |
| 111 | Staff of Joy          | right hand    |   620 | T 5F          | T       | attack +25    |
| 112 | Dancing Fire Sword    | right hand    |  1000 | T 7F          | El      | attack +29    |
| 113 | Storm Sword           | right hand    |  4000 | S 6F          | Eg      | attack +30    |
| 114 | Angel Mace            | right hand    |  2000 | S 6F          | T       | attack +30    |
| 115 | Blazing Sword         | right hand    | 10000 | M             | El      | attack +35    |
| 116 | Knight Sword          | right hand    |  3000 | M             | Eg      | attack +35    |
| 117 | Acala's Sword (L)     | left hand     |  5000 | T 12F         | H       | attack +36    |
| 118 | Ultra Shuriken (L)    | left hand     | 10000 | T B1F         | H       | attack +39    |
| 119 | Moonlight Staff       | right hand    |  1000 | T 7F          | T       | attack +40    |
| 120 | Zantetsuken (L)       | left hand     | 10000 | M             | H       | attack +45    |
| 121 | Ghostly Sword (R)     | right hand    |     0 | E 8F          | H       | attack +60    |
| 122 | Tsukimaru (L)         | left hand     |     0 | M             | H       | attack +70    |
| 123 | Phantom Staff         | right hand    | 20000 | M             | T       | attack +70    |
| 124 | Crimson Sword         | right hand    | 20000 | (M)           | El      | attack +80, unobtainable due to a bug in the game |
| 125 | Yutika's Staff        | right hand    |     0 | E 10F         | T       | attack +85    |
| 126 | Ferio Sword           | right hand    |     0 | E 9F          | El      | attack +90    |
| 127 | Hero's Sword          | right hand    | 30000 | M             | Eg      | attack +110   |
| 128 | Riot Saber            | right hand    |     0 | E 11F         | Eg      | attack +120   |
| 148 | Small Shield          | left hand     |    15 | S 1F          | Eg/El   | defense +2    |
| 149 | Stylish Bracelet      | left hand     |    40 | S 1F          | T       | defense +2    |
| 150 | Heater Shield         | left hand     |    50 | S 1F          | Eg/El   | defense +3    |
| 151 | Charming Bracelet     | left hand     |   150 | S 4F          | T       | defense +4    |
| 152 | Large Shield          | left hand     |   190 | T 1F          | Eg      | defense +5    |
| 153 | Arm Shield            | left hand     |    90 | T 4F          | El      | defense +5    |
| 154 | Master Shield         | left hand     |   400 | S 4F          | Eg      | defense +7    |
| 155 | Crystal Bracelet      | left hand     |  1000 | S 6F          | T       | defense +7    |
| 156 | Angel's Bracelet      | left hand     |   900 | T 7F          | T       | defense +10   |
| 157 | Aqua Shield           | left hand     |   400 | T 5F          | Eg/El   | defense +10   |
| 158 | Storm Shield          | left hand     |  2000 | S 6F          | Eg      | defense +13   |
| 159 | Knight Shield         | left hand     |  3000 | M             | Eg      | defense +18   |
| 160 | Magic Flame Shield    | left hand     |  3000 | M             | El      | defense +18   |
| 161 | Phantom Bracelet      | left hand     | 10000 | M             | T       | defense +23   |
| 162 | Hero's Shield         | left hand     | 10000 | T B1F         | Eg      | defense +25   |
| 163 | Earth Soul            | left hand     | 10000 | T 10F         | T       | defense +25   |
| 164 | Crimson Shield        | left hand     | 10000 | T B1F         | El      | defense +25   |
| 165 | Shield of Justice     | left hand     | 10000 | T 7F          | Eg      | defense +30   |
| 166 | Flame Soul            | left hand     | 10000 | T 9F          | El      | defense +30   |
| 170 | Clothes               | body          |     3 | S 1F          | any     | defense +1    |
| 171 | White Tuxedo          | body          |   350 | S 6F          | Eg/H    | defense +1, key item for main story |
| 172 | Black Tuxedo          | body          |   350 | S 6F          | Eg/H    | defense +1, key item for main story |
| 173 | White Dress           | body          |   350 | S 6F          | T/El    | defense +1, key item for main story |
| 174 | Black Dress           | body          |   350 | S 6F          | T/El    | defense +1, key item for main story |
| 175 | Pretty Dress          | body          |    75 | S 1F          | T       | defense +2    |
| 176 | Leather Armor         | body          |   120 | S 1F          | Eg/El   | defense +3    |
| 177 | Monkish Monk Robes    | body          |   100 | S 1F          | T       | defense +4    |
| 178 | Rainbow Dress         | body          |     0 | E 3F          | T       | defense +5, key item for main story |
| 179 | Training Attire       | body          |   200 | S 1F          | H       | defense +5    |
| 180 | Trenchcoat            | body          |   250 | S 4F          | Eg/H    | defense +6    |
| 181 | Chainmail             | body          |   300 | S 1F          | Eg/El   | defense +6    |
| 182 | Cat Pajamas           | body          |   400 | S 4F          | T/El    | defense +8    |
| 183 | Yosaku's Coat         | body          |   600 | T 4F          | H       | defense +9    |
| 184 | Master Armor          | body          |   700 | S 4F          | Eg      | defense +10   |
| 185 | Waitress Outfit       | body          |   600 | S 4F          | T/El    | defense +10   |
| 186 | Black Robes           | body          |  3500 | T 5F          | H       | defense +13   |
| 187 | Aqua Armor            | body          |  3500 | T 5F          | Eg/El   | defense +15   |
| 188 | Charming Dress        | body          |  1800 | S 6F          | T       | defense +15   |
| 189 | Ninja Attire          | body          |  3000 | S 6F          | H       | defense +17   |
| 190 | Armor of The Sun      | body          |  5000 | S 6F          | El      | defense +18   |
| 191 | Angel's Robes         | body          |   800 | T 7F          | T       | defense +19   |
| 192 | Storm Armor           | body          |  6000 | S 6F          | Eg      | defense +20   |
| 193 | Maid Outfit           | body          |     1 | M             | T/El    | defense +20   |
| 194 | Illusory Robes        | body          |  4900 | M             | H       | defense +20   |
| 195 | Phantom Dress         | body          |  7600 | T B1F         | T       | defense +35   |
| 196 | Iga Robes             | body          |  7700 | M             | H       | defense +38   |
| 197 | Earth Lord Robes      | body          | 20000 | T 12F         | T       | defense +38   |
| 198 | Water Lord Robes      | body          | 20000 | T 12F         | H       | defense +43   |
| 199 | Hero's Armor          | body          |  7200 | T B1F         | Eg      | defense +45   |
| 200 | Crimson Armor         | body          |  7900 | T B1F         | El      | defense +47   |
| 201 | Wind Lord Armor       | body          | 20000 | T 12F         | Eg      | defense +50   |
| 202 | Fire Lord Armor       | body          | 20000 | T 12F         | El      | defense +50   |
| 219 | Face Mask             | head          |     4 | S 1F          | any     | defense +1    |
| 220 | Ribbon                | head          |    45 | S 1F          | T/El    | defense +3    |
| 221 | Headband of Joy       | head          |    30 | T 3F          | T       | defense +4    |
| 222 | Hood                  | head          |    63 | T 3F          | H       | defense +4    |
| 223 | Hard Hat              | head          |     2 | T 4F          | any     | defense +6    |
| 224 | Cat Hat               | head          |   150 | S 4F          | T/El    | defense +6    |
| 225 | Yosaku's Towel        | head          |    13 | T 4F          | H       | defense +6    |
| 226 | Master Helmet         | head          |   400 | S 4F          | Eg      | defense +7    |
| 227 | Black Hood            | head          |  3100 | T 5F          | H       | defense +8    |
| 228 | Searing Helmet        | head          |   900 | M             | El      | defense +8    |
| 229 | Aqua Helmet           | head          |   900 | T 5F          | Eg/El   | defense +9    |
| 230 | Silver Headband       | head          |   600 | T 5F          | T       | defense +10   |
| 231 | Storm Helmet          | head          |  1000 | S 6F          | Eg      | defense +11   |
| 232 | Genji's Headband      | head          |  1600 | S 6F          | H       | defense +12   |
| 233 | Red Dragon Helmet     | head          |  2000 | S 6F          | El      | defense +13   |
| 234 | Angel's Ribbon        | head          |   700 | S 6F          | T       | defense +14   |
| 235 | Crimson Helmet        | head          |  7100 | T B1F         | El      | defense +18   |
| 236 | Ruby Circlet          | head          |  7000 | T 12F         | El      | defense +20   |
| 237 | Phantom Tiara         | head          |  7700 | T B1F         | T       | defense +21   |
| 238 | Iga Hood              | head          |  7100 |               | H       | defense +22, unobtainable |
| 239 | Hero's Helmet         | head          |  8100 | M             | Eg      | defense +23   |
| 240 | Wind Soul             | head          |  7000 | T 11F         | Eg      | defense +25   |
| 241 | Diamond Circlet       | head          |  7000 | T 12F         | T       | defense +25   |
| 242 | Water Soul            | head          |  7000 | T 8F          | H       | defense +25   |
| 252 | Coin of Power         | accessory     |  2000 | S 1F          | Eg/H    | attack +3     |
| 253 | Expert Briefs         | accessory     |  5500 | M             | Eg/H    | attack +3     |
| 254 | Expert Panties        | accessory     |  5500 | M             | T/El    | attack +3     |
| 255 | Ring of Strength      | accessory     | 13000 | T 12F         | any     | attack +3     |
| 256 | Hero's Briefs         | accessory     | 30000 | M             | Eg      | attack +3     |
| 257 | Stylish Panties       | accessory     |  1000 | S 4F          | T/El    | defense +1    |
| 258 | Master Briefs         | accessory     |  2000 | S 4F          | Eg      | defense +2    |
| 259 | Sexy Lingerie         | accessory     |  3700 | S 4F          | T/El    | defense +3    |
| 260 | Yosaku's Fundoshi     | accessory     |  3000 | S 4F          | H       | defense +3    |
| 261 | Ring of Dispelling    | accessory     |  5000 | T 1F, M, H    | any     | defense +5    |
| 262 | Marine Crystal        | accessory     | 13000 | M             | any     | attack +10, defense +10 |
| 263 | Ring of Life          | accessory     | 13000 | T 12F         | any     | defense +10   |
| 264 | Hero's Cloak          | accessory     | 20000 | T B1F         | Eg      | defense +15   |
| 265 | Phantom High Heels    | accessory     | 20000 | M             | T       | defense +15   |
| 266 | Bewitching Bikini     | accessory     | 30000 | M             | T/El    | defense +20   |
| 267 | Iga Fundoshi          | accessory     | 30000 | M             | H       | defense +20   |
| 268 | Agile Piercings       | accessory     |  2000 | S 1F          | T/El    | agility +1    |
| 269 | Ring of Agility       | accessory     | 20000 | T 12F         | any     | agility +10   |
| 270 | Iga Scarf             | accessory     | 20000 | T B1F         | H       | agility +15   |
| 271 | Crimson Wings         | accessory     | 20000 | T B1F         | El      | agility +15   |
| 272 | Charm of the Stars    | accessory     | 50000 | T B1F         | any     | attack +37, defense +37, agility +37 |
