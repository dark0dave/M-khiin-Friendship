/* 2024.10.22. Dialogue Completed. Proofreading / Rewrites not started. */

/* Get M'Khiin to slowly trust the PC over time - completing her main friendship arc for SoD. 
Three main themes: trust, strength in numbers, leadership.*/ 
/* BG 2 Content will start in the Temple Ruins area - and focus on M'Khiin becoming a leader, helping her fellow goblins, following up on her friendship arc here.
She couldn't save the PC from imprisonment. Not as a lone goblin. She needs to become a leader and build a place where she belongs. */ 

// Allow PC to stand up for M'Khiin during Jegg's dialogue
EXTEND_BOTTOM BDJEGG 94
++ @0 /* M'Khiin is my companion. Show her some respect. */ + BFSMk.Jegg1
++ @1 /* We need every fighter we can get. Even a goblin. */ + BFSMk.Jegg1
++ @2 /* Gnolls carry swords on occasion, you know? */ + BFSMk.Jegg1
END

CHAIN BDJEGG BFSMk.Jegg1
@3 /* Do you want the armor or not? */
END
IF ~~ THEN DO ~StartCutSceneMode()
ClearAllActions()
SetGlobalTimer("bd_205_mkhiin_armor_timer","global",EIGHT_HOURS)
SetGlobal("bd_205_mkhiin_armor","global",1)
StartCutSceneEx("bdcutjeg",TRUE)
~ EXIT

APPEND BDMKHIIJ

// Talk 1- she appreciates that you helped her, but it was still a little sus of you
IF ~Global("BFSKinFriendshipTalks","GLOBAL",2)~ THEN BEGIN BFSMk.Talk1
SAY @4 /* Why'd you help me? Goblins don't get kindness for free. */
++ @5 /* It felt like the right thing to do. */ + BFSMk.Right
++ @6 /* I don't believe in enslaving anyone. */ + BFSMk.Slavery
++ @7 /* Because you owe me now. */ + BFSMk.Favor
++ @8 /* Baeloth's babbling bored me. */ + BFSMk.BaelothEww
++ @9 /* Be quiet, will you? I'm not here to be your friend. */ + BFSMk.Shutup
END

IF ~~ BFSMk.BaelothEww
SAY @10 /* Starting to sound like him. Careful. */
IF ~~ + BFSMk.WorldNorm
END

IF ~~ BFSMk.Right
SAY @11 /* Drow said the same. Right before he broke his word. */
IF ~~ +BFSMk.WorldNorm
END

IF ~~ BFSMk.Slavery
SAY @12 /* Most won't call caging a goblin slavery. Guess that makes you different. */
IF ~~ + BFSMk.WorldNorm
END

IF ~~ BFSMk.Favor
SAY @13 /* Knew it. Knew there was some catch. So, what do you want? */
++ @14 /* I haven't decided yet. */ + BFSMk.WorldNorm
++ @15 /* Some peace and quiet would be a start. */ + BFSMk.Shutup2
+ ~OR(4) Race(Player1,ELF) Race(Player1,HUMAN) Race(Player1,HALFORC) Race(Player1,HALF_ELF)~ + @16 /* I need fodder for my army. You're perfect for the role. */ + BFSMk.FodderTall
+ ~OR(3) Race(Player1,DWARF) Race(Player1,GNOME) Race(Player1,HALFLING)~ + @16 /* I need fodder for my army. You're perfect for the role. */ + BFSMk.FodderShort
END

IF ~~ BFSMk.Shutup2
SAY @17 /* Been around the drow too long. */
IF ~~ DO ~SetGlobal("BFSKinFriendshipTalks","GLOBAL",3) RealSetGlobalTimer("BFSKinFriendshipTalksTimer","GLOBAL",3600)~ EXIT
END


IF ~~ BFSMk.FodderTall
SAY @18 /* Could've picked someone taller. */
IF ~~ + BFSMk.WorldNorm
END

IF ~~ BFSMk.FodderShort
SAY @19 /* Good thing you're short then. */
IF ~~ + BFSMk.WorldNorm
END

IF ~~ BFSMk.Shutup
SAY @20 /* Didn't think you were. Was trying to figure out what you *did* want. */
IF ~~ DO ~SetGlobal("BFSKinFriendshipTalks","GLOBAL",3) RealSetGlobalTimer("BFSKinFriendshipTalksTimer","GLOBAL",3600)~ EXIT
END

IF ~~ BFSMk.WorldNorm
SAY @21 /* That's how it works. The strong take from the weak. From those smaller. Makes life tricky for goblins. Lots of folks are taller and stronger. */
= @22 /* Numbers could help, but I've never had those. */
++ @23 /* M'khiin, I've helped you before. That has to count for something. */ + BFSMk.HelpBefore
++ @24 /* I'm not asking you to trust me right away. I'm asking you to give me a chance to earn it. */ + BFSMk.EarnTrust
++ @25 /* Just do your part and we won't have any issues. We don't need to be friends. */ + BFSMk.NotFriends
END

IF ~~ BFSMk.HelpBefore
SAY @26 /* Maybe. Still hard to believe. */
IF ~~ + BFSMk.Cont
END

IF ~~ BFSMk.EarnTrust
SAY @27 /* Would be nice to be wrong. Guess we'll see. I'm not going anywhere. */
IF ~~ + BFSMk.Cont
END

IF ~~ BFSMk.NotFriends
SAY @28 /* Simple terms. I can respect that. */
IF ~~ + BFSMk.Cont
END

