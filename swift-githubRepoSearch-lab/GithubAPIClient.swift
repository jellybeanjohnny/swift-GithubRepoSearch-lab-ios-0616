//
//  GithubAPIClient.swift
//  swift-githubRepoSearch-lab
//
//  Created by Haaris Muneer on 7/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GithubAPIClient {
  
  static let githubAPIURL = "https://api.github.com"
  
  class func getRepositoriesWithCompletion(completion: (JSON) -> ()) {
    let parameters = [
      "client_id" : Secrets.githubClientID,
      "client_secret" : Secrets.githubClientSecret
    ]
    
    let urlString = "\(GithubAPIClient.githubAPIURL)/repositories"
    Alamofire.request(.GET, urlString, parameters: parameters).responseJSON { (response) in
      if let value = response.result.value {
        let json = JSON(value)
        completion(json)
      }
    }
  }
  
  class func checkIfRepositoryIsStarred(fullName: String, completion: Bool -> Void) {
    let urlString = "\(githubAPIURL)/user/starred/\(fullName)"
    let headers = [
      "Authorization" : "token \(Secrets.githubAccessToken)"
    ]
    
    Alamofire.request(.GET, urlString, parameters: nil, encoding: ParameterEncoding.JSON, headers: headers).responseJSON { (response) in
      print(response.response?.statusCode)
      
      let isStarred = response.response?.statusCode == 204
      
      completion(isStarred)
    }
  }
  
  class func starRepository(fullName: String, completion: ()->() ) {
    let urlString = "\(githubAPIURL)/user/starred/\(fullName)"
    let headers = [
      "Authorization" : "token \(Secrets.githubAccessToken)",
      "Content-Length": "0"
    ]
    
    Alamofire.request(.PUT, urlString, parameters: nil, encoding: ParameterEncoding.JSON, headers: headers).responseJSON { (response) in
      if response.response?.statusCode == 204 { print("Successfully starred \(fullName)")
        completion()
      }
    }
  }
  
  class func unstarRepository(fullName: String, completion: ()->() ) {
    let urlString = "\(githubAPIURL)/user/starred/\(fullName)"
    let headers = [
      "Authorization" : "token \(Secrets.githubAccessToken)",
      ]
    Alamofire.request(.DELETE, urlString, parameters: nil, encoding: ParameterEncoding.JSON, headers: headers).responseJSON { (response) in
      if response.response?.statusCode == 204 { print("Successfully unstarred \(fullName)")
        completion()
      }
    }
  }
  
  class func searchForRepositories(withName repoName: String, completion: (JSON) -> () ) {
    let urlString = "\(githubAPIURL)/search/repositories"
    let parameters = [
      "q" : repoName,
      "client_id" : Secrets.githubClientID,
      "client_secret" : Secrets.githubClientSecret
    ]
    Alamofire.request(.GET, urlString, parameters: parameters).responseJSON { (response) in
      if let value = response.result.value {
        let json = JSON(value)
        print(json)
        completion(json)
      }
    }
  }
  
  
  
  
  
  
  
  
  
  
  
  
  


  
}
