# Mime Walkthrough

A (mostly) spoiler-less walkthrough of MIME by Valley Bell.

Playtime for 95% (all sidequests + dialogues, without bonus dungeon): 24h 30min

General notes:

- Each floor will have a recommended level that Eagle and his party should have.  
  If you are underlevelled, the enemies may easily kill your party, so it is recommended to grind until you reach the respective level.
- Each character and most enemies have a certain element. During this hour, the stats of the respective character or enemy will be increased significantly. For example Eagle will be stronger during the "Wind Hour".  
  The attribute boost (+50% to attack, defence, intelligence and agility) can cause the character/enemy to do twice as much damage or dodge almost all attacks.  
  Entering a boss battle during the enemy's hour can make it nearly unwinnable. But entering it during your player character's hour can make it a piece of cake.
- This guide's level requirements generally assume that (a) you don't use attack spells and (b) enter battles at a "neutral" hour.  
  You can use both to your advantage and to beat bosses with lower levels than listed here.
- Note: "Watoku" in Noah's Bar may tell you that enemies get a strength boost at the "Evil" hour, but that is not true. (possibly unfinished programming)
- Most locations get new dialogues after every major story event. If you don't want to miss anything, you should regularly take detours and re-visit old locations like Noah's Bar and the Old Tree.
  Even events happening on floor 5 cause new dialogues on floor 1.
- Map locations have their coordinates annotated using "@X,Y" or "@floor:X,Y". @0,0 is the upper left edge of the map, @15,15 is the lower right edge of the map.
- Internal register values are annotated using "*(rXXX = value)*" These are part of saved games. They are not important for a playthrough, but may be useful know when an event has been missed.
  Whenever "r100..r171" are set, most locations get new dialogues.

Battle hints:

- When monsters "avoid the attack" regularly, then your agility (normal attack) or intelligence (spells) is too low.
- When monsters "don't take any damage", then your attack is too low.
- Some monsters are strong against normal attacks, but weak against spells.
- Characters (and monsters) with a high agility will attack first.  
  Tip: Increasing Tear's agility helps with boss battles, as you can heal before the bosses do the damage.

## Character building

After starting a new game, you have to build your character by going through the initial maze and answering questions.
Depending on your answers, one of the following stats gets raised:

- HP, starting with 12
- MP, starting with 7
- Attack, starting with 2
- Defense, starting with 1
- Intelligence, starting with 1
- Agility, starting with 2

A good choice for the beginning is to increase HP and attack. MP and intelligence are useless at the beginning of the game, as you start without spells.

An example path would is:

- go west, then answer the question "Who does the clock belong to?" with "Me" (Attack +1)
- question "Flowers are blooming. What do yo do?", answer "I smell them" (HP +1)
- question "Where is the eye looking at?", answer "My body" (Attack +1)
- question "Who is trying to wake you up?", answer "A family member" (HP +1)

## 1F

Recommended level: 1

Floor notes:

- Beware of the "B68000" enemy. It is pretty strong and barely possible to hit at level 1. If you can't talk to it, just flee with the "Back Away" method.

Guide:

- You wake up in Noah's Bar @9,15. Pick up the 100 RING. (It's free money and there are no consequences.)
- Go to Sadao's Shop @2,12 (1 step forward, 3 steps to the left) and buy equipment:
  - Shortsword (80 RING, attack +4)
  - Small Shield (15 RING, defense +2)
- After leaving the shop, open the Camp menu and equip the new items.
- Go to Tirolian's Den @0,0 and talk to the Tirolian. *(r107 = 1)*
- Visit the following locations in any order:
  - The Old Tree @9,15: Listen to the story once. *(r102 = 1)*
  - Flower Field @12,14: Say that you don't know about the princess of the Phantom Castle. *(r103 = 1)*
  - Flower Queen @10,10: Tell her that you are a humble squire. *(r105 = 1)*
    - You may want to say "Give me hints" first to get information about useful items located nearby.
  - Black/White Lily @15,0: Talk to them. The choices don't matter. You can even select "Leave". *(r106 = 1)*
- Go back to Tirolian's Den @0,0 and talk. It will complain about you being persistent. *(r107 = 2)*
- (optional) go through all dialogues at "The Old Tree", "Flower Field", "Flower Queen" and "Black/White Lily", as the next action will advance all dialogues.
- Talk to Tirolian and "pay the toll". *(r100..r171 = 5)*
- Visit the Flower Queen @10,10. Tell her about Tirolian and she will give you "Corn".
- Go to Tirolian's Den @0,0 and "pay the toll". Then a new door on the other side of Tirolian's Den will appear. In its corridor you will find a rope that leads to 2F.
- Climb up the rope @2,2 to 2F. *(r100..r171 = 20)*