IF ~~ BFSMk.Cont
SAY @29 /* Haven't been around others much. Not since leaving the tribe. */
= @30 /* The drow's hospitality don't count. Being prodded with sticks and all. */
++ @31 /* Relax, M'khiin, I don't have any expectations. */ + BFSMk.Cont2
+ ~Class(Player1,BARD)~ + @32 /* Then it's a good thing I talk enough for both of us. */ + BFSMk.Cont2
+ ~!Class(Player1,SHAMAN)~ + @33 /* But you're a shaman. You talk to spirits all the time, don't you? */ + BFSMk.ShamanConverse
+ ~Class(Player1,SHAMAN)~ + @34 /* But you're a shaman too. Talking to spirits is what we *do*. */ + BFSMk.ShamanConverse
++ @35 /* Stop talking. Now. I'm not interested. */ + BFSMk.Shutup2
END

IF ~~ BFSMk.ShamanConverse
SAY @36 /* Spirits don't need small talk. Makes it easier. */ 
IF ~~ + BFSMk.Cont2
END

IF ~~ BFSMk.Cont2
SAY @37 /* We should move. Talked too much already. */
IF ~~ DO ~SetGlobal("BFSKinFriendshipTalks","GLOBAL",3) RealSetGlobalTimer("BFSKinFriendshipTalksTimer","GLOBAL",3600)~ EXIT
END

// Talk 2 - A matter of food / resources and fitting in
IF ~Global("BFSKinFriendshipTalks","GLOBAL",4)~ THEN BEGIN BFSMk.Talk2
SAY @38 /* Been thinking. How much food can I take? */  
++ @39 /* Why are we even having this conversation? */ + BFSMk.WhyDiscussFood
+ ~InParty("Minsc")~ + @40 /* As a member of this group, you receive an equal share of every meal. */ + BFSMk.EqualFoodM
+ ~!InParty("Minsc")~ + @40 /* As a member of this group, you receive an equal share of every meal. */ + BFSMk.EqualFood
+ ~InParty("Minsc")~ + @41 /* Goblins are small. You don't need much. */ + BFSMk.FoodSmallM
+ ~!InParty("Minsc")~ + @41 /* Goblins are small. You don't need much. */ + BFSMk.FoodSmall
++ @42 /* I don't have time for this. Figure it out yourself. */ + BFSMk.MealConfuse
END

IF ~~ BFSMk.EqualFoodM
SAY @43 /* Don't solve things though. I'm smaller. Won't need as much. */ 
= @44 /* Too-tall may need more. Keeps sharing with that rodent of his. */
IF ~~ + BFSMk.FoodTell
END

IF ~~ BFSMk.EqualFood
SAY @43 /* Don't solve things though. I'm smaller. Won't need as much. */
IF ~~ + BFSMk.FoodTell
END

IF ~~ BFSMk.FoodSmallM
SAY @45 /* Don't solve things though. Some days I need more. Less on others. */
= @46 /* And too-tall keeps sharing with that rodent of his. */
IF ~~ + BFSMk.FoodTell
END

IF ~~ BFSMk.FoodSmall
SAY @45 /* Don't solve things though. Some days I need more. Less on others. */
IF ~~ + BFSMk.FoodTell
END

IF ~~ BFSMk.FoodTell
SAY @47 /* What's your pick? */
++ @48 /* I can't pick a favourite. */ + BFSMk.NoFave
++ @49 /* Roasted chicken. You can't go wrong with a classic. */ + BFSMk.Chicken
++ @50 /* I prefer a hearty stew. Simple but delicious. */ + BFSMk.StewYum
++ @51 /* Stonebread. It lasts even when the road's rough. */ + BFSMk.Yum
++ @52 /* Starfruit tart. It's delicate and flaky with just a hint of sweetness. */ + BFSMk.Yum
++ @53 /* I'm fond of savoury rice. Anything with a bit of spice really. */ + BFSMk.Yum
+ ~Class(Player1,DRUID)~ + @54 /* Foraged meals. Nature provides whatever I need. */ + BFSMk.ClassCircleBack
+ ~Class(Player1,MONK)~ + @55 /* I prefer simple meals. Food should nourish the body and mind. */ + BFSMk.ClassCircleBack
END

IF ~~ BFSMk.ClassCircleBack
SAY @56 /* If we come by something good, I'll leave more for you. */
++ @57 /* No. You don't have to go hungry on my account. */ +  BFSMk.MealTalkEnd
++ @58 /* Fair enough. If we come across anything you like, tell me and I'll return the favor. */ + BFSMk.MealTalkEnd
++ @59 /* Sounds like a plan. */ + BFSMk.MealTalkEnd
END

IF ~~ BFSMk.NoFave
SAY @60 /* Beggars can't be choosers. Know that. */
= @56 /* If we come by something good, I'll leave more for you. */
++ @57 /* No. You don't have to go hungry on my account. */ +  BFSMk.MealTalkEnd
++ @58 /* Fair enough. If we come across anything you like, tell me and I'll return the favor. */ + BFSMk.MealTalkEnd
++ @59 /* Sounds like a plan. */ + BFSMk.MealTalkEnd
END

IF ~~ BFSMk.Chicken
SAY @61 /* Like it too. */ 
= @62 /* If we come by one, I'll leave more for you. */ 
++ @57 /* No. You don't have to go hungry on my account. */ +  BFSMk.MealTalkEnd
++ @58 /* Fair enough. If we come across anything you like, tell me and I'll return the favor. */ + BFSMk.MealTalkEnd
++ @59 /* Sounds like a plan. */ + BFSMk.MealTalkEnd
END

IF ~~ BFSMk.StewYum
SAY @63 /* Stew's not bad. Learned to make some after leaving the tribe. */
= @64 /* If we come by it, I'll leave more for you. */ 
++ @57 /* No. You don't have to go hungry on my account. */ +  BFSMk.MealTalkEnd
++ @58 /* Fair enough. If we come across anything you like, tell me and I'll return the favor. */ + BFSMk.MealTalkEnd
++ @59 /* Sounds like a plan. */ + BFSMk.MealTalkEnd
END

