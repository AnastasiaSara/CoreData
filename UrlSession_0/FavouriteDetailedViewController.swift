//
//  FavouriteDetailedViewController.swift
//  UrlSession_0
//
//  Created by Настя Сарамуд on 14.03.2024.
//

import UIKit

class FavouriteDetailedViewController: UIViewController {
    
    var articleFavourite: SelectedArticle?
      
    @IBOutlet var detailedImageFavourite: UIImageView!
    @IBOutlet var titleArticleFavourite: UILabel!
    @IBOutlet var abstractArticleFavourite: UILabel!
    @IBOutlet var sourceArticleFavourite: UILabel!
    @IBOutlet var publishedDateArticleFavourite: UILabel!
    @IBOutlet var updatedArticleFavourite: UILabel!
    @IBOutlet var byLineArticleFavourite: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleArticleFavourite.numberOfLines = 3
        abstractArticleFavourite.numberOfLines = 10
        
        publishedDateArticleFavourite.sizeToFit()
        
        titleArticleFavourite.text = articleFavourite?.title
        abstractArticleFavourite.text = articleFavourite?.abstract
        sourceArticleFavourite.text = articleFavourite?.source
        publishedDateArticleFavourite.text = "Date of publication: \(articleFavourite?.publishedDate ?? "")"
        updatedArticleFavourite.text = "Date of change: \(String(describing: articleFavourite?.updatedDate))"
        byLineArticleFavourite.text = articleFavourite?.byline
        DispatchQueue.global().async {
            
            guard let urlImage = self.articleFavourite?.url,
                  let imageData = try? Data(contentsOf: urlImage) else { return }
            
            DispatchQueue.main.async {
                self.detailedImageFavourite.image = UIImage(data: imageData)
            }
        }
    }
}
