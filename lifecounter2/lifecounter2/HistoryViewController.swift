//
//  HistoryViewController.swift
//  lifecounter2
//
//  Created by Rhea on 2/3/19.
//  Copyright © 2019 Rhea. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var historyTableView: UITableView!
	let cellReuseIdentifier = "historyCell"
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		self.historyTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
		historyTableView.delegate = self
		historyTableView.dataSource = self
    }
	
	// number of rows in table view
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return history.count }
	
	// create a cell for each table view row
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell:UITableViewCell = self.historyTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
		// format - "1 - Player 1 lost/gained 10 points", descending order
		cell.textLabel?.text = "\(history.count - indexPath.row - 1) - \(history[history.count - indexPath.row - 1])"
		
		return cell
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		historyTableView.reloadData()
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
