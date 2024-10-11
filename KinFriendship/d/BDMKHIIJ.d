APPEND BDMKHIIJ

// Talk 1- she appreciates that you helped her, but it was still a little sus of you
IF WEIGHT #-1 ~Global("BFSKinFriendshipTalks","GLOBAL",2)~ THEN BEGIN BFSMk.Talk1
SAY ~Why'd you help me? Goblins don't get kindness for free.~
++ ~It felt like the right thing to do.~ + BFSMk.Right
++ ~I don't believe in enslaving anyone.~ + BFSMk.Slavery
++ ~Because you owe me now.~ + BFSMk.Favor
++ ~Baeloth's babbling bored me.~ + BFSMk.BaelothEww
++ ~Be quiet, will you? I'm not here to be your friend.~ + BFSMk.Shutup
END

IF ~~ BFSMk.BaelothEww
SAY ~Starting to sound like him. Careful.~
IF ~~ + BFSMk.WorldNorm
END

IF ~~ BFSMk.Right
SAY ~Drow said the same. Right before he broke his word.~
IF ~~ +BFSMk.WorldNorm
END

IF ~~ BFSMk.Slavery
SAY ~Most won't call caging a goblin slavery. Guess that makes you different.~
IF ~~ + BFSMk.WorldNorm
END

IF ~~ BFSMk.Favor
SAY ~Knew it. Knew there was some catch. So, what do you want?~
++ ~I haven't decided yet.~ + BFSMk.WorldNorm
++ ~Some peace and quiet would be a start.~ + BFSMk.Shutup2
+ ~OR(4) Race(Player1,ELF) Race(Player1,HUMAN) Race(Player1,HALFORC) Race(Player1,HALF_ELF)~ + ~I need fodder for my army. You're perfect for the role.~ + BFSMk.FodderTall
+ ~OR(3) Race(Player1,DWARF) Race(Player1,GNOME) Race(Player1,HALFLING)~ + ~I need fodder for my army. You're perfect for the role.~ + BFSMk.FodderShort
END

IF ~~ BFSMk.Shutup2
SAY ~Been around the drow too long.~
IF ~~ DO ~SetGlobal("BFSKinFriendshipTalks","GLOBAL",3) RealSetGlobalTimer("BFSKinFriendshipTalksTimer","GLOBAL",3600)~ EXIT
END


IF ~~ BFSMk.FodderTall
SAY ~Could've picked someone taller.~
IF ~~ + BFSMk.WorldNorm
END

IF ~~ BFSMk.FodderShort
SAY ~Good thing you're short then.~
IF ~~ + BFSMk.WorldNorm
END

IF ~~ BFSMk.Shutup
SAY ~Didn't think you were. Was trying t'figure out what you *did* want.~
IF ~~ DO ~SetGlobal("BFSKinFriendshipTalks","GLOBAL",3) RealSetGlobalTimer("BFSKinFriendshipTalksTimer","GLOBAL",3600)~ EXIT
END

IF ~~ BFSMk.WorldNorm
SAY ~That's how it works. The strong take from the weak. From those smaller. Makes life tricky for goblins. Lots of folks are taller and stronger.~
= ~Numbers could help, but I've never had those either.~
++ ~M'khiin, I've helped you before. That has to count for something.~ + BFSMk.HelpBefore
++ ~I'm not asking you to trust me right away. I'm asking you to give me a chance to earn it.~ + BFSMk.EarnTrust
++ ~Just do your part and we won't have any issues. We don't need to be friends.~ + BFSMk.NotFriends
END

IF ~~ BFSMk.HelpBefore
SAY ~Maybe. Still hard t'believe.~
IF ~~ + BFSMk.Cont
END

IF ~~ BFSMk.EarnTrust
SAY ~Would be nice t'be wrong. Guess we'll see. I'm not going anywhere.~
IF ~~ + BFSMk.Cont
END

IF ~~ BFSMk.NotFriends
SAY ~Simple terms. I can respect that.~
IF ~~ + BFSMk.Cont
END

