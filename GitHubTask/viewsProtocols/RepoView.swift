//
//  RepoView.swift
//  GitHubTask
//
//  Created by Asmaa Badreldin on 9/25/23.
//

protocol RepoView: AnyObject {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func onSucess(repos: [RepoApiResponse])
    func onError(message: String)
}
