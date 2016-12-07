import UIKit

class SearchResultCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    var downloadTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 0.5)
        selectedBackgroundView = selectedView
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
 
    
    func configureForSearchResult(watchable:Watchable) {
        movieTitle.text = watchable.title
        posterImage.image = UIImage(named: "Placeholder")
        if let url = URL(string: watchable.posterURL){
            downloadTask = posterImage.loadImageWith(url: url)
        }
    }
    
    
}
