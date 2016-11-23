import Foundation
import Moya
import Mapper
import Moya_ModelMapper
import RxOptional
import RxSwift

struct MovieFinderModel {
    let provider: MoyaProvider<OMDB>
    let repositoryName: Observable<String>
    
    internal func findWatchables(movieOrSeries: Watchable) -> Observable<[Watchable]?> {
    
//        return self.provider.request(OMDB.Movie(title: movieOrSeries.title)).debug().mapArrayOptional(Watchable.self)
//        return self.provider.request(.Movie(title: movieOrSeries.title)).debug().mapArrayOptional(Watchable.self)
        
        
    }
    
}
