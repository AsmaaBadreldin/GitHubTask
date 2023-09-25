//
//  RepoApi.swift
//  GitHubTask
//
//  Created by Asmaa Badreldin on 9/24/23.
//

import Foundation

public enum RepoApi {
    case repository
}

extension RepoApi: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.github.com/") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .repository:
            return "repositories"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .repository:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


