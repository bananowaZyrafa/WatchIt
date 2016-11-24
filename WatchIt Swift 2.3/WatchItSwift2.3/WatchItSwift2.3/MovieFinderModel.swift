import Foundation
import Moya
import Mapper
import Moya_ModelMapper
import RxOptional
import RxSwift

struct MovieFinderModel {
    let provider: MoyaProvider<OMDB>
    let repositoryName: Observable<String>
    
    internal func findWatchables(movieOrSeries: Watchable)  {

    }
    
}
