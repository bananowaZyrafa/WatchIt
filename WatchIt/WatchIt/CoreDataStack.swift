import CoreData

class CoreDataStack {
    
    private init() {
        
    }
    
    @available(iOS 10.0, *)
    class func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    @available(iOS 10.0, *)
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WatchIt")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo))")
            }
        })
        return container
    }()
    
    @available(iOS 10.0, *)
    class func saveContext() {
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    
    
    
}
