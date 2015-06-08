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
	
	
	//Changing variables 
	var rowInfoForPlantId:[String:String]!
	
	var plantID:String!
	var dataPointsHeaders:Array<String>!

	var allRowInfo:[Dictionary<String,String>]!
	
	@IBOutlet weak var idLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
	


	override func viewDidLoad() {
		super.viewDidLoad()
		self.allRowInfo = self.formService.getRowsInfo()!
		self.tableView.dataSource = self
		self.dataPointsHeaders = self.formService.getHeaders()
		
		
		self.loadData()
		
		
	}
	override func viewDidAppear(animated: Bool) {
		self.loadData()
		
		self.tableView.reloadData()


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
		
		if !(self.rowInfoForPlantId[cell.textLabel!.text!]!.isEmpty){
			cell.accessoryType = UITableViewCellAccessoryType.Checkmark
		}
		

		return cell
	}
	
	
	
	//Private method for loading proper plantId + info
	
	private func loadData(){
		navigationItem.title = self.NAVIGATION_TITLE
		
		self.rowInfoForPlantId = self.allRowInfo[self.currentIndex]
		self.plantID = self.rowInfoForPlantId ["Plant ID"]
		self.idLabel.text = self.plantID
		
		
		
		
	}
	
	//Pass formService object to DataEntryViewController 
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		let vc:DataEntryViewController = segue.destinationViewController as! DataEntryViewController
		
		vc.formService = self.formService
		vc.rowInfoForPlantId = self.rowInfoForPlantId
		vc.currentHeaderIndex = self.tableView.indexPathForSelectedRow()?.row
	}

	@IBAction func nextWasPressed(sender: AnyObject) {
	}
	
	@IBOutlet weak var previousWasPressed: UIButton!

	
	
}
