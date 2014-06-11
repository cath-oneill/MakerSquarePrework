def introduction
    puts ""
    puts "MURDER IN THE BARN"
    puts "by Kyle and Catherine"
    puts ""
    puts "One cold, sleety evening in January, you enter the barn to feed the horses.  You gather the hay and the alfalfa and distribute it into the feed bins.  The horses neigh with delight.  As you approach the feed room to prepare their grain, you suddenly hear a terrifying scream.  You are frozen in place with fear."
    puts "What will you do?"
    puts "Should you run away or grab your BB gun and face your fears?"
    choice1
end

def choice1    
    puts "INPUT YOUR DECISION NOW: (run/BB)"
    choiceA = gets.chomp
    
    if choiceA == "run"
        hot_chocolate
    elsif choiceA == "BB"
        gun
    else
        puts 'Please enter "run" or "BB" now.'
        choice1
    end
end

def hot_chocolate
    puts ""
    puts "You run through the dark yard toward the house.  You throw the back door open with a sigh of relief.  You warm up some hot chocolate and settle down in front of the TV.  Hopefully, the horses will live through the night.  THE END"
end

def gun
    puts ""
    puts "You creep forward in the darkness of the barn feeling for the BB gun against the wall.  You suddenly feel the barrel under your hand and sign with relief. Now that you are sufficiently armed, you approach the feed room.  Suddenly, the screaming intensifies.  You are filled with terror."
    puts "What will you do?"
    puts "Should you shoot blindly into the room with the BB gun or should you reach around the dark corner with your bare hand to turn on the light?"
    choice2
end    

def choice2
    puts "INPUT YOUR DECISION NOW: (shoot/light)"
    choiceB = gets.chomp
    
    if choiceB == "shoot"
        ricochet
    elsif choiceB == "light"
        discovery
    else
        puts 'Please enter "shoot" or "light" now.'
        choice2
    end
    
end

def ricochet
    puts ""
    puts 'You shoot blindly into the dark feed room.  The laws of physics return the BB to the middle of your forehead.  You think, "Ugh...that was stupid."'
    hot_chocolate
end

def discovery
    puts ""
    puts 'You hesitantly reach around the corner feeling for the light switch.  You touch a spider web. You reach a little further and find the switch and flick it on as the screaming reaches new heights.  To your surprise, instead of a bloody murder scene, you see a tabby cat and a frightened baby bunny.  Startled by the light, the cat runs howling into the darkness.  The bunny unharmed says, "Thanks man!  Why don\'t you treat yourself to some hot chocolate."  You think, "Damn, that\'s weird."'
    hot_chocolate
end

introduction