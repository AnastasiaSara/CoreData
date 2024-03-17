//
//  DetailedInformationViewController.swift
//  UrlSession_0
//
//  Created by Настя Сарамуд on 10.03.2024.
//

import UIKit
import CoreData

class DetailedInformationViewController: UIViewController {
    
    var article: Article?
    
    @IBOutlet var detailedImage: UIImageView!
    @IBOutlet var titleArticle: UILabel!
    @IBOutlet var abstractArticle: UILabel!
    @IBOutlet var sourceArticle: UILabel!
    @IBOutlet var publishedDateArticle: UILabel!
    @IBOutlet var updatedArticle: UILabel!
    @IBOutlet var byLineArticle: UILabel!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    private lazy var dataManager = CoreDataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataManager.saveContext()
        
        titleArticle.numberOfLines = 3
        abstractArticle.numberOfLines = 10
        
        publishedDateArticle.sizeToFit()
        
        titleArticle.text = article?.title
        abstractArticle.text = article?.abstract
        sourceArticle.text = article?.source
        publishedDateArticle.text = "Date of publication: \(article?.publishedDate ?? "")"
        updatedArticle.text = "Date of change: \(article?.updatedDate ?? "no changes")"
        byLineArticle.text = article?.byline
        
        DispatchQueue.global().async {
            guard let urlImage = self.article?.media?.first?.mediaMetadata?.last?.url else { return }
            guard let imageData = try? Data(contentsOf: urlImage) else { return }
            
            DispatchQueue.main.async {
                self.detailedImage.image = UIImage(data: imageData)
            }
        }
    }
    
    @IBAction func pressButtonAction(_ sender: Any) {
        guard let article else { return }
        
        dataManager.saveSelectedArticle(article, url: article.media?.first?.mediaMetadata?.first?.url)
        
        saveButton.isEnabled = false
    }
}
