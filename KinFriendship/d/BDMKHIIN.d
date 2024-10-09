APPEND BDMKHIIN

// Talk 1- she appreciates that you helped her, but it was still a little sus of you
// alter this below line to the right variables + names
IF WEIGHT #-1 ~Global("BFSFriendshipTalks","GLOBAL",2)~ THEN BEGIN BFSMk.Talk1
SAY ~So why'd you help me? Goblins don't usually get kindness for free.~
++ ~It seemed like the right thing to do.~ + BFSMk.Right
++ ~I don't believe in enslaving others.~ + BFSMk.Slavery
++ ~Because now you owe me a favor.~ + BFSMk.Favor
++ ~Baeloth's blabbering bored me.~ + BFSMk.BaelothEww
++ ~Be quiet, will you? I'm not here to be your friend.~ + BFSMk.Shutup
END

IF ~~ BFSMk.BaelothEww
SAY ~You talk a little like him now.~
IF ~~ + BFSMk.WorldNorm
END

IF ~~ BFSMk.Right
SAY ~The drow said the same right before he broke his promise.~
IF ~~ +BFSMk.WorldNorm
END

IF ~~ BFSMk.Slavery
SAY ~Many wouldn't call stuffing a goblin in a cage slavery. Guess that makes you different.~
IF ~~ + BFSMk.WorldNorm
END

IF ~~ BFSMk.Favor
SAY ~Knew it. Knew there was some catch. So what do you want?~
++ ~I haven't decided yet.~ + BFSMk.WorldNorm
++ ~Some peace and quiet would be nice to start with.~ + BFSMk.Shutup2
+ ~OR(4) Race(Player1,ELF) Race(Player1,HUMAN) Race(Player1,HALFORC) Race(Player1,HALF_ELF)~ + ~I need fodder for my army. You're perfect for the role.~ + BFSMk.FodderTall
+ ~OR(3) Race(Player1,DWARF) Race(Player1,GNOME) Race(Player1,HALFLING)~ + ~I need fodder for my army. You're perfect for the role.~ + BFSMk.FodderShort
END

IF ~~ BFSMk.Shutup2
SAY ~Spent too much time around the drow. Be quiet, M'khiin.~
IF ~~ EXIT
END


IF ~~ BFSMk.FodderTall
SAY ~Could've picked someone taller for that.~
IF ~~ + BFSMk.WorldNorm
END

IF ~~ BFSMk.FodderShort
SAY ~Good thing you're short then.~
IF ~~ + BFSMk.WorldNorm
END

IF ~~ BFSMk.Shutup
SAY ~Didn't think you were. Was trying to figure out what you *did* want.~
IF ~~ EXIT
END

IF ~~ BFSMk.WorldNorm
SAY ~That's the way it works. The strong take from the weak. From those who are smaller. Makes life tricky for goblins, you see? Lots of folks are taller and stronger than us.~
= ~Numbers could help, I suppose. But I've never had those on my side.~
++ ~M'khiin, I've helped you before. That has to count for something.~ + BFSMk.HelpBefore
++ ~I'm not asking you to trust me right away. I'm asking you to give me a chance to earn it.~ + BFSMk.EarnTrust
++ ~Just do your part and we won't have any issues. We don't need to be friends.~ + BFSMk.NotFriends
END

IF ~~ BFSMk.HelpBefore
SAY ~Maybe. Hard to believe if you've spent years struggling on your own.~
IF ~~ + BFSMk.Cont
END

IF ~~ BFSMk.EarnTrust
SAY ~Would be nice to be wrong about someone for once. Guess we'll see, I'm not going anywhere.~
IF ~~ + BFSMk.Cont
END

IF ~~ BFSMk.NotFriends
SAY ~Simple terms. I can respect that.~
IF ~~ + BFSMk.Cont
END

IF ~~ BFSMk.Cont
SAY ~Haven't been around others much. Not since leaving my tribe.~
= ~The drow's hospitality doesn't count. Don't think being prodded with sticks should count as socializing.~
= ~I haven't been much good at that either. Talking, I mean.~ 
++ ~Relax, M'khiin, I don't have any expectations.~ + BFSMk.Cont2
++ ~I could tell. No, really.~ + BFSMk.Cont2
+ ~Class(Player1,BARD)~ + ~Then it's a good thing I talk enough for both of us.~ + BFSMk.Cont2
+ ~!Class(Player1,SHAMAN)~ + ~But you're a shaman. You talk to spirits all the time, don't you?~ + BFSMk.ShamanConverse
+ ~Class(Player1,SHAMAN)~ + ~But you're a shaman too. Talking to spirits is what we *do*.~ + BFSMk.ShamanConverse
++ ~Stop talking. Now. I'm not interested.~ + BFSMk.Shutup2
END

IF ~~ BFSMk.ShamanConverse
SAY ~Spirits don't need small talk. Makes it easier that way.~ 
IF ~~ + BFSMk.Cont2
END

IF ~~ BFSMk.Cont2
SAY ~We should move on. I'm talking too much already. Not saying I'm comfortable yet but…thank you for helping. Even if you had other reasons for it.~
IF ~~ DO ~SetGlobal("BFSKinFriendshipTalks","GLOBAL",3) RealSetGlobalTimer("BFSKinFriendshipTalksTimer","GLOBAL",3600)~ EXIT
END



END // FOR APPEND