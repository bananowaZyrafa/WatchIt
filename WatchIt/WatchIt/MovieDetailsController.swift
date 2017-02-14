import UIKit
import RxSwift
import RxCocoa
class MovieDetailsController: UIViewController {
    
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var watchedButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    var addButtonEnabled: Bool?
    private let disposeBag = DisposeBag()
    public var viewModel: MovieDetailsViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure(viewModel)
        self.addButtonEnabled = addButton.isEnabled
        print("addButton: \(addButtonEnabled)")
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func backButtonClicked(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }

    func configure(_ viewModel:MovieDetailsViewModelType) {
            
            viewModel.addButtonEnabled.drive(onNext: { [weak self] enabled in
                guard let safeSelf = self else {return}
                if enabled == true {
                    safeSelf.addButton.isEnabled = enabled
                    safeSelf.addButton.backgroundColor = UIColor.purple
                } else {
                    safeSelf.addButton.isEnabled = enabled
                    safeSelf.addButton.backgroundColor = UIColor.gray
                    safeSelf.addButton.titleLabel!.text = "ALREADY IN BASE"
                }
                }, onCompleted: { [weak self] in
                    guard let safeSelf = self else {return}
                    print("addButton: \(safeSelf.addButtonEnabled)")
                
                }, onDisposed: nil).addDisposableTo(disposeBag)
        
        
            viewModel.watchedButtonEnabled.drive(self.watchedButton.rx.isEnabled).addDisposableTo(disposeBag)
            viewModel.rateValue.drive(self.ratingLabel.rx.text)
                .addDisposableTo(disposeBag)
            viewModel.posterImage.drive(self.posterImage.rx.image)
                .addDisposableTo(disposeBag)
            viewModel.downloadImage()
            self.addButton.rx.tap.asObservable().subscribe(onNext: { [weak self] in
                guard let safeSelf = self else {return}
                safeSelf.viewModel.saveWatchableInDB()
                }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
            viewModel.addButtonEnabled.drive(self.addButton.rx.isEnabled).addDisposableTo(disposeBag)

    }

}
