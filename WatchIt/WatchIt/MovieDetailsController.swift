import UIKit
import RxSwift
import RxCocoa
class MovieDetailsController: UIViewController {
    
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var watchedButton: UIButton!
    
    private let disposeBag = DisposeBag()
    public var viewModel: MovieDetailsViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure(viewModel)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    @IBAction func addToBase(_ sender: AnyObject) {
//        
//    }
//    
//    
//    @IBAction func markAsWatched(_ sender: AnyObject) {
//        
//    }
    func configure(_ viewModel:MovieDetailsViewModelType) {
            
            viewModel.addButtonEnabled.drive(self.addButton.rx.isEnabled)
                .addDisposableTo(disposeBag)
            viewModel.watchedButtonEnabled.drive(self.watchedButton.rx.isEnabled).addDisposableTo(disposeBag)
            viewModel.rateValue.drive(self.ratingLabel.rx.text)
                .addDisposableTo(disposeBag)
            viewModel.posterImage.drive(self.posterImage.rx.image)
                .addDisposableTo(disposeBag)
            viewModel.downloadImage()
        
    }

}
