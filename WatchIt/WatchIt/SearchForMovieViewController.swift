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
    var latestProduction: Production?
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
                self.latestProduction = item
                let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: IndexPath(row: row, section: 0)) as! SearchResultCell
                cell.configureForSearchResult(watchable: item)
                return cell
            }
        .addDisposableTo(disposeBag)
        
        
        
        tableView
            .rx.itemSelected
            .subscribe { [weak self] indexPath in
                guard let safeSelf = self else {return}
                guard let prod = safeSelf.latestProduction else {return}
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "movieDetailsVC") as! MovieDetailsController
                controller.viewModel = MovieDetailsViewModel(watchable: prod)
                safeSelf.present(controller, animated: true, completion: nil)
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

