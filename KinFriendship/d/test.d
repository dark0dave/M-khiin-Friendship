// Scenery talks
// Post Boareskyr Bridge, she's *trying* 
IF ~Global("BFSBoareskyrBridge","GLOBAL",1)~ THEN BEGIN BFSMk.Boareskyr
SAY ~Hmph. Figures. You help them, something bad happens, now they don't like you anymore. Been the same for me. They never liked me. One look and the worst thoughts start crawling in. Don't blame 'em. Haven't had good experiences with goblins either.~
= ~Doesn't matter what you burnt into the ground. You're still the same <CHARNAME>.~
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
SAY ~Too much noise for one goblin's head. Could've make it simpler. But don't think you will.~
IF ~~ + BFSMk.Kind
END

IF ~~ BFSMk.Kind
SAY ~I'll brew you a stew. Mushroom and moss. Good for the soul. I'm a shaman, I’d know.~
++ ~I'll pass.~ + BFSMk.NoSoup
++ ~I appreciate the thought, but it would be rude not to share with the whole army. We'll have to wait.~ + BFSMk.NoSoup
++ ~That sounds delicious! Count me in!~ + BFSMk.YesSoup
++ ~No, M'Khiin. Just…no.~ + BFSMk.NoSoup
+ ~Class(Player1,DRUID)~ + ~I'd love to trade remedies with you. It's not often I can talk with a Goblin Shaman.~ + BFSMk.DruidStew
END

IF ~~ BFSMk.NoSoup
SAY ~More for me then.~ 
IF ~~ THEN DO ~SetGlobal("BFSBoareskyrBridge","GLOBAL",2)~ EXIT
END

IF ~~ BFSMk.YesSoup
SAY ~First time I'll cook for someone else. Might be looking forward to it .~
IF ~~ THEN DO ~SetGlobal("BFSBoareskyrBridge","GLOBAL",2)~ EXIT
END

IF ~~ BFSMk.DruidStew
SAY ~Not often you'd want to. Wouldn't mind sharing though. Not with you.~
IF ~~ THEN DO ~SetGlobal("BFSBoareskyrBridge","GLOBAL",2)~ EXIT
END

IF ~~ BFSMk.NoScrubs
SAY ~I know about being unwanted. Or being were you don't want to be.~
IF ~~ THEN DO ~SetGlobal("BFSBoareskyrBridge","GLOBAL",2)~ EXIT
END

IF ~~ BFSMk.NoComparison
SAY ~Why not? Seems similar. People think you're a monster. Maybe you are, maybe you're not. Doesn't matter. They already made up their minds.~ 
= ~You're still you though.~ 
IF ~~ THEN DO ~SetGlobal("BFSBoareskyrBridge","GLOBAL",2)~ EXIT
END