IF ~~ BFSMk.Yum
SAY @65 /* Ain't tried that. If we come by it, I'll leave more for you. */
++ @57 /* No. You don't have to go hungry on my account. */ +  BFSMk.MealTalkEnd
++ @58 /* Fair enough. If we come across anything you like, tell me and I'll return the favor. */ + BFSMk.MealTalkEnd
++ @59 /* Sounds like a plan. */ + BFSMk.MealTalkEnd
END

IF ~~ BFSMk.WhyDiscussFood
SAY @66 /* Tribe fought over food. The fastest or strongest ate first. Everyone else got what's left. */
= @67 /* Goblins settle for anything. Have to. We don't farm. Don't grow. We steal, we scrounge, we dig through what others throw away. Scraps of scraps. */ 
= @68 /* Need to know where I stand. What's my share? */
+ ~InParty("Minsc")~ + @40 /* As a member of this group, you receive an equal share of every meal. */ + BFSMk.EqualFoodM
+ ~!InParty("Minsc")~ + @40 /* As a member of this group, you receive an equal share of every meal. */ + BFSMk.EqualFood
+ ~InParty("Minsc")~ + @41 /* Goblins are small. You don't need much. */ + BFSMk.FoodSmallM
+ ~!InParty("Minsc")~ + @41 /* Goblins are small. You don't need much. */ + BFSMk.FoodSmall
++ @42 /* I don't have time for this. Figure it out yourself. */ + BFSMk.MealConfuse
END

IF ~~ BFSMk.MealConfuse
SAY @69 /* Will scrounge for my own meals. Might be easier that way. */ 
IF ~~ EXIT
END

IF ~~ BFSMk.MealTalkEnd
SAY @70 /* I like that. Wouldn't work in a goblin tribe though. */
= @71 /* Good thing I'm not in one. */ 
IF ~~ DO ~SetGlobal("BFSKinFriendshipTalks","GLOBAL",5) RealSetGlobalTimer("BFSKinFriendshipTalksTimer","GLOBAL",3600)~ EXIT
END

// Talk 3 - Nightmare talk

IF ~Global("BFSKinFriendshipTalks","GLOBAL",6)~ THEN BEGIN BFSMk.Talk3
SAY @72 /* You get nightmares. Sometimes. When you sleep. */
++ @73 /* I guess wishing they'd go away was a bit naive. */ + BFSMk.SameBestie
++ @74 /* It's an occupational hazard. */ + BFSMk.SameBestie
++ @75 /* As opposed to when I'm awake? */ + BFSMk.DreamSarcasm
END

IF ~~ BFSMk.SameBestie
SAY @76 /* I had nightmares too. Back in the tribe. And when the drow caged me. */ 
++ @77 /* Was it difficult to leave? */ + BFSMk.LeavingTribe
++ @78 /* Baeloth shouldn't have imprisoned you. */ + BFSMk.BaelothBad
END

IF ~~ BFSMk.BaelothBad
SAY @79 /* Trickery's in his nature. I shouldn't have fallen for it. */
= @80 /* But when you're desperate, you easily fall for a clever tongue. */
++ @81 /* You've learned from your mistakes. Now you're stronger for it. */ + BFSMk.HarderBetterFasterStronger
END

IF ~~ BFSMk.LeavingTribe
SAY @82 /* It had never been done before. The only thing scarier than leaving was things staying the same. */
= @83 /* So I ran. And I've been running ever since. */
++ @81 /* You've learned from your mistakes. Now you're stronger for it. */ + BFSMk.HarderBetterFasterStronger
END

IF ~~ BFSMk.HarderBetterFasterStronger
SAY @84 /* Or maybe I know better what to avoid. */
IF ~~ DO ~SetGlobal("BFSKinFriendshipTalks","GLOBAL",7) RealSetGlobalTimer("BFSKinFriendshipTalksTimer","GLOBAL",3600)~ EXIT
END

IF ~~ BFSMk.DreamSarcasm
SAY @85 /* Life can be a nightmare too. */ 
IF ~~ DO ~SetGlobal("BFSKinFriendshipTalks","GLOBAL",7) RealSetGlobalTimer("BFSKinFriendshipTalksTimer","GLOBAL",3600)~ EXIT
END

// Talk 4 - What do friends do?
IF ~Global("BFSKinFriendshipTalks","GLOBAL",8)~ THEN BEGIN BFSMk.Talk4
SAY @86 /* Seems we're pals now. Or …somethin' like it. */
++ @87 /* Don't presume. We are definitely not friends. */ + BFSMk.FriendsHellNo
++ @88 /* So you're comfortable admitting it now? */ + BFSMk.FriendshipComfortable
++ @89 /* I wouldn’t say we're friends yet. But give it time. */ + BFSMk.FriendshipConfusing
++ @90 /* You're going to make this awkward, aren't you? */ + BFSMk.FriendshipConfusing
END

IF ~~ BFSMk.FriendsHellNo
SAY @91 /* Good. Means I don't have to fumble through this. */ 
IF ~~ EXIT
END

IF ~~ BFSMk.FriendshipComfortable
SAY @92 /* Getting there. */ 
IF ~~ + BFSMk.FriendshipConfusing
END

IF ~~ BFSMk.FriendshipConfusing
SAY @93 /* Haven't had friends before. Don't know how it works. */ 
= @94 /* Talking, drinking, maybe a smile – I can do those. But it feels like there's more to it. */
++ @95 /* You were on the right path. */ + BFSMk.FriendshipEncourage
++ @96 /* All of those things play a part, yes, but at the appropriate time. */ + BFSMk.FriendshipEncourage
++ @97 /* You're hopeless at this. */ + BFSMk.Hopeless
++ @98 /* I take back what I said. We're never going to be friends. */ + BFSMk.FriendsHellNo
END

