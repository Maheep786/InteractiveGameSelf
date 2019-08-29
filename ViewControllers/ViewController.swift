//
//  ViewController.swift
//  InteractiveGameSelf
//
//  Created by Maheep on 29/08/19.
//  Copyright © 2019 splashTeam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startAdventure" {
            
            do {
                if let name = nameTextField.text{
                    if  name == ""{
                    throw AdventureError.NameNotProvided
                    } else {
                        guard let pageController = segue.destination as? PageController else {return}
                        
                        pageController.page = Adventure.story(withName: name)
                    }
            }
                
            } catch AdventureError.NameNotProvided {
                let alertController = UIAlertController(title: "Name not Provided", message: "Please provide name to continue.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(action)
                
                present(alertController, animated: true, completion: nil)
            } catch {
                fatalError("name not provided")
                
            }
        }
    }


}

