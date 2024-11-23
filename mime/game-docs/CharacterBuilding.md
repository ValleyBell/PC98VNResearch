# Character Building

After starting the game, you go through the character building maze. It is used to set Eagle's initial character properties.

You can choose your main path by going north, east, south or west once.
The answer of the first question determines the secondary path you take:
The first two answers will result in the west/north path.
The last two answers will result in the east/south path.
Afterwards the path is linear.

There is a total of 28 questions across 8 paths.
You always have to answer exactly 4 questions.
Each answer will increase one of Eagle's attributes.

You start at map position 7,7 with the following attributes:

- (Level: 0)
- (experience points until next level: 655)
- HP: 12
- MP: 7
- Attack: 2
- Defense: 1
- Intelligence: 1
- Agility: 2

The order of the questions below follows the order of the game's script.

- north path - {position 7,5; choice N-1}:  
  A huge hourglass floats in front of you.
  How much sand do you think is in this hourglass?
  1. The top half is empty of sand → MP +1, continue on left path (X=6)
  2. The top half has a little sand → Agility +1, continue on left path (X=6)
  3. The top half has plenty of sand → Defense +1, continue on right path (X=8)
  4. The top half is full of sand → Attack +1, continue on right path (X=8)
  - left path (north-west):
    - {position 6,4; choice NW-2}:  
      This huge eye is trying to get your attention.
      What do you think it wants?
      1. To warn you of danger ahead → HP +1
      2. To warn you about your relationship → MP +1
      3. To tell you an enemy's location → Agility +1
      4. To ask for help → Attack +1
    - {position 6,2; choice NW-3}:  
      You are lost inside a thick fog.
      How far will this fog go on for?
      1. Forever → Attack +1
      2. Just a little further → Intelligence +1
      3. It's only where I'm standing → MP +1
      4. The fog is an illusion → Defense +1
    - {position 6,0; choice NW-4}:  
      Someone you hate so much you want to kill them is in front of you.
      How do you get revenge?
      1. I do it without dirtying my hands → Intelligence +1
      2. I kill them with my own hands → Attack +1
      3. I'll curse them until I die → MP +1
      4. I won't take revenge → Defense +1
  - right path (north-east):
    - {position 8,4; choice NE-2}:  
        A mirror shows you your greatest wish...
        What do you see?
        1. My own happiness → HP +1
        2. World peace → MP +1
        3. The end of the world → Attack +1
        4. None of these → Intelligence +1
    - {position 8,2; choice NE-3}:  
        Water is flowing between 2 jars floating in the air.
        Which way do you think the water is flowing?
        1. From the right jar into the left → Attack +1
        2. From the left jar into the right → Intelligence +1
        3. Both jars are expelling water → HP +1
        4. There is no flow, everything is still → MP +1
    - {position 8,0; choice NE-4}:  
        If the death of your lover was fated to happen, but you could sacrifice a life to save them...
        Who would you sacrifice?
        1. Myself → HP +1
        2. A stranger → MP +1
        3. My enemy → Intelligence +1
        4. Let my lover die → Agility +1
- east path - {position 9,7; choice E-1}:  
  The pendulum in this clock has stopped.
  Why has it stopped?
  1. It's old and finally broke → Defense +1, continue on left path (Y=6)
  2. It just looks like it stopped → MP +1, continue on left path (Y=6)
  3. Something is stuck on it → Attack +1, continue on right path (Y=8)
  4. It never worked in the first place → HP +1, continue on right path (Y=8)
  - left path (east-north):
    - {position 10,6; choice EN-2}:  
      If the death of your pet was fated to happen, but you could sacrifice a life to save them...
      Who would you sacrifice?
      1. Myself → HP +1
      2. My enemy → MP +1
      3. Another animal's life → Attack +1
      4. I cannot change their fate → Intelligence +1
    - {position 12,6; choice EN-3}:  
      A flower you've never seen before is blooming in front of you.
      What kind of flower is it?
      1. A flower of pure white → Defense +1
      2. A flower of darkness → Agility +1
      3. A flower with a person's face → MP +1
      4. A rainbow flower → HP +1
    - {position 14,6; choice EN-4}:  
      A stranger is spitting out a curse.
      What is it towards?
      1. My fate → Intelligence +1
      2. Another's fate → Agility +1
      3. God → MP +1
      4. The world → Defense +1
  - right path (east-south):
    - {position 10,8; choice ES-2}:  
      There are sparkling lights floating around this plant.
      What are they?
      1. Fairies → MP +1
      2. My memories → Intelligence +1
      3. Gems → Defense +1
      4. Morning dew → HP +1
    - {position 12,8; choice ES-3}:  
      This huge eye can see the destiny of everything
      You can ask to see the destiny of something. What do you pick?
      1. My own destiny → HP +1
      2. Another's destiny → Intelligence +1
      3. The world's destiny → Defense +1
      4. I don't want to know → Intelligence +1
    - {position 14,8; choice ES-4}:  
      A tattered young man offers to bestow you a weapon before you fight.
      What do you ask for?
      1. A cheap sword → Defense +1
      2. A magical weapon → MP +1
      3. Wit and courage → Intelligence +1
      4. I don't need anything → Agility +1