IF ~~ BFSMk.Hopeless
SAY @99 /* Only if I give up. And I'm not planning to. */ 
IF ~~ + BFSMk.FriendshipEncourage
END

IF ~~ BFSMk.FriendshipEncourage
SAY @100 /* What more should I be doing? */
++ @101 /* Easy, M'Khiin. Start by asking me about myself. My hobbies. Or interests. */ + BFSMk.FriendsHobbiesSplit
++ @102 /* We don't have to talk. Sometimes friends can simply exist in the same space. Being comfortably silent. */ + BFSMk.BlissfulSilence
+ ~!Alignment(Player1,LAWFUL_GOOD) !Alignment(Player1,LAWFUL_NEUTRAL)~ + @103 /* Friends break each other out of jail if they get caught. */ + BFSMk.JailBird
END 

IF ~~ BFSMk.BlissfulSilence
SAY @104 /* Going to try that now. */
IF ~~ EXIT
END

IF ~~ BFSMk.JailBird
SAY @105 /* Then don't get caught. */ 
IF ~~ EXIT
END

IF ~~ BFSMk.FriendsHobbiesSplit
SAY @106 /* Why would I ask? */
// class split starts - ah, shit here we go again meme
IF ~Class("Player1",DRUID)~ + BFSMk.PlayerDruid
IF ~Class("Player1",MAGE) !Class("Player1",SORCERER)~ + BFSMk.PlayerMage
IF ~Class("Player1",CLERIC)~ + BFSMk.PlayerCleric
IF ~Class("Player1",THIEF_ALL)~ + BFSMk.PlayerRogue
IF ~Class("Player1",BARD)~ + BFSMk.PlayerBard
IF ~Class("Player1",FIGHTER_ALL)~ + BFSMk.PlayerFighter
IF ~~ + BFSMk.PlayerGeneral
END 

IF ~~ BFSMk.PlayerGeneral
SAY @107 /* You jot things down. In your book. */
++ @108 /* There's more to me than those hobbies. Just as there's more to you than first appearances suggest. */ + BFSMk.FirstAppearances
++ @109 /* Sounds like you have me all figured out. */ + BFSMk.PinnedYa
++ @110 /* That doesn't sound like me at all. */ + BFSMk.DeadWrongActually
END

IF ~~ BFSMk.PlayerDruid
SAY @111 /* You spend time around plants. */
++ @108 /* There's more to me than those hobbies. Just as there's more to you than first appearances suggest. */ + BFSMk.FirstAppearances
++ @109 /* Sounds like you have me all figured out. */ + BFSMk.PinnedYa
++ @110 /* That doesn't sound like me at all. */ + BFSMk.DeadWrongActually
END

IF ~~ BFSMk.PlayerMage
SAY @112 /* You scribble spells in your magic book. */ 
++ @108 /* There's more to me than those hobbies. Just as there's more to you than first appearances suggest. */ + BFSMk.FirstAppearances
++ @109 /* Sounds like you have me all figured out. */ + BFSMk.PinnedYa
++ @110 /* That doesn't sound like me at all. */ + BFSMk.DeadWrongActually
END

IF ~~ BFSMk.PlayerCleric
SAY @113 /* You pray. You chant words. */ 
++ @108 /* There's more to me than those hobbies. Just as there's more to you than first appearances suggest. */ + BFSMk.FirstAppearances
++ @109 /* Sounds like you have me all figured out. */ + BFSMk.PinnedYa
++ @110 /* That doesn't sound like me at all. */ + BFSMk.DeadWrongActually
END

IF ~~ BFSMk.PlayerRogue
SAY @114 /* You swipe things when no one's watching. */
++ @108 /* There's more to me than those hobbies. Just as there's more to you than first appearances suggest. */ + BFSMk.FirstAppearances
++ @109 /* Sounds like you have me all figured out. */ + BFSMk.PinnedYa
++ @110 /* That doesn't sound like me at all. */ + BFSMk.DeadWrongActually
END

IF ~~ BFSMk.PlayerBard
SAY @115 /* You talk. A lot. */ 
++ @108 /* There's more to me than those hobbies. Just as there's more to you than first appearances suggest. */ + BFSMk.FirstAppearances
++ @109 /* Sounds like you have me all figured out. */ + BFSMk.PinnedYa
++ @110 /* That doesn't sound like me at all. */ + BFSMk.DeadWrongActually
END

IF ~~ BFSMk.PlayerFighter
SAY @116 /* You swing your weapon around all day. */ 
++ @108 /* There's more to me than those hobbies. Just as there's more to you than first appearances suggest. */ + BFSMk.FirstAppearances
++ @109 /* Sounds like you have me all figured out. */ + BFSMk.PinnedYa
++ @110 /* That doesn't sound like me at all. */ + BFSMk.DeadWrongActually
END

IF ~~ BFSMk.FirstAppearances
SAY @117 /* Already knew that. You took in a goblin. Made her your friend. You were special from the start. */ 
IF ~~ DO ~SetGlobal("BFSKinFriendshipTalks","GLOBAL",9) RealSetGlobalTimer("BFSKinFriendshipTalksTimer","GLOBAL",3600)~ EXIT
END

IF ~~ BFSMk.PinnedYa
SAY @118 /* Haven't though. There's always more hidden. You took in a goblin. Made her your friend. You were special from the start. */
IF ~~ DO ~SetGlobal("BFSKinFriendshipTalks","GLOBAL",9) RealSetGlobalTimer("BFSKinFriendshipTalksTimer","GLOBAL",3600)~ EXIT
END

