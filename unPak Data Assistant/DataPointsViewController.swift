//
//  DataPointsViewController.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 5/22/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit

class DataPointsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
	
	var formService:CurrentFormEntityService!
	
	let NAVIGATION_TITLE:String = "Data Points"
	
	//Segued in
	var currentIndex:Int!
	
	//From DataEntry
	
	var editedRowInfoExsists:Bool!
	
	
	//Changing variables 
	var rowInfoForPlantId:[String:String]!
	
	var plantID:String!
	var dataPointsHeaders:Array<String>!

	var allRowInfo:[Dictionary<String,String>]!
	
	@IBOutlet weak var idLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var nextButton: UIButton!
	@IBOutlet weak var previousButton: UIButton!
	

	override func viewDidLoad() {
		super.viewDidLoad()
		self.allRowInfo = self.formService.getRowsInfo()!
		self.tableView.dataSource = self
		self.tableView.delegate = self
		self.dataPointsHeaders = self.formService.getHeaders()
		
		self.loadData()
		
		
	}
	override func viewDidAppear(animated: Bool) {
		self.loadData()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	
	//UITableView Set-Up
	func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 0
	}
	
	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 0
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.dataPointsHeaders.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("dataPointsCell") as! UITableViewCell
		let iP = indexPath
		cell.textLabel!.text = self.dataPointsHeaders[iP.row]
		
		if !(self.rowInfoForPlantId[self.dataPointsHeaders[iP.row]]!.isEmpty){
			cell.accessoryType = UITableViewCellAccessoryType.Checkmark
		}
		
		else{
			cell.accessoryType = UITableViewCellAccessoryType.None
		}
		

		return cell
	}
	
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		self.goToDataEntryView(indexPath)
	}
	
	
	//Private method for loading proper plantId + info
	
	private func loadData(){
		navigationItem.title = self.NAVIGATION_TITLE
		
		self.plantID = self.allRowInfo[self.currentIndex]["Plant ID"]
		self.idLabel.text = self.plantID

		
		//Logic for determining whether to use CSV rowInfo or previousEdited info
		var editedData = self.formService.getEditedRows()[self.plantID]
		
		if (editedData != nil){
			self.rowInfoForPlantId = editedData
		}
			
		else {
			self.rowInfoForPlantId = self.allRowInfo[self.currentIndex]
			
		}
		
		
		
		//Switch to perform logic concering the appearance of the Next and Previous buttons
		switch self.currentIndex {
		case (self.formService.getPlantIds()!.count - 1) :
			self.nextButton.hidden = true
			break
			
		case 0 :
			self.previousButton.hidden = true
			break
			
		default:
			self.nextButton.hidden = false
			self.previousButton.hidden = false
			break
			
		}
		
		
		self.tableView.reloadData()

		
		
		
		
	}
	
	//Pass formService object to DataEntryViewController 
	
	private func goToDataEntryView(indexPath:NSIndexPath){
		
		let nextView = self.storyboard?.instantiateViewControllerWithIdentifier("DataEntryViewController") as! DataEntryViewController
		
		nextView.formService = self.formService
		
		nextView.rowInfoForPlantId = self.rowInfoForPlantId
		nextView.currentHeaderIndex = indexPath.row
		nextView.currentPlantId = self.plantID
		
		
		self.navigationController?.pushViewController(nextView, animated: true)
		
	}
	
	
	
	
	
	
	//UIButton logic 
	@IBAction func saveButtonPressed(sender: AnyObject) {
		
		
		
		
	}
	
	@IBAction func nextWasPressed(sender: AnyObject) {
		
		++self.currentIndex!
		self.loadData()
		
		
	}
	
	@IBAction func previousButtonPressed(sender: AnyObject) {
		--self.currentIndex!
		self.loadData()

	}

	
	
}
