//
//  DataEntryViewController.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 5/22/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit

class DataEntryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
	
	var rowInfoForPlantId:[String:String]!
	var dataPointsHeaders:Array<String>!
	
	@IBOutlet weak var idLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
	

	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.dataSource = self
		println(self.rowInfoForPlantId)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	
	//UITableView Set-Up
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.dataPointsHeaders.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("dataPointsCell") as! UITableViewCell
		let iP = indexPath
		cell.textLabel!.text = self.dataPointsHeaders[iP.row]
		
		return cell
	}
	

	

	
	
}
