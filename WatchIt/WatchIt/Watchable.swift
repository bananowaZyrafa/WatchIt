import Mapper

protocol Watchable: Mappable {
    var title: String {get}
    var runtime: String {get}
    var posterURL : String {get}
    var imdbRating: String {get}
}

struct Production: Watchable {
    
    let title: String
    let runtime: String
    let posterURL: String
    let imdbRating: String
    
    init(map: Mapper) throws {
        try title = map.from("Title")
        try runtime = map.from("Runtime")
        try posterURL = map.from("Poster")
        try imdbRating = map.from("imdbRating")
    }
    
}


