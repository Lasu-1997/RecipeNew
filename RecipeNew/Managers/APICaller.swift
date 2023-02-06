//
//  APICaller.swift
//  RecipeNew
//
//  Created by Shehan Udaraka on 1/25/23.
//  Copyright © 2023 Shehan Udaraka. All rights reserved.
//

import Foundation

struct Constants{
    static let YoutubeAPI_KEY = "AIzaSyDdtsYYgoFsZpsUvCgX3lmfLoutnvhYyBw"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error{
    case failedTogetData
}

class APICaller{
    static let shared = APICaller()
    
    func getTrendingFood(completion: @escaping (Result<[Food], Error>) -> Void){
        
        guard let url = URL(string: "http://recipeapi.somee.com/api/foods") else{return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _,error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let results = try  JSONDecoder().decode(TrendingFoodResponse.self, from: data)
                completion(.success(results.data))
                
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
        
    }
    
 
    
    
    func getRecentFoods(completion: @escaping (Result<[Food], Error>) -> Void){
        
        guard let url = URL(string: "http://recipeapi.somee.com/api/foods") else {return}
        
        
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let results = try JSONDecoder().decode(TrendingFoodResponse.self, from: data)
                completion(.success(results.data))
            }
            catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    
    func getPopular(completion: @escaping (Result<[Food], Error>) -> Void){
        guard let url = URL(string: "http://recipeapi.somee.com/api/foods") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let results = try JSONDecoder().decode(TrendingFoodResponse.self, from: data)
                completion(.success(results.data))
            }
            catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    
    func getTopRated(completion: @escaping (Result<[Food], Error>) -> Void){
        guard let url = URL(string: "http://recipeapi.somee.com/api/foods") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let results = try JSONDecoder().decode(TrendingFoodResponse.self, from: data)
                completion(.success(results.data))
            }
            catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    
  
    
    func getDiscoverFoods(completion: @escaping (Result<[Food], Error>) -> Void) {
              guard let url = URL(string: "http://recipeapi.somee.com/api/foods") else {return }
              let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                  guard let data = data, error == nil else {
                      return
                  }
                  
                  do {
                      let results = try JSONDecoder().decode(TrendingFoodResponse.self, from: data)
                      completion(.success(results.data))

                  } catch {
                      completion(.failure(APIError.failedTogetData))
                  }

              }
              task.resume()
          }
    
 
    
    func search(with query: String, completion: @escaping (Result<[Food], Error>) -> Void) {
         
         guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
         guard let url = URL(string: "http://recipeapi.somee.com/api/foods") else {
             return
         }
         
         let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
             guard let data = data, error == nil else {
                 return
             }
             
             do {
                 let results = try JSONDecoder().decode(TrendingFoodResponse.self, from: data)
                 completion(.success(results.data))

             } catch {
                 completion(.failure(APIError.failedTogetData))
             }

         }
         task.resume()
     }

    
    func getFood(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
           guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
           guard let url = URL(string: "http://recipeapi.somee.com/api/foods/{id}") else {return}
           let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
               guard let data = data, error == nil else {
                   return
               }
               
               do {
                   let data = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                   
                   completion(.success(data.items[0]))
                   

               } catch {
                   completion(.failure(error))
                   print(error.localizedDescription)
               }

           }
           task.resume()
       }
}



