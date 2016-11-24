import Moya
import Moya_ModelMapper
import UIKit
import RxOptional
import RxCocoa
import RxSwift


class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    let disposeBag = DisposeBag()
    var provider: RxMoyaProvider<OMDB>!
    var watchableFinderModel: WatchableFinderModel!
    
    var latestTitle: Observable<String> {
        return searchBar.rx.text
                .filterNil()
                .debounce(0.5, scheduler: MainScheduler.instance)
                .distinctUntilChanged()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupRx() {
        provider = RxMoyaProvider<OMDB>()
        watchableFinderModel = WatchableFinderModel(provider: provider, watchableName: latestTitle)
        watchableFinderModel
            .findWatchable()
            .bindTo(tableView.rx.items) { (tableView, row, item) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "watchableCell", for: IndexPath(row: row, section: 0))
                cell.textLabel?.text = item.mapTitle
                
                return cell
        }
        .addDisposableTo(disposeBag)
        
        
        tableView
            .rx.itemSelected
            .subscribe { indexPath in
                if self.searchBar.isFirstResponder == true {
                    self.view.endEditing(true)
                }
            }
            .addDisposableTo(disposeBag)
    }
    
    func url(_ route: TargetType) -> String {
        return route.baseURL.appendingPathComponent(route.path).absoluteString
    }

}

