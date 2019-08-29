//
//  PageController.swift
//  InteractiveGameSelf
//
//  Created by Maheep on 29/08/19.
//  Copyright © 2019 splashTeam. All rights reserved.
//

import UIKit

extension NSAttributedString{
    var stringLenght: NSRange{
        return NSMakeRange(0, self.length)
    }
}


extension Page{
    func story(attributed: Bool) -> NSAttributedString {
        if attributed {
            return story.attributed
        } else {
            return NSAttributedString(string: story.text)
        }
    }
}

extension Story {
    
    var attributed: NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 10
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: attributedString.stringLenght)
        return attributedString
    }
}

class PageController: UIViewController {
    
    var page: Page?
    
    lazy var artwork: UIImageView = {
        let art = UIImageView()
        art.translatesAutoresizingMaskIntoConstraints = false
        art.image = self.page?.story.artwork
        return art
    } ()
    
    lazy var storyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = self.page?.story(attributed: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var firstChoiceButton: UIButton = {
        let button = UIButton(type: .system)
        let title = self.page?.firstChoice?.title ?? "Play Again"
        let selector = self.page?.firstChoice != nil ? #selector(PageController.loadFirstChoice) : #selector(PageController.playAgain)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    } ()

    lazy var secondChoiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle(self.page?.secondChoice?.title, for: .normal)
        button.addTarget(self, action: #selector(PageController.loadSecondChoice), for: .touchUpInside)

        return button
    } ()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(page: Page){
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(artwork)
        view.addSubview(storyLabel)
        view.addSubview(firstChoiceButton)
        view.addSubview(secondChoiceButton)
        
        
        NSLayoutConstraint.activate([
            artwork.topAnchor.constraint(equalTo: view.topAnchor),
            artwork.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            artwork.leftAnchor.constraint(equalTo: view.leftAnchor),
            artwork.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            storyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            storyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            storyLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -48.0),
            
            firstChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80.0),
            firstChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            secondChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40.0),
            secondChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
            
            ])
        
        
        
        
        
    }
    
    
    
    
    // MARK: - Helper Methods
    
    @objc func loadFirstChoice(){
        if let page = page, let firstChoice = page.firstChoice {
            let nextPage = firstChoice.page
            let pageContoller = PageController(page: nextPage)
        
            navigationController?.pushViewController(pageContoller, animated: true)
        }
        
    }
    
    @objc func loadSecondChoice() {
        if let page = page, let secondChoice = page.secondChoice {
            let nextPage = secondChoice.page
            let pageController = PageController(page: nextPage)
            
            navigationController?.pushViewController(pageController, animated: true)
        }
    }
    
    
    @objc func playAgain () {
        navigationController?.popToRootViewController(animated: true)
    }

}
