//
//  NetworkManager.swift
//  testingAPI
//
//  Created by Maxim Mitin on 9.08.21.
//
import Foundation
import Alamofire

private let randomURL = "https://v2.jokeapi.dev/joke/Programming"
typealias JokeResponseCompletion = (Joke?) -> Void //честно не знаю где должен быть алиас оставил в видном месте, смотрел много кто так делает

class JokeAPI {

// MARK: - Alamofire get request
    
func alamofireFetch(completion: @escaping JokeResponseCompletion) {
        AF.request(randomURL, method: .get )
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let joke = value as? [String: Any] else {return}
                    DispatchQueue.main.async {
                        let randomJoke = self.parseJoke(json: joke)
                        completion(randomJoke)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
// MARK: - Standart get request through URLSessions
    
func fetchJoke (completion: @escaping JokeResponseCompletion) {
    guard let url = URL(string: randomURL) else {return}
    let task = URLSession.shared.dataTask(with: url) { data, responce, error in
        guard error == nil else {return}
        guard let data = data else {return}
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let json = json as? [String: Any] else {return}
            let joke = self.parseJoke(json: json)
            DispatchQueue.main.async {
                completion(joke)
            }
        } catch {
            debugPrint(error.localizedDescription)
            return
        }
    }
    task.resume()
}

// MARK: - JSON parsin method
    
private func parseJoke(json: [String: Any]) -> Joke {
    let category = json["category"] as? String ?? ""
    let jokeQuestion = json["setup"] as? String ?? ""
    let jokeAnswer = json["delivery"] as? String ?? ""
    
    let joke = Joke(category: category, jokeQuestion: jokeQuestion, jokeAnswer: jokeAnswer)
    return joke
    }
}
