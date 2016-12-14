import Foundation
import CoreData


extension WatchableEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WatchableEntity> {
        return NSFetchRequest<WatchableEntity>(entityName: "WatchableEntity");
    }

    @NSManaged public var title: String?
    @NSManaged public var runtime: String?
    @NSManaged public var posterURL: String?
    @NSManaged public var imdbRating: String?
    @NSManaged public var isSeen: Bool
    @NSManaged public var usersRating: String?

}
