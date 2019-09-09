//
//  DetailViewController.swift
//  iTunesSearch
//
//  Created by Vici Shaweddy on 9/8/19.
//  Copyright © 2019 Vici Shaweddy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var kindLabel: UILabel!
    
    var searchResult: SearchResult? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        
        
        
        if let unwrappedSearchResult = searchResult {
            guard let urlImage = URL(string: unwrappedSearchResult.image ?? "") else { return }
            
            var dataImage = Data()
            do {
                dataImage = try Data(contentsOf: urlImage)
            } catch {
                print("Error")
            }
        
            self.imageView.image = UIImage(data: dataImage)
            self.titleLabel.text = unwrappedSearchResult.title
            self.creatorLabel.text = unwrappedSearchResult.creator
            self.countryLabel.text = unwrappedSearchResult.country
            self.kindLabel.text = unwrappedSearchResult.kind?.capitalized
            navigationItem.title = unwrappedSearchResult.creator
        } else {
            print("No result")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
