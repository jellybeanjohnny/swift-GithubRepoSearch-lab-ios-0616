//
//  GithubRepository.swift
//  swift-githubRepoSearch-lab
//
//  Created by Haaris Muneer on 7/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import SwiftyJSON

class GithubRepository {
  
  var fullName: String
  var htmlURL: NSURL
  var repositoryID: String
  
  init(dictionary: [String : JSON]) {
    
    guard let
      name = dictionary["full_name"]?.string,
      valueAsString = dictionary["html_url"]?.string,
      repoId = dictionary["id"]?.intValue else {
        fatalError("Could not create repository object from supplied dictionary") }
    
    fullName = name
    repositoryID = "\(repoId)"
    
    guard let url = NSURL(string: valueAsString) else { fatalError("Invalid URL") }
    htmlURL = url
    
  }
  
}
