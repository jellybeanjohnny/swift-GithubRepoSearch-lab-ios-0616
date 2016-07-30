//
//  ReposDataStore.swift
//  swift-githubRepoSearch-lab
//
//  Created by Haaris Muneer on 7/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposDataStore {
  
  static let sharedInstance = ReposDataStore()
  private init() {}
  
  var repositories:[GithubRepository] = []
  
  
  func getRepositoriesWithCompletion(completion: () -> () ) {
    GithubAPIClient.getRepositoriesWithCompletion { (json) in
      self.repositories.removeAll()
      guard let repoArray = json.array else { return }
      for item in repoArray {
        guard let dictionary = item.dictionary else { return }
        let repository = GithubRepository(dictionary: dictionary)
        self.repositories.append(repository)
      }
      completion()
    }
  }
  
  func toggleStarStatusForRepository(repository: String, completion: (Bool)->() ) {
    GithubAPIClient.checkIfRepositoryIsStarred(repository) { (isStarred) in
      if isStarred {
        GithubAPIClient.unstarRepository(repository, completion: {
          completion(false)
        })
      }
      else {
        GithubAPIClient.starRepository(repository, completion: {
          completion(true)
        })
      }
    }
  }
  
  func searchForRepositories(withName repoName: String, completion: () -> () ) {
    GithubAPIClient.searchForRepositories(withName: repoName) { (json) in
      self.repositories.removeAll()
      guard let repoArray = json["items"].array else { return }
      for item in repoArray {
        guard let dictionary = item.dictionary else { return }
        let repository = GithubRepository(dictionary: dictionary)
        self.repositories.append(repository)
        print(self.repositories)
      }
      completion()
    }
  }


  
}