IF ~~ BFSMk.Cont
SAY ~Haven't been around others much. Not since leaving the tribe.~
= ~The drow's hospitality doesn't count. Being prodded with sticks and all.~
++ ~Relax, M'khiin, I don't have any expectations.~ + BFSMk.Cont2
+ ~Class(Player1,BARD)~ + ~Then it's a good thing I talk enough for both of us.~ + BFSMk.Cont2
+ ~!Class(Player1,SHAMAN)~ + ~But you're a shaman. You talk to spirits all the time, don't you?~ + BFSMk.ShamanConverse
+ ~Class(Player1,SHAMAN)~ + ~But you're a shaman too. Talking to spirits is what we *do*.~ + BFSMk.ShamanConverse
++ ~Stop talking. Now. I'm not interested.~ + BFSMk.Shutup2
END

IF ~~ BFSMk.ShamanConverse
SAY ~Spirits don't need small talk. Makes it easier.~ 
IF ~~ + BFSMk.Cont2
END

IF ~~ BFSMk.Cont2
SAY ~We should move. Talked too much already.~
IF ~~ DO ~SetGlobal("BFSKinFriendshipTalks","GLOBAL",3) RealSetGlobalTimer("BFSKinFriendshipTalksTimer","GLOBAL",3600)~ EXIT
END

// Talk 2 - A matter of food / resources and fitting in
IF WEIGHT #-2 ~Global("BFSKinFriendshipTalks","GLOBAL",4)~ THEN BEGIN BFSMk.Talk2
SAY ~Been thinking. How much food can I take?~  
++ ~Why are we even having this conversation?~ + BFSMk.WhyDiscussFood
+ ~InParty("Minsc")~ + ~As a member of this group, you receive an equal share of every meal.~ + BFSMk.EqualFoodM
+ ~!InParty("Minsc")~ + ~As a member of this group, you receive an equal share of every meal.~ + BFSMk.EqualFood
+ ~InParty("Minsc")~ + ~Goblins are small. You don't need much.~ + BFSMk.FoodSmallM
+ ~!InParty("Minsc")~ + ~Goblins are small. You don't need much.~ + BFSMk.FoodSmall
++ ~I don't have time for this. Figure it out yourself.~ + BFSMk.MealConfuse
END

IF ~~ BFSMk.EqualFoodM
SAY ~Don't solve things though. I'm smaller. Won't need as much.~ 
= ~Too-tall may need more. Keeps sharing with that rodent of his.~
IF ~~ + BFSMk.FoodTell
END

IF ~~ BFSMk.EqualFood
SAY ~Don't solve things though. I'm smaller. Won't need as much.~
IF ~~ + BFSMk.FoodTell
END

IF ~~ BFSMk.FoodSmallM
SAY ~Don't solve things though. Some days I need more. Less on others.~
= ~And too-tall keeps sharing with that rodent of his.~
IF ~~ + BFSMk.FoodTell
END

IF ~~ BFSMk.FoodSmall
SAY ~Don't solve things though. Some days I need more. Less on others.~
IF ~~ + BFSMk.FoodTell
END

IF ~~ BFSMk.FoodTell
SAY ~What'd'you like t'eat?~
++ ~I can't pick a favourite.~ + BFSMk.NoFave
++ ~Roasted chicken. You can't go wrong with a classic.~ + BFSMk.Chicken
++ ~I prefer a hearty stew. Simple but delicious.~ + BFSMk.StewYum
++ ~Stonebread. It lasts even when the road's rough.~ + BFSMk.Yum
++ ~Starfruit tart. It's delicate and flaky with just a hint of sweetness.~ + BFSMk.Yum
++ ~I'm fond of savoury rice. Anything with a bit of spice really.~ + BFSMk.Yum
END

IF ~~ BFSMk.NoFave
SAY ~Beggars can't be choosers. Know that.~
= ~If we come by something good, I'll leave more for you.~
++ ~No. You don't have to go hungry on my account.~ +  BFSMk.MealTalkEnd
++ ~Fair enough. If we come across anything you like, tell me and I'll return the favor.~ + BFSMk.MealTalkEnd
++ ~Sounds like a plan.~ + BFSMk.MealTalkEnd
END

IF ~~ BFSMk.Chicken
SAY ~Like it too.~ 
= ~If we come by one, I'll leave more for you.~ 
++ ~No. You don't have to go hungry on my account.~ +  BFSMk.MealTalkEnd
++ ~Fair enough. If we come across anything you like, tell me and I'll return the favor.~ + BFSMk.MealTalkEnd
++ ~Sounds like a plan.~ + BFSMk.MealTalkEnd
END

