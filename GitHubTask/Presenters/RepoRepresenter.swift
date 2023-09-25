//
//  RepoRepresenter.swift
//  GitHubTask
//
//  Created by Asmaa Badreldin on 9/25/23.
//

import Foundation

class RepoRepresenter: NSObject {
    weak var repoView: RepoView?
    let router = Router<RepoApi>()

    func attachView(repoView: RepoView) {
        self.repoView = repoView
    }

    func detachView() {
        repoView = nil
    }
    
    func getRepos(completion: @escaping (_ repos: [RepoApiResponse]?,_ error: String?)->()){
        
        repoView?.showLoadingIndicator()
        
        router.request(.repository) { data, response, error in
            
            if error != nil {
                self.repoView?.hideLoadingIndicator()
                self.repoView?.onError(message: NetworkResponse.failed.rawValue)
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = NetworkResponseClass.handler(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        self.repoView?.hideLoadingIndicator()
                        self.repoView?.onError(message:  NetworkResponse.noData.rawValue)
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        self.repoView?.hideLoadingIndicator()
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode([RepoApiResponse].self, from: responseData)
                        self.repoView?.onSucess(repos: apiResponse)
                        completion(apiResponse, nil)
                    }catch {
                        self.repoView?.hideLoadingIndicator()
                        print(error)
                        self.repoView?.onError(message: NetworkResponse.unableToDecode.rawValue)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    self.repoView?.hideLoadingIndicator()
                    self.repoView?.onError(message: NetworkResponse.failed.rawValue)
                    completion(nil, networkFailureError)
                }
            }
        }
    }
}
