//
//  RepoCell.swift
//  GitHubTask
//
//  Created by Asmaa Badreldin on 9/25/23.
//

import UIKit
import Foundation

class RepoCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var repoImage: UIImageView!
    @IBOutlet weak var repoNameLbl: UILabel!
    @IBOutlet weak var ownerNameLbl: UILabel!
    
    @IBOutlet weak var dateLbl: UILabel!
    // MARK: - properties
    static let cellId = "RepoCell"
    
    let testDate1: String = "2022/6/01" // befor six month
    let testDate2: String = "2023/8/01" // after six month

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(repo: RepoApiResponse){
        repoNameLbl?.text = repo.name
        ownerNameLbl?.text = repo.owner.login
        
        let dateStr = setDate()
        dateLbl.text = dateStr
        
        guard let avatarUrl = repo.owner.avatar_url else{ return }
        guard let url = URL(string: avatarUrl) else { return }
        repoImage?.setImageFromURL(url: url)
    }
    
    func setDate() -> String{
        if let dateAfterSixMonth = Calendar.current.date(byAdding: .month, value: -6, to: Date()){
            let dateStr = DateHelper.sharedDateFormatter.string(from: dateAfterSixMonth)
            let showedDateFormatted = DateHelper.checkDate(givenDateStr: testDate1, comparedToDateStr: dateStr)
          //  let showedDateFormatted = DateHelper.checkDate(givenDateStr: testDate2 , comparedToDateStr: dateStr)
            return showedDateFormatted ?? ""
        }
        return ""
    }
}
