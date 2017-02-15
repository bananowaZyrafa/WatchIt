import UIKit

class RatePositionViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    
    var titleLabelForLabel = ""
    var posterImageForPoster = UIImage()
    var currentIndex = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = titleLabelForLabel
        self.posterImage.image = posterImageForPoster
        self.rateLabel.text = "5.0"
        self.slider.setValue(5.0, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveClicked(_ sender: AnyObject) {
        let controller = self.navigationController?.viewControllers.first as? SavedPositionsTableViewController
        controller?.ratings[currentIndex] = rateLabel.text!
        controller?.tableView.reloadData()
        _ = navigationController?.popViewController(animated: true)
    
    }

    func saveRateInDB(productionTitle:String, rate:String) {
        
//        let managedContext = CoreDataStack.getContext()
//        let entity = NSEntityDescription.entity(forEntityName: "WatchableEntity", in: managedContext)!
//        let watch = NSManagedObject(entity: entity, insertInto: managedContext)
//        watch.setValue(watchable.title, forKeyPath: "title")
//        watch.setValue(watchable.runtime, forKeyPath: "runtime")
//        watch.setValue(watchable.posterURL, forKeyPath: "posterURL")
//        watch.setValue(watchable.imdbRating, forKeyPath: "imdbRating")
//        watch.setValue(false, forKeyPath: "isSeen")
//        do{
//            try managedContext.save()
//        } catch let error as NSError {
//            print("couldn't save to DB: \(error)")
//        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        rateLabel.text = "\(sender.value.rounded())"
        
    }
    
    
    
}