- south path - {position 7,9; choice S-1}:  
  If the sand in this hourglass were to suddenly reverse, and time went backward...
  Which time period would you like to return to?
  1. Before I was born → Agility +1, continue on right path (X=6)
  2. When I was just a baby → Defense +1, continue on right path (X=6)
  3. A time when I was young and healthy → HP +1, continue on left path (X=8)
  4. I don't want to go back to any time → MP +1, continue on left path (X=8)
  - left path (south-east):
    - {position 8,10; choice SE-2}:  
      From deep within a thick fog, you suddenly hear a voice...
      Whose voice is it?
      1. My voice → HP +1
      2. My lover's voice → MP +1
      3. A family member's voice → Attack +1
      4. An ancestor's voice → Defense +1
    - {position 8,12; choice SE-3}:  
      A mirror shows you one of your worst memories...
      What do you see?
      1. The death of a friend or family → Intelligence +1
      2. A bad breakup → MP +1
      3. A school or work failure → Intelligence +1
      4. None of these → Attack +1
    - {position 8,14; choice SE-4}:  
      A stranger suddenly asks for help...
      What do you do?
      1. I will help them for certain → Attack +1
      2. I'll do what I can → Intelligence +1
      3. I ignore them → Agility +1
      4. I stare at them blankly → Defense +1
  - right path (south-west):
    - {position 6,10; choice SW-2}:  
      Two jars float in the air.
      What is flowing between them?
      1. Water → HP +1
      2. Stardust → MP +1
      3. Human souls → Attack +1
      4. My memories → Intelligence +1
    - {position 6,12; choice SW-3}:  
      A black cat foretells you of a death in your life.
      Whose death is it?
      1. A family member's → Defense +1
      2. A friend's → MP +1
      3. A lover's → Agility +1
      4. Cats can't talk → Intelligence +1
    - {position 6,14; choice SW-4}:  
      What do you feel you need more than anything else?
      1. Courage → HP +1
      2. Love and friendship → MP +1
      3. Money → Attack +1
      4. Nothing → Defense +1
- west path - {position 5,7; choice W-1}:  
  This grandfather clock can control all of time itself.
  Who does it belong to?
  1. The God of Time → MP +1, continue on right path (Y=6)
  2. Me → Attack +1, continue on right path (Y=6)
  3. No one → Agility +1, continue on left path (Y=8)
  4. Grandpa → Intelligence +1, continue on left path (Y=8)
  - left path (west-south):
    - {position 4,8; choice WS-2}:  
      A plant is growing steadily in front of you.
      How much does it grow to?
      1. Around my height → Agility +1
      2. To the ceiling → Intelligence +1
      3. Up through the ceiling and further → Defense +1
      4. It dies soon after → Attack +1
    - {position 2,8; choice WS-3}:  
      If you drink the water flowing between these 2 jars, you can extend your lifespan.
      How much water do you drink?
      1. One gulp → HP +1
      2. Enough until I'm no longer thirsty → MP +1
      3. As much as I can → Attack +1
      4. I don't drink the water → Intelligence +1
    - {position 0,8; choice WS-4}:  
      There is a person who wants to kill you. Who is it?
      1. My ex-lover → HP +1
      2. My lover's ex-lover → Defense +1
      3. My best friend → Agility +1
      4. Myself → MP +1
  - right path (west-north):
    - {position 4,6; choice WN-2}:  
      Flowers you've never seen before are blooming in a flash of light.
      What do you do?
      1. I pick one for myself → MP +1
      2. I smell them → HP +1
      3. I take them all → Attack +1
      4. I do nothing → Intelligence +1
    - {position 2,6; choice WN-3}:  
      A huge eye is staring at you.
      Where is the eye looking at?
      1. My face → HP +1
      2. My body → Attack +1
      3. My mind → Intelligence +1
      4. My eyes → MP +1
    - {position 0,6; choice WN-4}:  
      In a deep sleep, you hear someone utter your name.
      Who is trying to wake you up?
      1. My lover → MP +1
      2. A family member → HP +1
      3. A ghost → Intelligence +1
      4. A computerized voice → Defense +1
