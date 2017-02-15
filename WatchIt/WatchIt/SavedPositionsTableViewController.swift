import UIKit

class SavedPositionsTableViewController: UITableViewController {

    var posterImages: [UIImage] = [UIImage(named:"Matrix")!,UIImage(named:"breakingBad")!,UIImage(named:"lalaland")!]
    var cellNames = ["The Matrix", "Breaking Bad", "Lalaland"]
    var ratings = ["","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName:"SavedPropositionTableViewCell",bundle:nil), forCellReuseIdentifier: "savedPropositionCell")
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 127
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedPropositionCell", for: indexPath) as! SavedPropositionTableViewCell
        cell.posterImage.image = posterImages[indexPath.row]
        cell.titleLabel.text = cellNames[indexPath.row]
        cell.rateLabel.text = ratings[indexPath.row]


        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "goToRating", sender: indexPath)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "rateVC") as! RatePositionViewController
        
        let indexPath = self.tableView.indexPathForSelectedRow!
        
        controller.titleLabelForLabel = self.cellNames[indexPath.row]
        controller.posterImageForPoster = self.posterImages[indexPath.row]
        controller.currentIndex = indexPath.row
        navigationController?.pushViewController(controller, animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
//        if segue.identifier == "goToRating",
//            let controller = segue.destination as? RatePositionViewController, let indexPath = self.tableView.indexPathForSelectedRow {
//            controller.posterImage.image = self.posterImages[indexPath.row]
//            controller.currentIndex = indexPath.row
//        }

//        let controller = segue.destinationViewController as! RatePositionViewController
//        let indexPath = self.tableView.indexPathForSelectedRow!
//        controller.titleLabel.text = self.cellNames[indexPath.row]
     //   controller.posterImage.image = self.posterImages[indexPath.row]
//        ?controller.currentIndex = indexPath.row
    
    
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