## 2F

Recommended level: 4

- Visit The Three Dwarfs @15,3. Help them with their investigation. *(r120 = 21)*
- Go to the Phantom Castle @7,13 and listen to Maid Toppo's story. *(r121 = 21)*
- Visit The Three Dwarfs @15,3 again to get information about curing the illness. *(r120 = 22)*
- Go back to the Phantom Castle @7,13 and talk to Maid Toppo. When asked to get the "Golden Apple", choose anything *but* "in love with Maid Toppo". *(r121 = 22)*  
  "You can do it yourself" has the longest and funniest dialogue.
- (optional) Pick up a "Large Shield" @1F:9,12. You reach it from the stairs @2F:11,14.
- Grind until you reach at least level 6. With lower levels you won't stand a chance against the next boss.
- Go to "Golden Apples" @14,14 and defeat "Nekomata" (152 HP) to get a Golden Apple. *(r121 = 23)*
  - Note: Nekomata has the earth element. Thus you should avoid taking the battle at "Earth Hour".
- Deliver it to the Phantom Castle @7,13. *(r121 = 24)*
- When you try to leave to the north @7,11, Tear will join your party. She starts with level 5. *(r100..r171 = 25)*
  - From here on, Tear will translate text written in the ancient language for you. (except for monster talk)
  - fun fact: You can actually bypass her by going backwards. (or using an illusory wall in the south-west of the castle) The game won't let you enter 3F without her though.
- As Tear starts without equipment, you should buy her some.
  - "Monkish Monk Staff" (70 RING, attack +5)
  - "Stylish Bracelet" (40 RING, defense +2)
  - "Monkish Monk Robes" (100 RING, defense +4)
  - "Ribbon" (45 RING, defense +3)
- (recommended) If you have the money, buy Earth Rune stones until you have 6.  
  Then go to the Magic Tablet @2F:2,0, place all 6 Earth Rune stones (green) there and press the button with the arrow so that Tear learns the "Shem" spell. (healing)
  - hint: Due to incomplete game programming, the spell heals everyone outside battle.
- (optional) If you have even more money, you can buy 6 Wind Rune stones. With those, Eagle can learn the "Gardas" spell, which is a very strong attack spell for your current level.
- Grind until Tear reaches level 6. (This is not mandatory, but recommended for a better balanced party.)
- Then go to "Golden Apples" @14,14 and climb up the rope to 3F.
- Upon leaving the rope, Henzou will join the party. He starts with level 7. *(r100..r171 = 30)*
- Before you continue, go back to Sadao's Shop @1F:2,12 and buy some equipment for Henzou.
  - Kodachi (R) (100 RING, attack +5)
  - Kunai (L) (80 RING, attack +4)
  - Training Attire (200 RING, defense +5)
  - Face Mask (4 RING, defense +1)

## 3F

Recommended level: 8

Floor notes:

- Beware of the "Ouchie Turtle" enemy. If you are unable to hit it, just flee from the battle.

Guide:

- Go to Akko-chan @2,6 and get "Water".
- Go to Slug's Nest @13,1 and tell Auger you have "Compassion". Then give him "Water". *(r132 = 31)*
- Visit the Unicorn Spring @1,3 and talk. *(r133 = 31)*
- Go back to Slug's Nest @13,1 and talk. *(r132 = 32)*
- Enter again and talk to Auger. He will ask you to wait while he is making a dress. *(r286 = 1)*
- Go to Antonio's Inn @1F:3,14 and sleep to get a cutscene with Tear. *(r132 = 33, r286 = 2)*
- Go to Slug's Nest @3F:13,1 again and obtain the "Rainbow Dress". *(r132 = 34)*
- Equip the "Rainbow Dress".
- Go to the Unicorn Spring @1,3 and talk to Yutika. Choose to "fight the monster" and you will obtain "Yutika's Earring", which allows you to pass Tenko-chan. *(r100..r171 = 35)*
- Grind until you reach level 10 with Eagle and Henzou. (If you enter the boss at "Wind" or "Water" hour, level 9 should also be possible.)
- Go to the boss room @0,0 and beat the "Chimera" (259 HP) to get "Yutika's Horn". *(r100..r171 = 40)*
  - Chimera has the water element, so entering the battle during the "Water Hour" is a bad idea.
