//
//  ViewController.swift
//  GitHubTask
//
//  Created by Asmaa Badreldin on 9/24/23.
//

import UIKit

class RepoVC: UIViewController{
    
    // MARK: - properties

    private let repoPresenter = RepoRepresenter()
    var repos = [RepoApiResponse]()

    private lazy var repoDetailsVC: RepoDetailsVC = {
        var viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RepoDetailsVC") as! RepoDetailsVC
        return viewController
    }()

    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)

    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupIndicator()
        
        repoPresenter.attachView(repoView: self)
        
        repoPresenter.getRepos { repos, error in
            // we can use here the completion response here to update the UI
            //which is repos or error but i already used protocol handling instead
            // Another method to handle api response in the VC
        }
    }
    
    // MARK: - Setup UI

    private func setupUI() {
        tableView.register(UINib(nibName: RepoCell.cellId, bundle: nil), forCellReuseIdentifier: RepoCell.cellId)
    }
    
    private func setupIndicator(){
        indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator.center = view.center
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
        indicator.isHidden = true
    }
}

extension RepoVC : UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return repos.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.cellId, for: indexPath) as? RepoCell {
                cell.setup(repo: repos[indexPath.row])
            }
            return UITableViewCell()
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            repoDetailsVC.repoSelected = repos[indexPath.row]
            let selectedcell = tableView.cellForRow(at: indexPath)
            selectedcell?.backgroundColor = .clear
            self.present(repoDetailsVC, animated: true)
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
}

extension RepoVC: RepoView{
    func showLoadingIndicator() {
        DispatchQueue.main.async {
            self.indicator.isHidden = false
            self.indicator.startAnimating()
        }
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.indicator.isHidden = true
            self.indicator.stopAnimating()
        }
    }
    
    func onError(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func onSucess(repos: [RepoApiResponse]) {
        self.repos = repos
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        print(repos)
    }
}

