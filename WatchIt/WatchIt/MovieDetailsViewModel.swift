import RxCocoa
import RxSwift

protocol MovieDetailsViewModelType {
    //input
    var addButtonDidTap: PublishSubject<Void> {get}
    var watchedButtonDidTap: PublishSubject<Void> {get}
    
    //output
    var addButtonEnabled: Driver<Bool> {get}
    var watchedButtonEnabled: Driver<Bool> {get}
    var posterImage: Variable<UIImage?> {get} //no idea what im doin
    var rateValue: Driver<String> {get}
    var presentRateMovieViewModel: Driver<RateMovieViewModelType> {get}
    
}


struct MovieDetailsViewModel: MovieDetailsViewModelType {
    
    // 2-Way Binding
    var addedToBase: Variable<Bool?>
    var seen: Variable<Bool?>
    var rateFromWatchable: Variable<String>
    
    //input
    let addButtonDidTap = PublishSubject<Void>()
    let watchedButtonDidTap = PublishSubject<Void>()
    
    //output
    let addButtonEnabled: Driver<Bool>
    let watchedButtonEnabled: Driver<Bool>
    let posterImage: Variable<UIImage?>
    let rateValue: Driver<String>
    let presentRateMovieViewModel: Driver<RateMovieViewModelType>
    
    //private
    private let disposeBag = DisposeBag()
    private let watchable: Watchable
    
    func loadImageFromWatchable(watchable:Watchable) -> UIImage? {
        
        return nil
        
    }
    
    init(watchable:Watchable) {
        
        self.watchable = watchable
        self.addedToBase = Variable(false)
        self.seen = Variable(false)
        self.rateFromWatchable = Variable("10.0")
        
        self.addButtonEnabled = self.addedToBase.asDriver()
            .map({ _ in //performing database search
                    return true
            })
        self.watchedButtonEnabled = self.seen.asDriver()
            .map({ _ in //performing database search
                return true
            })
        
        self.posterImage = Variable(self.loadImageFromWatchable(watchable: watchable)) //better if image was returned in completion block ofc
        self.rateValue = self.rateFromWatchable.asDriver().map({ rate in
            return rate
        })
        let presentRatingViewModel: Observable<RateMovieViewModelType> = self.watchedButtonDidTap.map{RateMovieViewModel()}
        self.presentRateMovieViewModel = presentRatingViewModel.asDriver(onErrorDriveWith: .empty())
        
    }
    
    
    
}