IF ~~ BFSMk.DeadWrongActually
SAY @119 /* Then I will watch. Learn. You took in a goblin. Made her your friend. You were special from the start. */
IF ~~ DO ~SetGlobal("BFSKinFriendshipTalks","GLOBAL",9) RealSetGlobalTimer("BFSKinFriendshipTalksTimer","GLOBAL",3600)~ EXIT
END

// Scenery Talks

// Post Meeting Caelar
// French Parents stop tossing your children over the school's fence, thanks :) 
IF ~Global("BFSMkBridge","GLOBAL",1)~ THEN BEGIN BFSMk.BridgeConvo
SAY @120 /* Stupid Nothing good comes from bringing the long-dead back. */
+ ~Class(Player1,SHAMAN)~ + @121 /* But we're shamans. We speak with spirits all the time. */ + BFSMk.BadIdeaS
+ ~!Class(Player1,SHAMAN)~ + @122 /* But you're a shaman. You speak with ghosts - with spirits - all the time. */  + BFSMk.BadIdea
++ @123 /* Too bad Caelar isn't interested in listening to reason. */ + BFSMk.CaelarSaysYolo
++ @124 /* Even if it means condemning innocents to eternal torment? */ + BFSMk.PlanescapeTormentIMissYou
END 

IF ~~ BFSMk.BadIdeaS
SAY @125 /* They listen. But only if we speak the right words. You know. Too many of them. All frightened. Confused. Running scared. Won't end well for anyone. */ 
IF ~~ + BFSMk.FollowingTheTrail
END

IF ~~ BFSMk.BadIdea
SAY @126 /* They listen. But only if I speak the right words. Too many of them. All frightened. Confused. Running scared. Won't end well for anyone. */ 
IF ~~ + BFSMk.FollowingTheTrail
END

IF ~~ BFSMk.PlanescapeTormentIMissYou
SAY @127 /* Yes. Wouldn't be coming back *right*. */ 
IF ~~ + BFSMk.FollowingTheTrail
END

IF ~~ BFSMk.CaelarSaysYolo
SAY @128 /* More fools following fools. */ 
IF ~~ + BFSMk.FollowingTheTrail
END

IF ~~ BFSMk.FollowingTheTrail
SAY @129 /* Bridge is gone now. Don't think tossing me over would help. Can't get you over. */ 
= @130 /* ...Might not make it across anyway. Guess we're taking the longer road. */ 
IF ~~ DO ~SetGlobal("BFSMkBridge","GLOBAL",2) ~ EXIT
END

// Dragon Cave Warning, she wants to keep the team safe but she's not outright saying that yet 
IF ~Global("BFSMkDragon","GLOBAL",1)~ BFSMk.DragonWarning
SAY @131 /* Spirits stir. Something's up ahead. */
++ @132 /* It's nothing we can't handle. */ + BFSMk.DragonThanks
++ @133 /* I appreciate the warning, but we've no choice but to press ahead. */ + BFSMk.DragonThanks
++ @134 /* We'll tread lightly. Keep your voice low. */ + BFSMk.DragonQuiet
++ @135 /* The snoring gave that away. */ + BFSMk.DragonThanks
+ ~Class(Player1,SHAMAN)~ + @136 /* I hear them too. We should be cautious. */ + BFSMk.DragonThanks
END

IF ~~ BFSMk.DragonThanks
SAY @137 /* Right. I'll be here. */ 
IF ~~ DO ~SetGlobal("BFSMkDragon","GLOBAL",2)~ EXIT
END

IF ~~ BFSMk.DragonQuiet
SAY @138 /* Won't matter. Not with all the snoring. */ 
IF ~~ DO ~SetGlobal("BFSMkDragon","GLOBAL",2)~ EXIT
END

// Dragon Dead
IF ~Global("BFSMkDragon","GLOBAL",3)~ BFSMK.DragonDead
SAY @139 /* Dead now. Spirits are quieter. */
IF ~~ DO ~SetGlobal("BFSMkDragon","GLOBAL",4)~ EXIT
END

// Bhaal Temple - Post Killing Mindflayer
IF ~Global("BFSMkBhaal","GLOBAL",1)~ THEN BEGIN BFSMk.BhaalspawnTalk
SAY @140 /* This place belonged to your pa? */
++ @141 /* Yes. This was once a temple of Bhaal, and I am a Bhaalspawn. */ + BFSMk.BhaalspawnAdmission
++ @142 /* I was wondering when we'd have this conversation. Yes, I'm a Bhaalspawn. Does it matter? */ + BFSMk.BhaalspawnAdmission
++ @143 /* Look around. It hasn't belonged to him for some time. */ + BFSMk.Ruins
++ @144 /* TThere's only one father I recognize - and it's not this one. */ + BFSMk.MightBeYourFatherButNotYourDaddy
++ @145 /* M'Khiin. I'm. Not. Interested. */ + BFSMk.StopTalkingNow
END

IF ~~ BFSMk.BhaalspawnAdmission
SAY @146 /* Heard about that. People whisper back in camp. Some scared, some not so much. Don't see why it matters. */
= @147 /* This place needs a good scrubbing. Hope you weren't thinking of moving in. */ 
IF ~~ DO ~SetGlobal("BFSMkBhaal","GLOBAL",2)~ EXIT
END 

IF ~~ BFSMk.StopTalkingNow
SAY @148 /* Got it. Shutting up. */
IF ~~ DO ~SetGlobal("BFSMkBhaal","GLOBAL",2)~ EXIT
END

IF ~~ BFSMk.MightBeYourFatherButNotYourDaddy
SAY @149 /* I understand. The family you choose is more important. Blood is just blood. */ 
IF ~~ DO ~SetGlobal("BFSMkBhaal","GLOBAL",2)~ EXIT
END