- Return to Slug's Nest @13,1 and get the "Rainbow Jewel". *(r132 = 41)*
- Go to the "closed-off tree trunk" @2F:7,8 and look north. Eldelyca will join the party. She starts with level 10. *(r100..r171 = 45)*
- Finally go to the now-open location "Window Girl" @7,7, which allows you to teleport between the various mazes.
- Before you continue to 4F, go back to Sadao's Shop @1F:2,12 and buy some very basic equipment for Eldelyca.  
  The next floor has a new shop with better but more expensive items.
  - "Longsword" (180 RING, attack +7)
  - "Heater Shield" (50 RING, defense +3)
- You may also want to buy 6 Fire Rune stones, go to the Magic Tablet @2F:2,0 and learn Eldelyca's "Terrias" spell.
- Note: Once Eldelyca is in your party, the "Adult Picture Book" sidequest is available.

## 4F

Recommended level: 12 (level 11 can work with good equipment)

Floor notes:

- You can encounter an enemy called "Coins" on this floor, which gives you 1000 RING and is good for grinding money.

Guide:

- Go to "Twins Toy Shop" @0,11 and buy additional equipment for Eldelyca.
  - "Cat Pajamas" (400 RING, defense +8)
  - "Cat Hat" (150 RING, defense +6)
- Go to the Drawer Girl @9,1 and talk. Choose to "open the drawer". *(r144 = 46)*
- Go to the Candy House @4,13 and talk to Sugar Ann.
- Enter the Candy House again and talk. Agree to search for the "Diet Cookie".
- Visit the Totem Pole @12,4 and win the "Coin Game".
  - You can win the game by taking all 3 Sun Coins, then 1 Star Coin, then the remaining 2 Star Coins.
  - After winning, you obtain a "Diet Cookie".
- Visit the Candy House @4,13 and talk. Sugar Ann will take the "Diet Cookie" give you the "Drawer Key" as a reward.
- Grind until you are ready for 5F.
- Note: By now you should have enough money to buy some of the strong equipment offered in the "Twins Toy Shop". Good choices are:
  - Master Sword, Master Shield, Master Armor (Eagle)
  - Harp of The End, Charming Bracelet, Waitress Outfit (Tear)
  - Ninja Sword, Shuriken (Henzou)
  - Scimitar, Waitress Outfit (Eldelyca)
- Go to the Drawer Girl @9,1 and use the "Drawer Key" to free her. *(r100..r171 = 50)*
- Enter the drawer to warp to @5F:5,1

## 5F

Recommended level: 15 (or level 14 with good equipment)

Floor notes:

- You can encounter an enemy called "Twins" on this floor, which gives you 1200 RING and is good for grinding money.
- The enemies "Water Flea" and "Plankton" may be strong against physical attacks, but they are are weak against spells.
- The same is true for "Happy Clam" and "Crazy Clam".
- All enemies on this floor (except "Twins") have the water element. Be careful when encountering anything during the Water Hour.

Guide:

- Visit the following locations in any order:
  - Banshee's Spring @9,11: approach *(r1156 = 51)*
  - Sad Wall @15,14: Talk. It doesn't matter who touches it or if anyone touches it at all.  
    Then tell it a sad memory. ("I have no sad memories" will end up in a loop.) *(r150 = 51)*  
    You will be teleported to @5,4.
  - Crystal Forest @3,5: Talk to Alaia.
    - The choice regarding on whose behalf you search for the gemstone will increase their trust level slightly, but doesn't matter otherwise.
    - You will take a rest, whether or not you agree to it.
    - Then look for Tear. *(r153 = 52)*
    - Tip: After this event, you can rest in the Crystal Forest anytime. Resting here will not only restore HP/MP, but also reset the hunger level.
  - Fishman's Tank @8,2: Choose to "look inside the tank", then talk *(r151 = 51)*
  - Desert Spring @11,6: Talk once. The choice of killing monsters or not doesn't matter. *(r155 = 51)*
