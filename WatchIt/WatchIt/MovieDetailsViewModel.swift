import RxCocoa
import RxSwift

protocol MovieDetailsViewModelType {
    //input
    var addButtonDidTap: PublishSubject<Void> {get}
    var watchedButtonDidTap: PublishSubject<Void> {get}
    
    //output
    var addButtonEnabled: Driver<Bool> {get}
    var watchedButtonEnabled: Driver<Bool> {get}
    var posterImage: Driver<UIImage?> {get} //no idea what im doin
    var rateValue: Driver<String> {get}
    var presentRateMovieViewModel: Driver<RateMovieViewModelType> {get}
    
    //model update
    func downloadImage()
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
    let posterImage: Driver<UIImage?>
    let rateValue: Driver<String>
    let presentRateMovieViewModel: Driver<RateMovieViewModelType>
    
    //private
    private let disposeBag = DisposeBag()
    private let watchable: Watchable
    public let observableImage: PublishSubject = PublishSubject<UIImage?>()
    
    func loadImageFromWatchable(watchable:Watchable, completion:((_ image:UIImage) -> Void)) {
        completion(UIImage())
    }
    
    init(watchable:Watchable) {
        
        self.watchable = watchable
        self.addedToBase = Variable(true)
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
        
        self.posterImage = self.observableImage.asDriver(onErrorJustReturn: nil)
        self.rateValue = self.rateFromWatchable.asDriver().map({ rate in
            return rate
        })
        let presentRatingViewModel: Observable<RateMovieViewModelType> = self.watchedButtonDidTap.map{RateMovieViewModel()}
        self.presentRateMovieViewModel = presentRatingViewModel.asDriver(onErrorDriveWith: .empty())
        
    }
    
    func downloadImage() {
        guard let fromURL = URL(string: self.watchable.posterURL) else { return }
        let session = URLSession.shared
        var image: UIImage?
        
        let downloadTask = session.downloadTask(with: fromURL, completionHandler:
            {
                url, response, error in
                
                if error == nil, let url = url
                {
                    do {
                        let data = try Data(contentsOf: url)
                        image = UIImage(data: data) ?? nil
                        self.observableImage.onNext(image)
                    }
                    catch {
                        print("no data")
                    }
                    
                    
                    
                }
            })
        
        downloadTask.resume()

    }
    
}
