// Interjections 
I_C_T BDZIATAR 0 BFSMk.Ziatar
== BDMKHIIJ IF ~InParty("MKHIIN") InMyArea("MKHIIN") !StateCheck("MKHIIN",CD_STATE_NOTVALID)~ THEN ~Simple. Walked right in.~
END

APPEND BDMKHIIJ

// Talk 1- she appreciates that you helped her, but it was still a little sus of you
IF WEIGHT #-2 ~Global("BFSKinFriendshipTalks","GLOBAL",2)~ THEN BEGIN BFSMk.Talk1
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
SAY ~Didn't think you were. Was trying to figure out what you *did* want.~
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
SAY ~Maybe. Still hard to believe.~
IF ~~ + BFSMk.Cont
END

IF ~~ BFSMk.EarnTrust
SAY ~Would be nice to be wrong. Guess we'll see. I'm not going anywhere.~
IF ~~ + BFSMk.Cont
END

IF ~~ BFSMk.NotFriends
SAY ~Simple terms. I can respect that.~
IF ~~ + BFSMk.Cont
END

IF ~~ BFSMk.Cont
SAY ~Haven't been around others much. Not since leaving the tribe.~
= ~The drow's hospitality don't count. Being prodded with sticks and all.~
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
IF WEIGHT #-1 ~Global("BFSKinFriendshipTalks","GLOBAL",4)~ THEN BEGIN BFSMk.Talk2
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
// Word this line better OMG
SAY ~What food do you prefer?~
++ ~I can't pick a favourite.~ + BFSMk.NoFave
++ ~Roasted chicken. You can't go wrong with a classic.~ + BFSMk.Chicken
++ ~I prefer a hearty stew. Simple but delicious.~ + BFSMk.StewYum
++ ~Stonebread. It lasts even when the road's rough.~ + BFSMk.Yum
++ ~Starfruit tart. It's delicate and flaky with just a hint of sweetness.~ + BFSMk.Yum
++ ~I'm fond of savoury rice. Anything with a bit of spice really.~ + BFSMk.Yum
+ ~Class(Player1,DRUID)~ + ~Foraged meals. Nature provides whatever I need.~ + BFSMk.ClassCircleBack
+ ~Class(Player1,MONK)~ + ~I prefer simple meals. Food should nourish the body and mind.~ + BFSMk.ClassCircleBack
END

IF ~~ BFSMk.ClassCircleBack
SAY ~If we come by something good, I'll leave more for you.~
++ ~No. You don't have to go hungry on my account.~ +  BFSMk.MealTalkEnd
++ ~Fair enough. If we come across anything you like, tell me and I'll return the favor.~ + BFSMk.MealTalkEnd
++ ~Sounds like a plan.~ + BFSMk.MealTalkEnd
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
SAY ~Stew's not bad. Learned to make some after leaving the tribe.~
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
= ~Need to know where I stand. What's my share?~
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

// Scenery Talks
// Dragon Cave Warning
IF ~Global("BFSMkDragon","GLOBAL",1)~ BFSMk.DragonWarning
SAY ~Spirits stir. Something's up ahead.~
++ ~It's nothing we can't handle.~ + BFSMk.DragonThanks
++ ~I appreciate the warning, but we've no choice but to press ahead.~ + BFSMk.DragonThanks
++ ~We'll tread lightly. Keep your voice low.~ + BFSMk.DragonQuiet
++ ~The snoring gave that away.~ + BFSMk.DragonThanks
+ ~Class(Player1,SHAMAN)~ + ~I hear them too. We should be cautious.~ + BFSMk.DragonThanks
END

IF ~~ BFSMk.DragonThanks
SAY ~Right. I'll be here.~ 
IF ~~ DO ~SetGlobal("BFSMkDragon","GLOBAL",2)~ EXIT
END

IF ~~ BFSMk.DragonQuiet
SAY ~Won't matter. Not with all the snoring.~ 
IF ~~ DO ~SetGlobal("BFSMkDragon","GLOBAL",2)~ EXIT
END

// Dragon Dead
IF ~Global("BFSMkDragon","GLOBAL",3)~ BFSMK.DragonDead
SAY ~Dead now. Spirits are quieter.~
IF ~~ DO ~SetGlobal("BFSMkDragon","GLOBAL",4)~ EXIT
END

// Post Boareskyr Bridge, she's *trying* 
IF ~Global("BFSMkBoareskyr","GLOBAL",3)~ THEN BEGIN BFSMk.Boareskyr
SAY ~Hmph. You help 'em, something bad happens, now they don't like you anymore. Been the same for me. One look and the worst thoughts start crawling in. Don't blame 'em. Haven't had good experiences with goblins either.~
= ~Just a scorch mark on the ground. You're still the same <CHARNAME>.~
++ ~M'Khiin, are you trying to comfort me?~ + BFSMk.Console
++ ~Being judged for *what* you are, rather than who you are, is the worst.~ + BFSMk.Console
++ ~I don't need your sympathy, M'Khiin. Back off..~ + BFSMk.NoScrubs
++ ~Don't even think about comparing yourself to me.~ + BFSMk.NoComparison
END

IF ~~ BFSMk.Console
SAY ~Maybe I'm being sensible. Lots of the too-talls aren't.~
= ~But if you feel better. Yes. That was my intent.~ 
++ ~Thank you. I appreciate it.~ + BFSMk.Kind
++ ~Oddly enough that does make me feel better.~ + BFSMk.Kind
++ ~There's more going on here than you realize, M'Khiin. Different faiths. Different cities.~ + BFSMk.Overcomplicated
++ ~They don't. So leave me alone.~ + BFSMk.NoScrubs
END