IF ~~ BFSMk.Ruins
SAY @150 /* Agreed. This place needs a good scrubbing. Hope you weren't thinking of moving in. */
IF ~~ DO ~SetGlobal("BFSMkBhaal","GLOBAL",2)~ EXIT
END

// Post Boareskyr Bridge, she's *trying* 
IF ~Global("BFSMkBoareskyr","GLOBAL",3)~ THEN BEGIN BFSMk.Boareskyr
SAY @151 /* Hmph. You help 'em, something bad happens, now they don't like you anymore. */
= @152 /* Been the same for me. One look and the worst thoughts start crawling in. Don't blame 'em. Haven't had good experiences with goblins either. */
= @153 /* Just a scorch mark on the ground. You're still the same <CHARNAME>. */
++ @154 /* M'Khiin, are you trying to comfort me? */ + BFSMk.Console
++ @155 /* Being judged for *what* you are, rather than who you are, is the worst. */ + BFSMk.Console
++ @156 /* I don't need your sympathy, M'Khiin. Back off. */ + BFSMk.NoScrubs
++ @157 /* Don't even think about comparing yourself to me. */ + BFSMk.NoComparison
END

IF ~~ BFSMk.Console
SAY @158 /* Maybe I'm being sensible. Lots of the too-talls aren't. */
= @159 /* But if you feel better. Yes. That was my intent. */ 
++ @160 /* Thank you. I appreciate it. */ + BFSMk.Kind
++ @161 /* Oddly enough that does make me feel better. */ + BFSMk.Kind
++ @162 /* There's more going on here than you realize, M'Khiin. Different faiths. Different cities. */ + BFSMk.Overcomplicated
++ @163 /* They don't. So leave me alone. */ + BFSMk.NoScrubs
END

IF ~~ BFSMk.Overcomplicated
SAY @164 /* Too much noise for one goblin's head. Could make it simpler. But don't think you will. */
IF ~~ + BFSMk.Kind
END

IF ~~ BFSMk.Kind
SAY @165 /* I'll brew you a stew. Mushroom and moss. Good for the soul. I'm a shaman, I'd know. */
++ @166 /* I'll pass. */ + BFSMk.NoSoup
++ @167 /* I appreciate the thought, but it would be rude not to share with the whole army. We'll have to wait. */ + BFSMk.NoSoup
++ @168 /* That sounds delicious! Count me in! */ + BFSMk.YesSoup
++ @169 /* No, M'Khiin. Just…no. */ + BFSMk.NoSoup
+ ~Class(Player1,DRUID)~ + @170 /* I'd love to trade remedies with you. It's not often I can talk with a Goblin Shaman. */ + BFSMk.DruidStew
END

IF ~~ BFSMk.NoSoup
SAY @171 /* More for me then. */ 
IF ~~ THEN DO ~SetGlobal("BFSMkBoareskyr","GLOBAL",4)~ EXIT
END

IF ~~ BFSMk.YesSoup
SAY @172 /* Might be looking forward to it . */
IF ~~ THEN DO ~SetGlobal("BFSMkBoareskyr","GLOBAL",4)~ EXIT
END

IF ~~ BFSMk.DruidStew
SAY @173 /* Not often you'd want to. Wouldn't mind sharing though. Not with you. */
IF ~~ THEN DO ~SetGlobal("BFSMkBoareskyr","GLOBAL",4)~ EXIT
END

IF ~~ BFSMk.NoScrubs
SAY @174 /* I know about being unwanted. Or being were you don't want to be. */
IF ~~ THEN DO ~SetGlobal("BFSMkBoareskyr","GLOBAL",4)~ EXIT
END

IF ~~ BFSMk.NoComparison
SAY @175 /* Why not? Seems similar. People think you're a monster. Maybe you are, maybe you're not. Doesn't matter. They already made up their minds. */ 
= @176 /* You're still you though. */ 
IF ~~ THEN DO ~SetGlobal("BFSMkBoareskyr","GLOBAL",4)~ EXIT
END

// Jegg's Leathers Equipped 
IF ~Global("BFSMkArmor","GLOBAL",1)~ THEN BFSMk.ArmorThanks
SAY @177 /* Fits snug. Feels right. */ 
++ @178 /* It looks good on you. */ + BFSMk.ArmorLooksGood
++ @179 /* I'm sorry for Jegg's behaviour back there. */ + BFSMk.ArmorRude
++ @180 /* You look ridiculous but at least it'll stop a few arrows. */ + BFSMk.ArmorRidicule
END

IF ~~ BFSMk.ArmorRude
SAY @181 /* Wasn't you who said those words. Besides rude's nothing new. Have dealt with worse. */
= @182 /* Thank you, <CHARNAME>. */ 
IF ~~ THEN DO ~SetGlobal("BFSMkArmor","GLOBAL",2)~ EXIT
END


IF ~~ BFSMk.ArmorLooksGood
SAY @182 /* Thank you, <CHARNAME>. */ 
IF ~~ THEN DO ~SetGlobal("BFSMkArmor","GLOBAL",2)~ EXIT
END


IF ~~ BFSMk.ArmorRidicule
SAY @183 /* Hope so. Don't plan on testing it though. */ 
= @182 /* Thank you, <CHARNAME>. */ 
IF ~~ THEN DO ~SetGlobal("BFSMkArmor","GLOBAL",2)~ EXIT
END

// Post Meeting with Other Gobbos 

IF ~Global("BFSMkGobbos","GLOBAL",1)~ THEN BEGIN BFSMk.Gobbos
SAY @184 /* Glad that's over with. Never going back. *Never*. */
++ @185 /* You don't have to, M'Khiin. You have a place with us for as long as you want it. */ + BFSMk.HomeIsWhereTheGobbosArent
++ @186 /* They had a point. You could do much good for your people. */ + BFSMk.MyPeopleNeedMe
++ @187 /* Are you done with the dramatics? */ + BFSMk.AreYouDone
END 

