//
//  Model.swift
//  testingAPI
//
//  Created by Maxim Mitin on 9.08.21.
//

import Foundation

struct Joke: Decodable {
    var category: String
    var jokeQuestion: String
    var jokeAnswer: String
}
