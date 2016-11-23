import Mapper

struct Watchable: Mappable {
    
    let title: String
    let runtime: String
    let poster: NSURL
    let imdbRating: Double
    //let genre: String
    
    init(map: Mapper) throws {
        try title = map.from("Title")
        try runtime = map.from("Runtime")
        try poster = map.from("Poster")
        try imdbRating = map.from("imdbRating")
    }
    
    
}