- (optional) You can find an "Evil Sword" in a treasure chest @13,11. This is the key item for the brothel H scene with "Ashley".
- (optional) If you visit Noah's Bar @1F:9,15 and talk to Kate, she tells you that she found something and gives it to you.  
  There is an 88% chance that what she found is just a normal rock (which won't be added to your inventory), but there is a 1/100th chance for each of the following rune stones:
  - Wind Rune
  - Protection Rune
  - Shadow Rune
  - Water Rune
  - Harmony Rune
  - Accuracy Rune
  - Fire Rune
  - Holy Rune
  - Scatter Rune
  - Earth Rune
  - Light Rune
  - Evil Rune
  This works until you visit the Siren the first time.
- trivia: The "springs" where you can drink from have a 1/16 chance of making your drunk instead of restoring HP. The "drunk" status will remain for 64 steps. (2 hours)
- Go to Siren's Point @14,1. Yell anything. When you hear a song, choose to "go to the point".
  - Tell the siren you are "Adventurers". Then choose any song to sing. After Tear begins to sing, you need to wait 5 seconds before you can continue.
  - The siren will steal Tear's voice and throw you out. *(r100..r171 = 55)*
- Grind until every character is at least level 16. (Or level 17, if you want to have reasonable success with attack spells on the next boss.)
- Go to back to Siren's Point @14,1. Choose "Go to the Siren's Point", then "Fight the Siren"
- Defeat the Siren (798 HP, water element). *(r100..r171 = 60)*
- Note: Talking to Tirolian after this point or getting the cutscene with Henzou will lock you out of any brothel scene until you have defeated the final boss.

## 6F

Recommended level: 20 (Level 19 works if you use magic spells on the harder enemies.)

- Go to "Donkey's Shop" @5,15.
  - (optional) Buy some better equipment. You should have plenty money by now. Good choices are:
    - Storm Sword, Storm Armor, Storm Shield, Storm Helmet (Eagle)
    - Angel Mace, Charming Dress, Crystal Bracelet, Angel's Ribbon (Tear)
    - Shadow Sword (R), 卍 Shuriken (L), Ninja Attire, Genji's Headband (Henzou)
    - Armor of the Sun, Red Dragon Helmet (Eldelyca)
    - Note: Instead of buying the Demon Slayer for Eldelyca, you can equip the Aqua Sword, if you found it on 5F. Both have the same attack value.
  - Buy a "White Tuxedo" and a "Black Tuxedo", both for Eagle.
  - Buy a "White Tuxedo" or "Black Tuxedo" for Henzou.
  - Buy a "White Dress" or "Black Dress" for Tear and Eldelyca. (You need only 1 dress for both. You don't need to equip one on both at the same time.)
- Visit the following locations in any order:
  - Stone Statue @10,12: Talks once. *(r163 = 61)*
  - Photo Gallery @10,7: Talk once. The choice ("jealous" vs "bitter") doesn't matter. *(r168 = 61)*
  - Tea Party @9,1: Talk. Read 4 poems, then leave. *(r166 = 61)*
    - Note: It doesn't matter if the same character does all 4 poems or if each does one. The game only counts the number of poems read.
  - Dream Author @2,2: Talk once. *(r160 = 61)*
    - Then go to the Movie Theater @5,10. Talk once. The choice doesn't matter. *(r161 = 61)*
    - (optional) Go between the Dream Author and Movie Theater a few more times to deliver the script.
  - Black Ball @14,1 and White Ball @1,14
    - You need to enter each of them at least once.
    - When you are asked who will enter the ball, choose a partner.
    - Note that in order to be able to enter:
      - Eagle must wear a "Black/White Tuxedo". ("wear" means "equipped", not just in your inventory)
      - Your partner must wear a "Black/White Tuxedo/Dress".)
    - If you just want to progress in the story, you can leave immediately. *(Black Ball: r162 = 61, White Ball: r165 = 61)*
    - (optional) You can dance or eat to raise the trust level with your partner.
      Each time you do one of the activities, the trust level gets raised by 1. You can repeat the activities without needing to re-enter the ball.
    - Note that the Black/White Ball is only available until the 7F boss fight.
- Go to Antonio's Inn @1F:3,14 and sleep to get a cutscene with Henzou. *(r286 = 4, r100..r171 = 65, r299 = 65)*
- Now go to @6F:15,15 and climb the rope that leads to 7F. *(r100..r171 = 70, r299 = 70)*
- (optional) You can find a "Rare Skull" in a treasure chest @6,4. This is the first key item for the brothel H scene with "Elvira".

## 7F

Recommended level: 21

- (optional) You can find a "Super Rare Skull" in a treasure chest @2,1. This is the second key item for the brothel H scene with "Elvira".
- Make your way to the middle of the map and enter the location "Spider Woman" @7,7.
- Decipher the writing, then leave all your items there. After that, fight Arachne.

## 8F/9F/10F/11F

- Note: After this point, the next time you sleep at Antonio's Inn you will get a special cutscene with Eldelyca.
- At the stone tablet @7F:7,7 and touch the tablet. Whoever touches it determines what floor you will be warped to.
  - Henzou → 8F Sea Maze
  - Eldelyca → 9F Flame Maze
  - Tear → 10F Earth Maze
  - Eagle → 11F Wind Maze
- On each floor, there is another stone table just straight ahead.
- In order to complete each floor, you have to decipher the writing of the floor's stone tablet.
  On all floors but 10F you will have to defeat a guardian beast after that. On Tear's floor you there is no boss.
  You will receive a special character-specific weapon after completing the event. Make sure to equip it, because it is very strong.
- Tip: On each floor, you can find a "Soul" of the maze's element. These can be equipped and will give the character a massive defense boost.
  (The level requirements below will assume you *didn't* equip them though.)
- Recommended levels:
  - 8F:
    - normal enemies: 26
    - boss: 28 (4594 HP, water element)
  - 9F:
    - normal enemies: 28
    - boss: 33 (6050 HP, fire element)  
      Note: It has a 30% chance of using a multi-target attack. This makes the battle's difficulty depend on RNG more than usual.
  - 10F:
    - normal enemies: 29
  - 11F:
    - normal enemies: 30
    - boss: 37 (9555 HP, wind element)
- When you got all 4 special weapons, go to the stone tablet @7F:7,7 again and make all 4 touch the tablet at once. *(triggers new dialogues in Noah's Bar/Divination Room when bugfixed)*
- Note: You can complete the floors in any order, but it is recommended to do them in order.
  The agility of the monsters increases with each floor, making them harder to hit.
  Physical attack/defence is roughly the same from 8F to 11F though. Monsters on floor 10F/11F have a bit more HP.

## 12F

Recommended level: 38 (maybe 36/37?)

- talk to these people in any order (choices don't matter):
  - Star Weaver @0,7 *(r112 = 121)*
  - Story Teller @7,14 *(r113 = 121)*
  - Star Gazer @14,7 *(r114 = 121)*
  - When talking to the last character *(r100..r171 = 125)*, the story advances and you can continue. (Only Noah's Bar and the Divination Room get new dialogues.)
- Make sure to open the 4 treasure chests in the main square on 12F and equip the Wind Lord Armor / Earth Lord Robe / Water Lord Robe / Fire Lord Armor. They will boost your defense.
- Touch the tablet @7,0. You will be teleported to the lower right edge of the map.
- There are treasure chests to the left and right. You should equip the "Diamond Circlet" and "Ruby Circlet".
- Grind until every character is at least level 39. (38?)
- Make sure that Tear has the "Shelt" spell, which heals 300 HP. (requirements: 4x Earth Rune, 2x Light Rune)
- Go south to @13,15 and defeat Arachne. (8040 HP) *(r115 = 126)* She gives you lots of experience, so you will get at 1 or 2 level ups.
- Take the stairs to 13F.

## 13F

Recommended level: 41

- Grind on 12F until every character is at least level 41. Also make sure that Tear has at least 300 MP left so you can heal during the next battle.
- Go north and enter the Sanctuary @7,2. Defeat the Goddess. (10987 HP) (Choosing to "Run" will end in fighting as well.)
- Make sure that you have these spells:
  - Henzou: "Shuuha Shijin" (3x Water Rune, 1x Shadow Rune, 1x Accuracy Rune, 1x Evil Rune), heals 100 HP
  - Eldelyca: Fraid/Shelks/Flamer will all make the final battle easier/shorter, but are optional.
- Grind on 12F until every character is at least level 45. (Level 43 should be doable, but will require some luck.)
- *IMPORTANT:* Save the game now.
- (optional) If you want to enter the bonus dungeon B1F later, grind everyone to at least level 46. (You can't do that later anymore.)
- Enter the Sanctuary @7,2 again and defeat "Great God Aus". (16090 HP) *(r100..r171 = 130)*
  - Hints:
    - Use Eldelyca's "Flamer" spell for a massive 1500 damage. (almost 1/10th of his total HP!)
    - Eagle's "Liger" spell also does more damage than his usual attack. ("Silas" should be weaker than his usual attack by now.)
    - Try to keep everyone over 250 HP if possible, so that they survive a strong attack.
    - The boss is beatable without spells at level 45, but you may run out of MP for healing at the end of the battle.
- After the battle, choose "Return to the maze".
- Defeating the boss will cause a few things:
  - enable access to the bonus floor B1F
  - disable monster encounters on *all floors* but B1F
  - change most locations (most of them are empty and lifeless now)
  - unlock the brothel

## Ending

- When you are finished with everything you want to do in the game, go back to 13F@7,2 and choose "Go outside".
- Congratulations - you beat the game! Enjoy the nice ending scene.
- Note: You can get slightly different endings depending on your "trust level" with the other party members.  
  The one with the highest trust level will get additional dialogue and wake up last.

## Bonus: B1F

Recommended level: 48

- This floor has very, very strong enemies. And since you can not grind levels in other floors anymore, you MUST be on a sufficient level to survive here.
- There are 13 treasure chests on this floor that contain various equipment.
- The floor contains 4 traps that will poison one of your party members. (It is the only floor to have poison traps.)  
  Poison can be healed using Henzou's "Kousui Kouhi", but it also wears off after 64 steps. It has no effect inside battles.
- It is a mess of teleports and really hard to navigate:
  - Almost every apparent dead-end has a teleport. (most of them are 2-way though)
  - The whole entire upper left section consists of 1-way teleports.
- These two enemy groups are extra hard and you will need to level up more to even have a chance to hit them:
  - Demon Spider (12030 HP) + Chimera Master (18920 HP, earth element), requires level 55
  - God Eater (25000 HP), requires level 63

## Sidequests

### Adult Picture Books

- Find the 5 books in any order at the following locations on floor 2F (upper left edge around the rope) and choose to "see what's inside":
  - @0,1
  - @0,3
  - @2,4
  - @4,1
  - @4,3
- visit the following two locations on floor 1F for some additional dialogue:
  - @10,8
  - @10,12

### Curing White Lily

- After fighting Arachne the first time, visit the Totem Pole @12,4.
- Clear the medicine mixing puzzle to receive the "Hokekemoh Cure". (see "Totem Pole minigames" section for details)
- Visit Black/White Lily @1F:15,0 and give her the medicine.

### Music Box Girl/Boy

- visit @6F:7,10 and take the doll
- visit @4F:8,13
- From now on, you can use the "Music Box" at @4F:8,13 to listen to all of the songs.
- Note: The quest is broken in the original game. Taking the boy doll only advances the dialogue in `A607_.DAT`, but won't give you the "Broken Doll Boy" item that you need for completing the quest in `A405_.DAT`.

### Totem Pole minigames

1. Coin Game (story counter: 45)
  - Instructions:
    - We have here 3 different sets of coins, 3 “Sun” coins, 3 “Moon” coins, and 3 “Star” coins. 9 coins in all.
    - You may take away 1-3 coins from each set, and whoever takes the last coin loses...
    - Both players must start with the “Sun” coins and only take coins away from that set!
  - Solution:
    - Take 3 Sun Coins
    - Take 1 Star Coin
    - Take 2 Star Coins
2. Digits (story counter: 60)
  - Instructions:
    - A consists of 3 consecutive digits.
    - B is 2 behind A.
    - C is twice as large as B, but smaller than A's smallest digit.
    - And D is a number 2 greater than C squared.
  - Solution:
    - A = 3·4·5
    - B = 1
    - C = 2
    - D = 6
3. Equation (story counter: 70)
  - Instructions:
    - Think of the following equations. Subtract R from P to get B, add B to Y to get G.
    - Now then, B is made from subtracting R from P, but what is made when R is added to B?
    - Now then, what is made when R is added to Y?
    - Now then, what is made when B is added to Y?
    - Now then, what is the nature of these equations?
  - Solution:
    - R + B = P (red + blue = purple)
    - R + Y = O (red + yellow = orange)
    - B + Y = G (blue + yellow = green)
    - The nature: Color
4. Medicine (story counter: 75)
  - Instructions:
    - There are four ingredients to make the medicine...
    - The four ingredients are Otone Berries, Kerogero Leaves, an Ugege's Tail, and Magimara Wine.
    - The Otone Berries cancel out the poison of the Kerogero Leaves.
    - But they also cancel out the healing medicine that the leaves possess.
    - The Ugege's Tail slows the symptoms of the disease, but it also slows the effectiveness of the medicine.
    - The Magimara Wine is used to help simmer the ingredients, but it evaporates very easily.
    - Also, if there are too many ingredients, the effect of the medicine is also weakened.
    - Now then, how much of each ingredient will you use?
  - Solution:
    - 3 Otone Berries
    - 1 Kerogero Leaf
    - 1/4 of the Ugege's Tail
    - 1 Big Cauldron of Magimara Wine
