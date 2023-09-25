//
//  UIImageViewExtention.swift
//  GitHubTask
//
//  Created by Asmaa Badreldin on 9/25/23.
//

import Foundation
import UIKit

extension UIImageView {
        func setImageFromURL(url: URL,  withPlaceholder placeholder: UIImage? = nil) {
            DispatchQueue.global().async { [weak self] in
                guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        self?.image = UIImage(named: "PlaceHolderImg")
                    }
                    return
                }
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
}
