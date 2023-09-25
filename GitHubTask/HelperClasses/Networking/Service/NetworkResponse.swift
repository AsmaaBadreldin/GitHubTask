//
//  NetworkResponse.swift
//  GitHubTask
//
//  Created by Asmaa Badreldin on 9/25/23.
//

import Foundation

class NetworkResponseClass {
    
    static  func handler(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
}
