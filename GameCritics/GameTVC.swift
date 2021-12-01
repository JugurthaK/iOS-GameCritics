//
//  GameTVC.swift
//  GameCritics
//
//  Created by Jugurtha Kabeche on 23/11/2021.
//

import UIKit
import Alamofire
import AlamofireImage
import AlamofireObjectMapper

class GameTVC: UITableViewController {
    
    var games: Array<Game> = []
    
    func download(at url: String, handler: @escaping (Data?) -> Void) {
        guard let url = URL(string: url) else {
            debugPrint("Failed to create URL")
            handler(nil)
            return
        }
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            handler(data)
        }
        task.resume()
    }
    func getGames() {
        AF.request("https://education.3ie.fr/ios/StarterKit/GameCritic/GameCritics.json").responseArray {
            (response: DataResponse<[Game], AFError>) in
            do {
                self.games = try response.result.get()
                self.tableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getImage(url: String , completion: @escaping((UIImage) -> Void)) {
        AF.request(url).responseImage { response in
            if case .success(let image) = response.result {
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getGames()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return games.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)

        // Configure the cell...
        let game = games[indexPath.row]
        cell.textLabel?.text = game.name
        cell.detailTextLabel?.text = game.platform
        
        if let url = game.smallImageURL {
            self.getImage(url: url) { image in
                cell.imageView?.image = image
                cell.setNeedsLayout()
            }
        }

        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
