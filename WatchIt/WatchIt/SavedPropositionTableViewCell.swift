import UIKit

class SavedPropositionTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
