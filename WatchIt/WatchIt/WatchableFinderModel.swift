import Foundation
import Moya
import Mapper
import Moya_ModelMapper
import RxOptional
import RxSwift

struct WatchableFinderModel {
    
    let provider: MoyaProvider<OMDB>
    let watchableName: Observable<String>
    
    func findWatchable(title: String) -> Observable<[Watchable]?> {
        
        return provider.request(OMDB.Movie(title: title), completion: { (result) in
            print("result: \(result)")
        }) as! Observable<[Watchable]?>
        
    }
    
    func observerWatchable() -> Observable<[Watchable]> {
        return watchableName
            .observeOn(MainScheduler.instance)
            .flatMapLatest({ (name) -> Observable<[Watchable]?> in
                print("Title: \(name)")
                return self.findWatchable(title: name)
            })
            .flatMapLatest{ watchable -> Observable<[Watchable]?> in
                guard let watchable = watchable else {return Observable.just(nil)}
                print("Watchable: \(watchable)")
                return self.findWatchable(title: watchable[0].title)
        }.replaceNilWith([])
    }

    
//    func searchForWatchable(_ title: String) {
//        _ = provider.request(.Movie(title: title)) { result in
//            switch result {
//            case let .success(response):
//                do {
//                    if let json = try response.mapJSON() as? NSArray {
//                        // Presumably, you'd parse the JSON into a model object. This is just a demo, so we'll keep it as-is.
//                        mapArray(OMDB.self)
//                    } else {
//                        print("gowno 29")
//                    }
//                } catch {
//                    print("gowno 32")
//                }
//                print("success")
//            case let .failure(error):
//                guard let error = error as? CustomStringConvertible else {
//                    break
//                }
//                print("gowno 39")
//            }
//        }
//    }
    
}
