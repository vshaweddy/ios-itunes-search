//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Vici Shaweddy on 9/7/19.
//  Copyright © 2019 Vici Shaweddy. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        searchBar.delegate = self
        searchBar.resignFirstResponder()
        segmentedControl.addTarget(self, action: #selector(updateResult), for: .valueChanged)
    }
    
    // MARK: - Private Function
    @objc
    private func updateResult() {
        guard let searchTerm = searchBar.text else { return }
        
        var resultType: ResultType!
        
        switch segmentedControl.selectedSegmentIndex {
        case 0: // filter for apps
            resultType = .software
        case 1: // filter for music
            resultType = .musicTrack
        default: // filter for movies
            resultType = .movie
        }
        
        searchResultsController.performSearch(with: searchTerm, for: resultType) { (error) in
            if let error = error {
                print("Error loading recipes: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        
        let result = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator
        
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            if let detailVC = segue.destination as? DetailViewController {
                guard let indexPath = tableView.indexPathForSelectedRow else { return }
                
                detailVC.searchResult = self.searchResultsController.searchResults[indexPath.row]
            }
        }
    }

}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        updateResult()
    }
}
