//
//  NetworkAPI.swift
//  MovieViewer
//
//  Created by my mac on 9/26/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import Foundation



class NetworkAPI{

    static let sharedInstance = NetworkAPI()
    
    
    let standardWidthImageBaseUrl = "https://image.tmdb.org/t/p/w500"
    let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    let topRatedPath = "/top_rated"
    let nowPlayingPath = "/now_playing"
    let moviesBaseUrl = "https://api.themoviedb.org/3/movie"
    

    
    
    private init(){
    
    }
    
    func getMovies(endpoint: String, successHandler: @escaping ([NSDictionary]) -> (), errorHandler: @escaping(Error) -> ()){
        print("[SENDREQUEST]")
       
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(self.apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        // Configure session so that completion handler is executed on main UI thread
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    let movies = dataDictionary["results"] as! [NSDictionary]
                    successHandler(movies)
                    
                }
            }else if let error = error{
                errorHandler(error)
                
            }
        }
        
        
        task.resume()
    
    }
    
    
    
    func getMovie(by id: String, successHandler: @escaping (NSDictionary) -> (), errorHandler: @escaping(Error) -> ()){
        guard let url = URL(string: "\(self.moviesBaseUrl)/\(id)?api_key=\(self.apiKey)") else {
            errorHandler(NSError(domain: "Could use url.", code: 404, userInfo: nil))
            return;
        }
        
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    let movie = dataDictionary as! NSDictionary
                    successHandler(movie)
                    
                }
            }else if let error = error{
                errorHandler(error)
                
            }
        }
        
        
        task.resume()
        
    }


}