IF ~~ BFSMk.StewYum
SAY ~Stew's not bad. Learned t'make some after leaving the tribe.~
= ~If we come by it, I'll leave more for you.~ 
++ ~No. You don't have to go hungry on my account.~ +  BFSMk.MealTalkEnd
++ ~Fair enough. If we come across anything you like, tell me and I'll return the favor.~ + BFSMk.MealTalkEnd
++ ~Sounds like a plan.~ + BFSMk.MealTalkEnd
END

IF ~~ BFSMk.Yum
SAY ~Ain't tried that. If we come by it, I'll leave more for you.~
++ ~No. You don't have to go hungry on my account.~ +  BFSMk.MealTalkEnd
++ ~Fair enough. If we come across anything you like, tell me and I'll return the favor.~ + BFSMk.MealTalkEnd
++ ~Sounds like a plan.~ + BFSMk.MealTalkEnd
END

IF ~~ BFSMk.WhyDiscussFood
SAY ~Tribe fought over food. The fastest or strongest ate first. Everyone else got what's left.~
= ~Goblins settle for anything. Have to. We don't farm. Don't grow. We steal, we scrounge, we dig through what others throw away. Scraps of scraps.~ 
= ~Need t'know where I stand. What's my share?~
+ ~InParty("Minsc")~ + ~As a member of this group, you receive an equal share of every meal.~ + BFSMk.EqualFoodM
+ ~!InParty("Minsc")~ + ~As a member of this group, you receive an equal share of every meal.~ + BFSMk.EqualFood
+ ~InParty("Minsc")~ + ~Goblins are small. You don't need much.~ + BFSMk.FoodSmallM
+ ~!InParty("Minsc")~ + ~Goblins are small. You don't need much.~ + BFSMk.FoodSmall
++ ~I don't have time for this. Figure it out yourself.~ + BFSMk.MealConfuse
END

IF ~~ BFSMk.MealConfuse
SAY ~Will scrounge for my own meals. Might be easier that way.~ 
IF ~~ EXIT
END

IF ~~ BFSMk.MealTalkEnd
SAY ~I like that. Wouldn't work in a goblin tribe though.~
= ~Good thing I'm not in one.~ 
IF ~~ DO ~SetGlobal("BFSKinFriendshipTalks","GLOBAL",5) RealSetGlobalTimer("BFSKinFriendshipTalksTimer","GLOBAL",3600)~ EXIT
END

// PID 
IF ~IsGabber(Player1)~ BFSMk.PID    			
SAY ~Something t'say?~ 
++ ~I have a few questions.~ + BFSMk.QuestionHub
++ ~Let's keep moving.~ + BFSMk.PIDEnd
END

IF ~~ BFSMk.PIDEnd
SAY ~Good. We've wasted enough time.~ 
IF ~~ EXIT
END

IF ~~ BFSMk.QuestionHub
SAY ~Ask then.~ 
++ ~Do you miss being around your kind?~ + BFSMk.MissHome
++ ~How did you learn to speak with spirits?~ + BFSMk.SpiritOrigin
// ++ ~Why do goblins live the way they do?~ + BFSMk.GoblinCulture // because Maglubiyet (check spelling) and always being pushed around
++ ~I have no further questions.~ + BFSMk.PIDEnd
END

IF ~~ BFSMk.SpiritOrigin
SAY ~Didn't learn. Not like that. Words don't matter. You gotta listen.~
// expand here
IF ~~ EXIT
END

IF ~~ BFSMk.MissHome
SAY ~No. Here is better.~
++ ~Care to elaborate on that?~ + BFSMk.FixThings
++ ~Well, I'm glad you're happy.~ + BFSMk.HappyNotWithGoblins
++ ~Wouldn't you rather fix things with your tribe, instead of wandering with strangers?~ + BFSMk.FixThings
END

IF ~~ BFSMk.HappyNotWithGoblins
SAY ~Got a full belly. A safe spot t'sleep. Had worse.~  
IF ~~ EXIT
END

IF ~~ BFSMk.FixThings
SAY ~Better t'talk t'strangers. Tribe heard me, didn't understand, didn't want to.~
= ~So I left.~
IF ~~ EXIT
END

END // FOR APPEND