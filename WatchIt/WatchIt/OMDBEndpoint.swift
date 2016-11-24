import Foundation
import Moya

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}


enum OMDB {
    case productions(title:String)
}

extension OMDB: TargetType {
 
    var baseURL: URL {return URL(string: "http://www.omdbapi.com/?t=Matrix")! }
    var path: String {
        switch self {
        case .productions(let prodTitle):
            return ""
        
        }
    }
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    public var task: Task {
        return .request
    }
    
    var sampleData: Data {
        switch self {
        case .productions(_):
            return "{{\"Title\": \"Matrix\", \"Runtime\": \"136 min\", \"Poster\" : \"https://images-na.ssl-images-amazon.com/images/M/MV5BMDMyMmQ5YzgtYWMxOC00OTU0LWIwZjEtZWUwYTY5MjVkZjhhXkEyXkFqcGdeQXVyNDYyMDk5MTU@._V1_SX300.jpg\", \"imdbRating\" : \"8.7\"}}".data(using: .utf8)!

        }
    }
    
   
}
