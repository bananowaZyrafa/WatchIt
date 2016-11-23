import Foundation
import Moya

private extension String {
    var URLEscapedString: String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
}


enum OMDB {
    case Movie(title: String)
    case Series(title: String)
}

extension OMDB: TargetType {
    
    var baseURL: NSURL {return NSURL(string: "http://www.omdbapi.com/")! }
    var path: String {
        switch self {
        case .Movie(let title):
            return "?t=\(title.URLEscapedString)"
            
        case .Series(let title):
            return "?t=\(title.URLEscapedString)"
        }
    }
    var method: Moya.Method {
        return .GET
    }
    
    var parameters: [String : AnyObject]? {
        return nil
    }
    
    
    var sampleData: NSData {
        switch self {
        case .Movie(let name):
            return "{\"Title\": \"\(name)\", \"Runtime\": \"136 min\", \"Poster\" : \"https://images-na.ssl-images-amazon.com/images/M/MV5BMDMyMmQ5YzgtYWMxOC00OTU0LWIwZjEtZWUwYTY5MjVkZjhhXkEyXkFqcGdeQXVyNDYyMDk5MTU@._V1_SX300.jpg\", \"imdbRating\" : \"8.7\"}".dataUsingEncoding(NSUTF8StringEncoding)!
        case .Series(let name):
            return "{\"Title\": \"\(name)\", \"Runtime\": 136 min, \"Poster\" : \"https://images-na.ssl-images-amazon.com/images/M/MV5BMDMyMmQ5YzgtYWMxOC00OTU0LWIwZjEtZWUwYTY5MjVkZjhhXkEyXkFqcGdeQXVyNDYyMDk5MTU@._V1_SX300.jpg\", \"imdbRating\" : \"8.7\"}".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
    
    var multipartBody: [MultipartFormData]? { return nil }
    
}
