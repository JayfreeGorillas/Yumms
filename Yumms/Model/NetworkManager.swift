//
//  NetworkManager.swift
//  Yumms
//
//  Created by Josfry Barillas on 4/28/23.
//

import Foundation

struct DessertAPI {
    static var dessertsURL = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")
    static var dessertDetailsURL = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=")
    
    static func desserts(fromJSON data: Data) -> Result<[Dessert], Error> {
        return Result {
            return try JSONDecoder().decode(Meals.self, from: data).meals
        }
    }
    
  
    
    static func dessertDetails(fromJSON data: Data) -> Result<DessertModel, Error> {
        return Result {
            let dessertDetails = try JSONDecoder().decode(DessertDetail.self, from: data).meals[0]
            
            
            let ingredients = [
                Ingredients(ingredient: dessertDetails.strIngredient1 ?? "", measureMent: dessertDetails.strMeasure1 ?? ""),
                Ingredients(ingredient: dessertDetails.strIngredient2 ?? "", measureMent: dessertDetails.strMeasure2 ?? ""),
                Ingredients(ingredient: dessertDetails.strIngredient3 ?? "", measureMent: dessertDetails.strMeasure3 ?? ""),
                Ingredients(ingredient: dessertDetails.strIngredient4 ?? "", measureMent: dessertDetails.strMeasure4 ?? ""),
                Ingredients(ingredient: dessertDetails.strIngredient5 ?? "", measureMent: dessertDetails.strMeasure5 ?? ""),
                Ingredients(ingredient: dessertDetails.strIngredient6 ?? "", measureMent: dessertDetails.strMeasure6 ?? ""),
                Ingredients(ingredient: dessertDetails.strIngredient7 ?? "", measureMent: dessertDetails.strMeasure7 ?? ""),
                Ingredients(ingredient: dessertDetails.strIngredient8 ?? "", measureMent: dessertDetails.strMeasure8 ?? ""),
                Ingredients(ingredient: dessertDetails.strIngredient9 ?? "", measureMent: dessertDetails.strMeasure9 ?? ""),
                Ingredients(ingredient: dessertDetails.strIngredient10 ?? "", measureMent: dessertDetails.strMeasure10 ?? ""),
                Ingredients(ingredient: dessertDetails.strIngredient11 ?? "", measureMent: dessertDetails.strMeasure11 ?? ""),
                Ingredients(ingredient: dessertDetails.strIngredient12 ?? "", measureMent: dessertDetails.strMeasure12 ?? ""),
                Ingredients(ingredient: dessertDetails.strIngredient13 ?? "", measureMent: dessertDetails.strMeasure13 ?? ""),
                Ingredients(ingredient: dessertDetails.strIngredient14 ?? "", measureMent: dessertDetails.strMeasure14 ?? ""),
                Ingredients(ingredient: dessertDetails.strIngredient15 ?? "", measureMent: dessertDetails.strMeasure15 ?? ""),
                Ingredients(ingredient: dessertDetails.strIngredient16 ?? "", measureMent: dessertDetails.strMeasure16 ?? ""),
                Ingredients(ingredient: dessertDetails.strIngredient17 ?? "", measureMent: dessertDetails.strMeasure17 ?? ""),
                Ingredients(ingredient: dessertDetails.strIngredient18 ?? "", measureMent: dessertDetails.strMeasure18 ?? ""),
                Ingredients(ingredient: dessertDetails.strIngredient19 ?? "", measureMent: dessertDetails.strMeasure19 ?? ""),
                Ingredients(ingredient: dessertDetails.strIngredient20 ?? "", measureMent: dessertDetails.strMeasure20 ?? "")
            ]
            
            let dessert = DessertModel(name: dessertDetails.strMeal, area: dessertDetails.strArea, instructions: dessertDetails.strInstructions, ingredients: ingredients)
            return dessert
        }
    }
}

class NetworkManager {
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: .default)
    }()
    
    // DessertList for DessertVC
    func fetchDesserts(completion: @escaping (Result<[Dessert], Error>) -> Void) {
        let url = DessertAPI.dessertsURL
        let request = URLRequest(url: url!)
        let task = session.dataTask(with: request) { data, response, error in
            let result = self.processDessertRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    func processDessertRequest(data: Data?, error: Error?) -> Result<[Dessert], Error> {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return DessertAPI.desserts(fromJSON: jsonData)
    }
    
    // Dessert Details for Details VC
    
    func fetchDessertDetails(id: String, completion: @escaping (Result<DessertModel, Error>) -> Void) {
        let urlString = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)")
        let url = urlString
        let request = URLRequest(url:url!)
        let task = session.dataTask(with: request) { data, response, error in
    
            let result = self.processDessertDetailsRequest(data: data, error: error)
        
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    func processDessertDetailsRequest(data: Data?, error: Error?) -> Result<DessertModel, Error> {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return DessertAPI.dessertDetails(fromJSON: jsonData)
    }
}


