//
//  Repository.swift
//  GitHubTask
//
//  Created by Asmaa Badreldin on 9/24/23.
//


import Foundation

struct RepoApiResponse {
    let id: Int
    let name: String
    let status: Bool
    let owner: Owner
}

extension RepoApiResponse: Decodable {
    
    private enum RepoApiResponseCodingKeys: String, CodingKey {
        case id
        case name
        case status = "private"
        case owner
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RepoApiResponseCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        status = try container.decode(Bool.self, forKey: .status)
        owner = try container.decode(Owner.self, forKey: .owner)
    }
}

struct Owner {
    let id: Int
    let login: String
    let avatar_url:String?
    let type:String
}

extension Owner: Decodable {
    
    enum OwnerCodingKeys: String, CodingKey {
        case id
        case login
        case avatar_url
        case type
    }
    
    init(from decoder: Decoder) throws {
        let ownerContainer = try decoder.container(keyedBy: OwnerCodingKeys.self)
        
        id = try ownerContainer.decode(Int.self, forKey: .id)
        login = try ownerContainer.decode(String.self, forKey: .login)
        avatar_url = try ownerContainer.decode(String.self, forKey: .avatar_url)
        type = try ownerContainer.decode(String.self, forKey: .type)
    }
}
