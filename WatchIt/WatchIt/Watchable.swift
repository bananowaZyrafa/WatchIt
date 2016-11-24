import Mapper

protocol Watchable: Mappable {
    var mapTitle: String {get}
    var runtime: String {get}
    var poster: URL {get}
    var imdbRating: String {get}
}

struct Production: Watchable {
    
    let mapTitle: String
    let runtime: String
    let poster: URL
    let imdbRating: String
    
    init(map: Mapper) throws {
        try mapTitle = map.from("Title")
        try runtime = map.from("Runtime")
        try poster = map.from("Poster")
        try imdbRating = map.from("imdbRating")
    }
    
}


