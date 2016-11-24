import Foundation
import Moya
import Mapper
import Moya_ModelMapper
import RxOptional
import RxSwift

struct WatchableFinderModel {
    
    let provider: RxMoyaProvider<OMDB>
    let watchableName: Observable<String>

    func findWatchable() -> Observable<[Production]> {
        
        return watchableName
            .observeOn(MainScheduler.instance)
            .flatMapLatest({ (title) -> Observable<[Production]> in
                print("title: \(title)")
                return self
                    .findProductionInOMDB(title: "Matrix")
                    .debug()
                    .flatMapLatest({ (production) -> Observable<[Production]?> in
                        guard let prod = production else {return Observable.just(nil)}
                        return Observable.just([prod])
                    })
                    .replaceNilWith([])

            })


        
    }
    
    private func findProductionInOMDB(title:String) -> Observable<Production?> {
        return self.provider.request(.productions(title: title))
            .debug()
            .mapObjectOptional(type: Production.self)
        
    }
    
    
}
