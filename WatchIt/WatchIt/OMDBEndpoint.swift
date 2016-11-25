import Foundation
import Moya

private extension String {
    var URLEscapedString: String {
        return self.replacingOccurrences(of: " ", with: "+")
    }
}


enum OMDB {
    case productions(title:String)
}

extension OMDB: TargetType {
 
    var baseURL: URL {return URL(string: "http://www.omdbapi.com")! }
    var path: String {
            return ""
        }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .productions(let title):
            return ["t": "\(title.URLEscapedString)"]
        }
        
    }
    
    public var task: Task {
        return .request
    }
    
    var sampleData: Data {
        switch self {
        case .productions(let prodTitle):
            return "{{\"Title\": \"\(prodTitle)\", \"Runtime\": \"136 min\", \"Poster\" : \"https://images-na.ssl-images-amazon.com/images/M/MV5BMDMyMmQ5YzgtYWMxOC00OTU0LWIwZjEtZWUwYTY5MjVkZjhhXkEyXkFqcGdeQXVyNDYyMDk5MTU@._V1_SX300.jpg\", \"imdbRating\" : \"8.7\"}}".data(using: .utf8)!

        }
    }
    
   
}