IF ~~ BFSMk.Overcomplicated
SAY ~Too much noise for one goblin's head. Could make it simpler. But don't think you will.~
IF ~~ + BFSMk.Kind
END

IF ~~ BFSMk.Kind
SAY ~I'll brew you a stew. Mushroom and moss. Good for the soul. I'm a shaman, I'd know.~
++ ~I'll pass.~ + BFSMk.NoSoup
++ ~I appreciate the thought, but it would be rude not to share with the whole army. We'll have to wait.~ + BFSMk.NoSoup
++ ~That sounds delicious! Count me in!~ + BFSMk.YesSoup
++ ~No, M'Khiin. Just…no.~ + BFSMk.NoSoup
+ ~Class(Player1,DRUID)~ + ~I'd love to trade remedies with you. It's not often I can talk with a Goblin Shaman.~ + BFSMk.DruidStew
END

IF ~~ BFSMk.NoSoup
SAY ~More for me then.~ 
IF ~~ THEN DO ~SetGlobal("BFSMkBoareskyr","GLOBAL",4)~ EXIT
END

IF ~~ BFSMk.YesSoup
SAY ~Might be looking forward to it .~
IF ~~ THEN DO ~SetGlobal("BFSMkBoareskyr","GLOBAL",4)~ EXIT
END

IF ~~ BFSMk.DruidStew
SAY ~Not often you'd want to. Wouldn't mind sharing though. Not with you.~
IF ~~ THEN DO ~SetGlobal("BFSMkBoareskyr","GLOBAL",4)~ EXIT
END

IF ~~ BFSMk.NoScrubs
SAY ~I know about being unwanted. Or being were you don't want to be.~
IF ~~ THEN DO ~SetGlobal("BFSMkBoareskyr","GLOBAL",4)~ EXIT
END

IF ~~ BFSMk.NoComparison
SAY ~Why not? Seems similar. People think you're a monster. Maybe you are, maybe you're not. Doesn't matter. They already made up their minds.~ 
= ~You're still you though.~ 
IF ~~ THEN DO ~SetGlobal("BFSMkBoareskyr","GLOBAL",4)~ EXIT
END

// Player Initiated Dialogue (PID)
IF ~IsGabber(Player1)~ BFSMk.PID    			
SAY ~Something to say?~ 
+ ~RandomNum(4,1)~ + ~How are you doing?~ + BFSMk.HowU1
+ ~RandomNum(4,2)~ + ~How are you doing?~ + BFSMk.HowU2
+ ~RandomNum(4,3)~ + ~How are you doing?~ + BFSMk.HowU3
+ ~HPPercentLT("MKHIIN",80) RandomNum(4,4)~ + ~How are you doing?~ + BFSMk.HowU4
+ ~Global("BFSKinShamanPID","GLOBAL",0)~ + ~How did you learn to speak with spirits?~ + BFSMk.ISeeDeadPeople
+ ~Global("BFSKinTribePID","GLOBAL",0)~ + ~Why did you leave your tribe?~ + BFSMk.MkhiinSolo
+ ~Global("BFSKinFearPID","GLOBAL",0)~ + ~Is there anything you fear?~ + BFSMk.FearIsTheMindKiller
+ ~Global("BFSKinSpellPID","GLOBAL",0)~ + ~What's your favourite spell?~ + BFSMk.MagicHands
+ ~GlobalGT("BFSKinFriendshipTalks","GLOBAL",4) Global("BFSKinFaveFoodKin","GLOBAL",0)~ + ~I never got around to asking you. What's your favorite thing to eat?~ + BFSMk.OmNomKin
++ ~Let's keep moving.~ + BFSMk.PIDEnd
END

IF ~~ BFSMk.HowU1
SAY ~Surviving.~ 
IF ~~ EXIT
END

IF ~~ BFSMk.HowU2
SAY ~Could be better. Could be worse.~ 
IF ~~ EXIT
END

IF ~~ BFSMk.HowU3
SAY ~Couldn't be better!~ 
IF ~~ EXIT
END

IF ~~ BFSMk.HowU4
SAY ~Still standing. But barely.~ 
IF ~~ EXIT
END

IF ~~ BFSMk.PIDEnd
SAY ~Ready for whatever comes next.~ 
IF ~~ EXIT
END

IF ~~ BFSMk.OmNomKin
SAY ~Anything that doesn't try to eat me first.~ 
IF ~~ THEN DO ~SetGlobal("BFSKinSpellPID","GLOBAL",1)~ EXIT
END

IF ~~ BFSMk.MagicHands
SAY ~Whatever keeps me alive the longest.~
IF ~~ THEN DO ~SetGlobal("BFSKinFaveFoodKin","GLOBAL",1)~ EXIT
IF ~~ EXIT
END

IF ~~ BFSMk.ISeeDeadPeople
SAY ~Didn't learn. Not like that. Words don't matter. You gotta listen.~
IF ~~ THEN DO ~SetGlobal("BFSKinShamanPID","GLOBAL",1)~ EXIT
END

IF ~~ BFSMk.MkhiinSolo
SAY ~Didn't fit. Simple as that.~
IF ~~ THEN DO ~SetGlobal("BFSKinTribePID","GLOBAL",1)~ EXIT
END

IF ~~ BFSMk.FearIsTheMindKiller
SAY ~Nothing worth sharing. Fear gets you killed.~
IF ~~ THEN DO ~SetGlobal("BFSKinFearPID","GLOBAL",1)~ EXIT
END

END // FOR APPEND