IF ~~ BFSMk.AreYouDone
SAY @188 /* I'm done. */ 
IF ~~ THEN DO ~SetGlobal("BFSMkGobbos","GLOBAL",2)~ EXIT
END

IF ~~ BFSMk.HomeIsWhereTheGobbosArent
SAY @189 /* Thank you. Already chose who I want to travel with. */ 
= @190 /* Already chose you. */ 
++ @191 /* Do you feel like you're ready for a hug yet?  */ + BFSMk.WannaHug
++ @192 /* For what it's worth, I'm proud of you. */ + BFSMk.GoblinTearUp
++ @193 /* Then let's move on. */ + BFSMk.LetsMoveOn
END

IF ~~ BFSMk.WannaHug
SAY @194 /* ...What? No! Trust you enough to know you won't stab me. */
= @195 /* Even consider you a friend. But hugs? Not happening. */ 
IF ~~ THEN DO ~SetGlobal("BFSMkGobbos","GLOBAL",2)~ EXIT
END

IF ~~ BFSMk.LetsMoveOn
SAY @196 /* Right behind you. */
IF ~~ THEN DO ~SetGlobal("BFSMkGobbos","GLOBAL",2)~ EXIT
END

IF ~~ BFSMk.GoblinTearUp
SAY @197 /* Didn't think anyone ever would be. */ 
= @198 /* So you should stop with the words. You don't want to see a goblin cry. Trust me. */ 
IF ~~ THEN DO ~SetGlobal("BFSMkGobbos","GLOBAL",2)~ EXIT
END

IF ~~ BFSMk.MyPeopleNeedMe
SAY @199 /* Maybe. But why should I? */
= @200 /* Spent fifteen years with my tribe. Saw how they are. Violent. Short-sighted. Changing your nature isn't easy. */
++ @201 /* But it's not impossible. Not if you teach them. */ + BFSMk.DifficultChange
++ @202 /* It's your decision, M'Khiin. I'm not here to push you. */ + BFSMk.DifficultChange
++ @203 /* You're right. Forget about it. */ + BFSMk.ForgetHelpingGobbos
END

IF ~~ BFSMk.DifficultChange
SAY @204 /* Can't teach someone who doesn't want to learn. */ 
= @205 /* ...But maybe if I keep talking, one day they'll listen. */ 
IF ~~ THEN DO ~SetGlobal("BFSMkGobbos","GLOBAL",2)~ EXIT
END

IF ~~ BFSMk.ForgetHelpingGobbos
SAY @206 /* Good. Easier that way. */
IF ~~ THEN DO ~SetGlobal("BFSMkGobbos","GLOBAL",2)~ EXIT
END

// Post 'Diplomacy' meeting with Commanders and Caelar
// Foreshadowing the 'You're captured, I need to run' eventuality 
IF ~Global("BFSMkAggressiveNegotations","GLOBAL",1)~ THEN BEGIN BFSMk.AggressiveNegotiations
SAY @207 /* Words didn't fix much. */ 
+ ~Class(Player1,BARD)~ + @208 /* Only because they weren't the right words. */ + BFSMk.Diplomacy
++ @209 /* Actions often speak louder but words can still change hearts. */ + BFSMk.Diplomacy
++ @210 /* This is why I prefer reaching for my weapon first. */ + BFSMk.Stabbity
+ ~Class(Player1,THIEF_ALL)~ + @211 /* A well-aimed strike can communicate what words cannot. */ + BFSMk.Stabbity
END

IF ~~ BFSMk.Diplomacy
SAY @212 /* Maybe. Doesn't matter though. If they won't heed a <PRO_RACE>, then a goblin has no chance. */ 
IF ~~ + BFSMk.FreedomOrDeath
END

IF ~~ BFSMk.Stabbity
SAY @213 /* Right. Need to make a point. Sometimes with a knife. Faster that way. */ 
IF ~~ + BFSMk.FreedomOrDeath
END

IF ~~ BFSMk.FreedomOrDeath
SAY @214 /* You've stood by me. At least so far. I won't let them drag you away. */ 
= @215 /* Too many voices deciding your fate. Not letting *you* choose your path. Doesn't sit well with me. */ 
++ @216 /* If it means saving lives, I would have gladly followed Caelar. */ + BFSMk.SaveYourself
++ @217 /* It was worth listening to Caelar's terms, even if I couldn't accept them. */ +BFSMk.SaveYourself
++ @218 /* Nobody is forcing me to go anywhere. Trust me. */ + BFSMk.TrustE
END

IF ~~ BFSMk.SaveYourself
SAY @219 /* Someone always needs saving. That won't change. Freedom's worth more. */
IF ~~ + BFSMk.Premonition
END

IF ~~ BFSMk.TrustE
SAY @220 /* I do. I trust you. */ 
IF ~~ + BFSMk.SaveYourself
END

IF ~~ BFSMk.Premonition
SAY @221 /* Trouble's never far. Not with you. Someday it'll grow too much. Become the kind I can't save you from. */
= @222 /* Even if I want to. Some changes beyond a goblin's power. */ 
++ @223 /* While I appreciate your bravery, M'Khiin, I never want you to place yourself in danger for me. */ + BFSMk.PlaceInDanger
++ @224 /* I'd never lower myself to needing your help. */ + BFSMk.HelpEww
++ @225 /* I don't believe that, I know how strong you are. You're capable of more than you think. */ + BFSMk.Capable
END

IF ~~ BFSMk.PlaceInDanger
SAY @226 /* ...What? We're already in danger. Have been this entire time. */
IF ~~ + BFSMk.FreeForMe
END

