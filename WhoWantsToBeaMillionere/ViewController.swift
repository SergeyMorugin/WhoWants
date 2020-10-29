//
//  ViewController.swift
//  WhoWantsToBeaMillionere
//
//  Created by Matthew on 28.10.2020.
//  Copyright © 2020 Ostagram Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var lastGameResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
       
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "startGame":
            guard let destination = segue.destination as? GameViewController else { return }
            Game.shared.startGame { [weak self] in
                self?.lastGameResultLabel.text = "Previus result is \(Game.shared.gameSession!.currentQuestionNum)/\(Game.shared.gameSession!.questionsCount)"
            }
            destination.delegate = Game.shared
        default:
            break
        }
    }


}

