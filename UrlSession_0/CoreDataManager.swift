//
//  CoreDataManager.swift
//  UrlSession_0
//
//  Created by Настя Сарамуд on 15.03.2024.
//


import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    // MARK: - Core Data stack
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private init() {}
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveSelectedArticle(_ article: Article, url: URL?) {
        let selectedArticle = SelectedArticle(context: viewContext)
        selectedArticle.title = article.title
        selectedArticle.abstract = article.abstract
        selectedArticle.source = article.source
        selectedArticle.publishedDate = article.publishedDate
        selectedArticle.updatedDate = article.updatedDate
        selectedArticle.byline = article.byline
        selectedArticle.section = article.section
        selectedArticle.url = url
        
        saveContext()
    }
    
    func fetchSelectedArticles() -> [SelectedArticle] {
        let fetchRequest: NSFetchRequest<SelectedArticle> = SelectedArticle.fetchRequest()
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            
            return result
        } catch {
            print("Error fetching selected articles: \(error)")
            return []
        }
    }
}
