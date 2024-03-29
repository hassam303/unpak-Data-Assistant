//
//  PlantIdCollectionViewController.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 5/22/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit

class PlantIdCollectionViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,DBRestClientDelegate {
	
	let restClient:DBRestClient = DBRestClient(session: DBSession.sharedSession())

	
	let NUMBER_OF_CHARACTERS_ALLOWED_FOR_PLANTID:Int = 4
	let NAVIGATION_TITLE:String = "Plant IDs"
	var formService:CurrentFormEntityService!

	
	var editedRows:Dictionary<String,Dictionary<String,String>>!
	
	var selectedItemID:String = String()
	var selectedItemRowInfo: [String:String]!
	
	var numberOfItemsInRow:Int = 4
	var numberOfRows:Int = 8
	
	var csvHeadersArray: [String] = []
	var csvplantIdArray:Array<String> = []
	var csvRowsDataArray: [Dictionary<String, String>]!


	
	@IBOutlet weak var uploadButton: UIBarButtonItem!
	@IBOutlet weak var collectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView.dataSource = self
		collectionView.delegate = self
		
		self.restClient.delegate = self

		
		self.csvplantIdArray = self.formService.getPlantIds()!
		self.csvRowsDataArray = self.formService.getRowsInfo()
		self.navigationItem.hidesBackButton = true
		
		
	}
	

	override func viewDidAppear(animated: Bool) {
		navigationItem.title = self.NAVIGATION_TITLE
		
		self.editedRows = self.formService.getEditedRows()
		
		if !self.editedRows.isEmpty {
			self.uploadButton.enabled = true 
			
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	
	// Collection view set-up methods
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let iP:NSIndexPath = indexPath
		
		let cell:PlantIdCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("plantIdCell", forIndexPath: iP) as! PlantIdCollectionViewCell
		
		
		cell.selected = false 
		
		var tempCellLabel:NSString  = self.csvplantIdArray[iP.row] as NSString
		let tempCellLength:Int = tempCellLabel.length
		
		
		if tempCellLength > self.NUMBER_OF_CHARACTERS_ALLOWED_FOR_PLANTID {
			tempCellLabel = tempCellLabel.substringToIndex(self.NUMBER_OF_CHARACTERS_ALLOWED_FOR_PLANTID)
			
		}
		
		
		
		
		
		
		
		
		
		
		
		cell.cellLabel.text = tempCellLabel as String
		
		return cell
	}
	
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSizeMake(0, 0)
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.csvplantIdArray.count
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
		return UIEdgeInsetsMake(5, 5, 5, 5)
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		return CGSizeMake(75, 50)
	}
	
	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

		self.goToDataPointsView(indexPath)
	
	
	
	
	}
	
	
	private func goToDataPointsView (indexPath:NSIndexPath){
		
		let nextView = self.storyboard?.instantiateViewControllerWithIdentifier("DataPointsViewController") as! DataPointsViewController
		
		nextView.currentIndex = indexPath.row
		nextView.formService = self.formService
		
		self.navigationController?.pushViewController(nextView, animated: true)
		
	}
	
	
	
	
	
	
	//############# NEEDS TO BE COMPLETED
	@IBAction func uploadWasPressed(sender: UIBarButtonItem) {
		self.upload()

		
		
		
	}
	
	private func upload(){
		let csvExport:CSVExport = CSVExport(formService: self.formService)
		csvExport.prepareCSV()
		
		print(csvExport.filename, terminator: "")
		
		dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
			self.restClient.uploadFile(csvExport.filename, toPath: "/Data_Assistant_Files/DataCheck", withParentRev: nil, fromPath: csvExport.localFilePath)

		})
		

		
	}
	
	func restClient(client: DBRestClient!, uploadedFile destPath: String!, from srcPath: String!, metadata: DBMetadata!) {
		print("Uploaded\n", terminator: "")
		print (metadata.path, terminator: "")
	}
	
	func restClient(client: DBRestClient!, uploadFileFailedWithError error: NSError!) {
		print("Not Uploaded", terminator: "")
	}
	
	
}
