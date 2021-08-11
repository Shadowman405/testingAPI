//
//  ViewController.swift
//  testingAPI
//
//  Created by Maxim Mitin on 8.08.21.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var jokeLbl: UILabel!
    @IBOutlet weak var jokeQestionLbl: UILabel!
    @IBOutlet weak var jokeAnswerLbl: UILabel!
    
    var joke = JokeAPI()
    
    @IBAction func randomJokeBtn(_ sender: Any) {
        joke.alamofireFetch { (joke) in
            if let joke = joke {
                self.jokeLbl.text = "Joke category: \(joke.category)"
                self.jokeQestionLbl.text = joke.jokeQuestion
                self.jokeAnswerLbl.text = joke.jokeAnswer
                print(joke) // оставил принт чтобы было видно что иногда сама API отдает только категорию
            }
        }
    }
}

