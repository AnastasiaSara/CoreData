//
//  SelectedArticle+CoreDataProperties.swift
//  UrlSession_0
//
//  Created by Настя Сарамуд on 15.03.2024.
//
//

import CoreData
import UIKit


extension SelectedArticle: Identifiable {

    @NSManaged public var title: String?
    @NSManaged public var abstract: String?
    @NSManaged public var source: String?
    @NSManaged public var publishedDate: String?
    @NSManaged public var updatedDate: String?
    @NSManaged public var byline: String?
    @NSManaged public var section: String?
    @NSManaged public var url: URL?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SelectedArticle> {
        return NSFetchRequest<SelectedArticle>(entityName: "SelectedArticle")
    }
}
