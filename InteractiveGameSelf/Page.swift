//
//  Page.swift
//  InteractiveGameSelf
//
//  Created by Maheep on 29/08/19.
//  Copyright © 2019 splashTeam. All rights reserved.
//

import Foundation

class Page {
    let story: Story
    
    typealias Choice = (title: String, page: Page)
    
    var firstChoice: Choice?
    var secondChoice: Choice?
    
    init(story: Story) {
        self.story = story
    
    }
}


extension Page {
    func addChoiceWith(title: String, story: Story) -> Page{
        let page = Page(story: story)
        return addChoiceWith(title: title, page: page)
    }
    
    func addChoiceWith(title: String, page: Page) -> Page{
        switch (page.firstChoice, page.secondChoice) {
        case(.some, .some): return self
        case (.none, .none), (.none, .some): firstChoice = (title, page)
        case(.some, .none): secondChoice = (title, page)
        }
        
        return page
    }
}

struct Adventure{
    static func story(withName name: String) -> Page{
        let returnTrip = Page(story: .returnTrip(name: name))
        
        let touchDown = returnTrip.addChoiceWith(title: "Stop and Investigate", story: .touchDown)
        let homeward = returnTrip.addChoiceWith(title: "Continue home to Earth", story: .homeward)
        
        let rover = touchDown.addChoiceWith(title: "Explore the Rover", story: .rover(name: name)) //at touchDown
        let crate = touchDown.addChoiceWith(title: "Open the Crate", story: .crate) //at touchDown
        
        homeward.addChoiceWith(title: "head Back to Mars", page: touchDown)
        let home = homeward.addChoiceWith(title: "Continue Bck to Earth", story: .home)
        
        let cave = rover.addChoiceWith(title: "Explore the coordinates", story: .cave)
        rover.addChoiceWith(title: "Return to Earth", page: home)
        
        cave.addChoiceWith(title: "Continue towards faint light", story: .droid(name: name))
        cave.addChoiceWith(title: "Refill the ship and explore the Rover", page: rover)
        
        crate.addChoiceWith(title: "Explore the Rover", page: rover)
        crate.addChoiceWith(title: "Use the Key", story: .monster)
        

        return returnTrip
    }
}




