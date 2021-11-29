//
//  ViewController.swift
//  PlistDemo
//
//  Created by Adriana González Martínez on 2/25/19.
//  Copyright © 2019 Adriana González Martínez. All rights reserved.
//

import UIKit

struct Scores: Decodable {
    let score: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case score = "Score"
        case name = "Name"
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    var scores : [Scores] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       
        //TODO: Get the list of scores coming from your plist
        
        let bundle = Bundle.main
        guard let scoresPListURL = bundle.url(forResource: "Scores", withExtension: "plist") else { return }
        
        
        //TODO: Add two entries by code
        let fileManager = FileManager.default
        guard let scoresPListURL = fileManager.contents(atPath: scoresPListURL.path) else { return }
        
        
        //TODO: Display the complete list of scores in the table view
        let decoder = PropertyListDecoder()
        guard let scores = try? decoder.decode([Scores].self, from: scoresPListURL) else {return}
        
        print(scores)
        self.scores = scores
        table.reloadData()
        
    }
    
    // MARK: Table setup
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Highest Scores 🚀"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        let item = scores[indexPath.row]
        
        
        //TODO: Make sure to display the score and name
        let score = item.score
        let name = item.name
        
        cell.textLabel?.text = "Score: \(score) Name: \(name)"
        
        
        return cell
        
    }
    
    //MARK: Plist handling
    //TODO: Keep your file clean by adding helper methods to handle the plist.
    
    
}
