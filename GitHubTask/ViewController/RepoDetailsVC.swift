//
//  RepoDetails.swift
//  GitHubTask
//
//  Created by Asmaa Badreldin on 9/25/23.
//

import UIKit

class RepoDetailsVC: UIViewController{
    
    // MARK: - properties
    
    var repoSelected: RepoApiResponse?

    // MARK: - Outlets

    @IBOutlet weak var repoImage: UIImageView!
    @IBOutlet weak var repoNameLbl: UILabel!
    @IBOutlet weak var repoTypeLbl: UILabel!
    @IBOutlet weak var repoOwnerLbl: UILabel!
    @IBOutlet weak var ownerTypeLbl: UILabel!

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Setup UI

    private func setupUI() {
        if let repo = repoSelected{
            self.repoNameLbl.text = repo.name
            if repo.status{
                repoTypeLbl.text = "private"
            }else{
                repoTypeLbl.text = "public"
            }
            repoOwnerLbl.text = repoSelected?.owner.login
            ownerTypeLbl.text = repoSelected?.owner.type
            
            guard let avatarUrl = repo.owner.avatar_url else{ return }
            guard let url = URL(string: avatarUrl) else { return }
            repoImage?.setImageFromURL(url: url)
        }
    }
}
