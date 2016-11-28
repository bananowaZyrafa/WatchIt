import Moya
import Moya_ModelMapper
import UIKit
import RxOptional
import RxCocoa
import RxSwift


class SearchForMovieViewController: UIViewController {
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
        configureTableDataSource()
        watchableFinderModel
            .findWatchable()
            .bindTo(tableView.rx.items) { (tableView, row, item) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: IndexPath(row: row, section: 0)) as! SearchResultCell
                cell.configureForSearchResult(watchable: item)
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
    
    func configureTableDataSource() {
        tableView.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: "SearchResultCell")
        tableView.rowHeight = 190
        
    }

}