IF ~~ BFSMk.HelpEww
SAY @227 /* Might not have a choice. Not if those too-talls are deciding. */
= @228 /* Be careful. */ 
IF ~~ THEN DO ~SetGlobal("BFSMkAggressiveNegotations","GLOBAL",2)~ EXIT
END

IF ~~ BFSMk.Capable
SAY @229 /* Not a matter of being capable. */ 
IF ~~ + BFSMk.FreeForMe
END 

IF ~~ BFSMk.FreeForMe
SAY @230 /* Broke free of a cage once. Could do it again. Easier if you're there too. */ 
= @231 /* But if those too-talls are deciding… I won't get the chance. */
= @228 /* Be careful. */ 
IF ~~ THEN DO ~SetGlobal("BFSMkAggressiveNegotations","GLOBAL",2)~ EXIT
END

// Post Avernus
IF ~Global("BFSMkAvernus","GLOBAL",1)~ THEN BEGIN BFSMk.PostAvernus 
SAY @232 /* We made it. Wasn't sure we would. */
= @233 /* Feel like I can sleep for days after that mess. */ 
++ @234 /* Thanks for your help, M'Khiin. */ + BFSMk.AvernusThanks
++ @235 /* I rather feel like I can sleep for a whole week myself. */ + BFSMk.AvernusSleep
++ @236 /* What did you think of Avernus? */ + BFSMk.Avernus
++ @237 /* Are you going to join the celebration? */ + BFSMk.CelebrateGoodTimes
END

IF ~~ BFSMk.AvernusThanks
SAY @238 /* Wouldn't leave a friend behind. Not if I can help it. */
= @239 /* Gonna find somewhere quiet. For now. Before the too-talls get to drinking. */
IF ~~ THEN DO ~SetGlobal("BFSMkAvernus","GLOBAL",2)~ EXIT
END

IF ~~ BFSMk.Avernus
SAY @240 /* Too warm. Didn't like the moving floors. */
= @241 /* But where you go, I'll try to follow. */ 
= @239 /* Gonna find somewhere quiet. For now. Before the too-talls get to drinking. */
IF ~~ THEN DO ~SetGlobal("BFSMkAvernus","GLOBAL",2)~ EXIT
END

IF ~~ BFSMk.AvernusSleep
SAY @242 /* You've earned it. */
= @239 /* Gonna find somewhere quiet. For now. Before the too-talls get to drinking. */
IF ~~ THEN DO ~SetGlobal("BFSMkAvernus","GLOBAL",2)~ EXIT
END

IF ~~ BFSMk.CelebrateGoodTimes
SAY @243 /* Not sure there's place for a goblin. Especially when the too-talls get to drinking. */
= @244 /* Better to find a quiet spot and stay out of sight. */ 
IF ~~ THEN DO ~SetGlobal("BFSMkAvernus","GLOBAL",2)~ EXIT
END  

// Player Initiated Dialogue (PID)
IF ~IsGabber(Player1)~ BFSMk.PID    			
SAY @245 /* Something to say? */ 
+ ~RandomNum(5,1)~ + @246 /* How are you doing? */ + BFSMk.HowU1
+ ~RandomNum(5,2)~ + @246 /* How are you doing? */ + BFSMk.HowU2
+ ~RandomNum(5,3)~ + @246 /* How are you doing? */ + BFSMk.HowU3
+ ~RandomNum(5,4)~ + @246 /* How are you doing? */ + BFSMk.HowU4
+ ~HPPercentLT("MKHIIN",80) RandomNum(5,5)~ + @246 /* How are you doing? */ + BFSMk.HowU5
+ ~Global("BFSKinShamanPID","GLOBAL",0)~ + @247 /* How did you learn to speak with spirits? */ + BFSMk.ISeeDeadPeople
+ ~Global("BFSKinFearPID","GLOBAL",0)~ + @248 /* Is there anything you fear? */ + BFSMk.FearIsTheMindKiller
+ ~GlobalGT("BFSKinFriendshipTalks","GLOBAL",4) Global("BFSKinFaveFoodKin","GLOBAL",0)~ + @249 /* I never got around to asking you. What's your favorite thing to eat? */ + BFSMk.OmNomKin
++ @250 /* Let's keep moving. */ + BFSMk.PIDEnd
END

IF ~~ BFSMk.HowU1
SAY @251 /* Surviving. */ 
IF ~~ EXIT
END

IF ~~ BFSMk.HowU2
SAY @252 /* I'm doing. */ 
IF ~~ EXIT
END

IF ~~ BFSMk.HowU3
SAY @253 /* How am I doing *what*? */ 
IF ~~ EXIT
END

IF ~~ BFSMk.HowU4
SAY @254 /* Compared to who? */ 
IF ~~ EXIT
END

IF ~~ BFSMk.HowU5
SAY @255 /* Still standing. But barely. */ 
IF ~~ EXIT
END

IF ~~ BFSMk.PIDEnd
SAY @256 /* Ready for whatever comes next. */ 
IF ~~ EXIT
END

IF ~~ BFSMk.OmNomKin
SAY @257 /* Whatever doesn't try to eat me first. */ 
IF ~~ THEN DO ~SetGlobal("BFSKinFaveFoodKin","GLOBAL",1)~ EXIT
END

IF ~~ BFSMk.ISeeDeadPeople
SAY @258 /* Didn't learn. Not like that. Words don't matter. You gotta listen. */
IF ~~ THEN DO ~SetGlobal("BFSKinShamanPID","GLOBAL",1)~ EXIT
END

IF ~~ BFSMk.FearIsTheMindKiller
SAY @259 /* Nothing worth sharing. Fear gets you killed. */
IF ~~ THEN DO ~SetGlobal("BFSKinFearPID","GLOBAL",1)~ EXIT
END

END // FOR APPEND