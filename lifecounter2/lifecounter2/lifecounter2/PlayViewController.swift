//
//  PlayViewController.swift
//  lifecounter2
//
//  Created by Rhea on 2/3/19.
//  Copyright © 2019 Rhea. All rights reserved.
//

import UIKit

var history : [String] = []
class PlayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
	
	let cellReuseIdentifier = "cell"
	
	var players : [String] = ["Player 1", "Player 2", "Player 3", "Player 4"]
	var playerScores : [Int] = [20, 20, 20, 20]
	
	var tableSelected : Int = -1
	var pickerSelected : Int = 0
	
	@IBOutlet weak var playerPicker: UIPickerView!
	@IBOutlet weak var scoreTableView: UITableView!
	@IBOutlet weak var pointsField: UITextField!
	

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		scoreTableView.delegate = self
		scoreTableView.dataSource = self
		playerPicker.delegate = self
		playerPicker.dataSource = self
		
		
	}
	
	// PICKER
	// number of col
	func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
	// number of row
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { return players.count }
	// Create each component of the picker
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { return players[row] }
	// Capture the picker view selection
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) { pickerSelected = row }
	
	// TABLE VIEW
	// number of row
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return players.count }
	
	/// Create cell for each table view row
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell : scoreCell = self.scoreTableView.dequeueReusableCell(withIdentifier: "Table View Cell") as! scoreCell
		cell.playerName.text = self.players[indexPath.row]
		cell.playerScore.text = String(self.playerScores[indexPath.row])
		
		return cell
	}
	
	// When cell is tapped
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableSelected = indexPath.row
		
		// Show alert asking for new name
		let alert = UIAlertController(title: "Edit Player Name", message: "Change name for \(players[tableSelected]) ...", preferredStyle: .alert)
		// Add Text Field
		alert.addTextField { (textField) in textField.placeholder = "New Player Name" }
		// Add Buttons
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
			let updatedPlayerName = alert!.textFields![0]
			self.editName(cellNum: self.tableSelected, newPlayerName: updatedPlayerName.text!)
		}))
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in return }))
		
		self.present(alert, animated: true, completion: nil)
	}
	
	// BUTTONS
	// INCREMENTAL BUTTONS
	@IBAction func buttonPressed (_ sender : UIButton){
		var multiplier : Int // Represents the + or - button
		switch sender.tag {
		case 0: multiplier = 1
		case 1: multiplier = -1
		default: return
		}
		updatePoints(cellNum: self.pickerSelected, incr: multiplier * Int(pointsField.text!)!)
	}
	
	func updatePoints(cellNum : Int, incr : Int) {
		playerScores[cellNum] += incr
		if (playerScores[cellNum] <= 0) {
			playerScores[cellNum] = 0
			updateLoss(loserCellNum: cellNum)
		}
		let incrText = incr < 0 ? "lost" : "gained"
		history.append("\(players[cellNum]) has \(incrText) \(abs(incr)) life points (\(playerScores[cellNum]) total points)")
		
		scoreTableView.reloadData()
	}
	
	func updateLoss(loserCellNum : Int) {
		history.append("\(players[loserCellNum]) has lost")
	}
	
	// ADD PLAYER BUTTON
	@IBAction func addButton(_ sender: Any) {
		// Show alert asking for name
		let alert = UIAlertController(title: "Add Player", message: "", preferredStyle: .alert)
		// Add Text Field
		alert.addTextField { (textField) in textField.placeholder = "New Player Name" }
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
			let newPlayerName = alert!.textFields![0]
			self.addPlayer(newPlayerName.text!)
		}))
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in return }))
		
		self.present(alert, animated: true, completion: nil)
	}
	
	func addPlayer(_ playerName : String) {
		players.append(playerName)
		playerScores.append(20) // Initial life counter
		history.append("\(playerName) added")
		
		scoreTableView.reloadData()
		playerPicker.reloadAllComponents()
	}
	
	// BONUS
	func editName(cellNum : Int, newPlayerName : String) {
		history.append("\(players[cellNum]) name was changed to \(newPlayerName) (\(playerScores[cellNum]) total)")
		players[cellNum] = newPlayerName
		
		scoreTableView.reloadData()
		playerPicker.reloadAllComponents()
	}

}

