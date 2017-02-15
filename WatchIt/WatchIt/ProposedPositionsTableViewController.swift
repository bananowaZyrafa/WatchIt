import UIKit

class ProposedPositionsTableViewController: UITableViewController {

    
    var posterImages: [UIImage] = [UIImage(named:"Matrix")!,UIImage(named:"breakingBad")!,UIImage(named:"lalaland")!]
    var cellNames = ["The Matrix", "Breaking Bad", "Lalaland"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName:"PropositionTableViewCell",bundle:nil), forCellReuseIdentifier: "propositionCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "propositionCell", for: indexPath) as! PropositionTableViewCell
        cell.posterImage.image = posterImages[indexPath.row]
        cell.positionTitle.text = cellNames[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 127
    }
    
}
