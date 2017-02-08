import RxCocoa
import RxSwift
import CoreData

protocol MovieDetailsViewModelType {
    //input
    var addButtonDidTap: PublishSubject<Void> {get}
    var watchedButtonDidTap: PublishSubject<Void> {get}
    
    //output
    var addButtonEnabled: Driver<Bool> {get}
    var watchedButtonEnabled: Driver<Bool> {get}
    var posterImage: Driver<UIImage?> {get}
    var rateValue: Driver<String> {get}
    var presentRateMovieViewModel: Driver<RateMovieViewModelType> {get}
    
    //model update
    func downloadImage()
}


struct MovieDetailsViewModel: MovieDetailsViewModelType {
    
    // 2-Way Binding
    var addedToBase: Variable<Bool>
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
        self.seen = Variable(false)
        self.rateFromWatchable = Variable(watchable.imdbRating)
        self.addedToBase = Variable(false)
        self.addButtonEnabled = self.addedToBase.asDriver().startWith(true)
        
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
    
    mutating func checkIfWatchableAlreadyInDB() {
        let watchable = self.watchable
        let fetchRequest:NSFetchRequest<WatchableEntity> = WatchableEntity.fetchRequest()
        do {
            let searchResults = try CoreDataStack.getContext().fetch(fetchRequest)
            print("number of results: \(searchResults.count)")
            for result in searchResults as [WatchableEntity] {
                if result.title == watchable.title {
                    self.addedToBase = Variable(true)
                } else {
                    self.addedToBase = Variable(false)
                }
            }
        } catch {
            print("error: \(error)")
        }
        
    }
    
    mutating func saveWatchableInDB() {
        let watchable = self.watchable
        let managedContext = CoreDataStack.getContext()
        let entity = NSEntityDescription.entity(forEntityName: "WatchableEntity", in: managedContext)!
        let watch = NSManagedObject(entity: entity, insertInto: managedContext)
        watch.setValue(watchable.title, forKeyPath: "title")
        watch.setValue(watchable.runtime, forKeyPath: "runtime")
        watch.setValue(watchable.posterURL, forKeyPath: "posterURL")
        watch.setValue(watchable.imdbRating, forKeyPath: "imdbRating")
        watch.setValue(false, forKeyPath: "isSeen")
        do{
            try managedContext.save()
        } catch let error as NSError {
            print("couldn't save to DB: \(error)")
        }
        
        self.addedToBase = Variable(true) //zwracam false mimo ze dodane do bazy bo źle obsługiwany driver do przycisku u góry
    }
    
    
    
    
}
