//
//  DataEntryViewController.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 6/2/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit

class DataEntryViewController: UIViewController {
	var formService:CurrentFormEntityService!
	var headers:[String]!
	var rowInfoForPlantId:[String:String]!
	
	var editedRows:Dictionary<String,Dictionary<String,String>>!
	
	var currentHeaderIndex:Int!
	var currentDataPointTitle:String!
	var currentPlantId:String!
	var startData:String!
	var newData:String!
	
	var stepperValue:Double!
	
	var safeToExit:Bool = true
	
	@IBOutlet weak var nextButton: UIButton!
	@IBOutlet weak var previousButton: UIButton!
	@IBOutlet weak var saveButton: UIBarButtonItem!

	@IBOutlet weak var navigationTitleBar: UINavigationItem!
	@IBOutlet weak var textSwitch: UISwitch!
	@IBOutlet weak var stepper: UIStepper!
	
	let TEXT_FIELD_PLACEHOLDER:String = "Enter Data:"
	@IBOutlet weak var commentTextField: UITextField!
	@IBOutlet weak var numberTextField: UITextField!

	@IBOutlet weak var view2: UIView!
	@IBOutlet weak var textLabel: UILabel!
	@IBOutlet weak var currentDataLabel: UILabel!
	
	// Alert window variables
	var alert:UIAlertController!
	
	var cancelButtonActionStyle: UIAlertActionStyle!
	var cancelButtonAction: UIAlertAction!
	
	var confirmButtonActionStyle: UIAlertActionStyle!
	var confirmButtonAction: UIAlertAction!
	
	//Error message strings to be displayed in alert box
	
	let SAVE_DATA_WARNING:String = "Save and Exit?"
	

	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		self.numberTextField.keyboardType = UIKeyboardType.DecimalPad
		self.commentTextField.backgroundColor = UIColor.yellowColor()
		self.numberTextField.placeholder = self.TEXT_FIELD_PLACEHOLDER
		self.commentTextField.placeholder = self.TEXT_FIELD_PLACEHOLDER
		
		self.headers = self.formService.getHeaders()
		self.editedRows = self.formService.getEditedRows()

		
		//Set-up alert window
		alert = UIAlertController(title: "Save and exit", message: self.SAVE_DATA_WARNING, preferredStyle: UIAlertControllerStyle.Alert)
		
		cancelButtonActionStyle = UIAlertActionStyle.Cancel
		
		cancelButtonAction = UIAlertAction(title: "Cancel", style: cancelButtonActionStyle, handler: nil)
		
		
		confirmButtonActionStyle = UIAlertActionStyle.Destructive
		confirmButtonAction = UIAlertAction(title: "Confirm", style: confirmButtonActionStyle, handler: { (confirmButtionAction) -> Void in
		})
		
		alert.addAction(cancelButtonAction)
		alert.addAction(confirmButtonAction)
		
		
		
		
		
		
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		self.loadData()
	}
	
	
	
	//UI related logic methods
	@IBAction func previousButtonWasPressed(sender: AnyObject) {
		
		if self.checkDataForSave(self.getTextFieldInput()){
			self.saveData()
		}
		
		self.currentHeaderIndex! -= 1
		
		self.loadData()
		
		
	}
	@IBAction func nextButtonWasPressed(sender: AnyObject) {
		
		
		if self.checkDataForSave(self.getTextFieldInput()){
			self.saveData()
		}
		
		self.currentHeaderIndex! += 1
		
		self.loadData()
		
		}
	
	
	@IBAction func saveWasPressed(sender: AnyObject) {
		if self.checkDataForSave(self.getTextFieldInput()){
			self.saveData()
		}
		
		if self.view2.hidden{
			self.numberTextField.resignFirstResponder()
		}
		else{
			self.commentTextField.resignFirstResponder()
		}
		
	}
	
	@IBAction func switchTriggered(sender: AnyObject) {
		
		if self.view2.hidden == true{
			self.view2.hidden = false
			self.numberTextField.resignFirstResponder()
		}
		else{
			view2.hidden = true
			self.commentTextField.resignFirstResponder()
		}
	}
	@IBAction func stepperTriggered(sender: AnyObject) {
		
	}

	@IBAction func numberValueChanged(sender: AnyObject) {
		self.navigationItem.hidesBackButton = true
		self.saveButton.enabled = true
		
		
	}
	
	@IBAction func textValueChanged(sender: AnyObject) {
		self.navigationItem.hidesBackButton = true
		self.saveButton.enabled = true
	}
	
	
	
	//Private convenience methods relating to current data and view set-up
	
	private func checkDataForSave(testData:String) -> Bool {
		var rtnval:Bool = false
		
		if testData != self.startData &&  testData != self.numberTextField.placeholder! {
			self.newData = testData
			rtnval = true
		}
		
		
		
		
		return rtnval
	}
	
	private func getTextFieldInput() -> String {
		var testData:String
		
		switch self.textSwitch.on {
		case true:
			testData = self.commentTextField.text
			break
			
		default:
			testData = self.numberTextField.text
			break
		}
		
		
		
		return testData
		
		
		
	}
	
	private func saveData(){
		self.rowInfoForPlantId[self.headers[self.currentHeaderIndex]] = self.newData
		
		self.formService.addEditedRow(currentPlantId, dictionary: self.rowInfoForPlantId)
		
		self.navigationItem.hidesBackButton = false
		
		self.loadData()

	}

	
	
	private func loadData(){
		self.currentDataPointTitle = self.headers[self.currentHeaderIndex]
		
		self.navigationTitleBar.title = self.currentDataPointTitle
		
		
		self.startData = self.rowInfoForPlantId[self.currentDataPointTitle]
		
		self.saveButton.enabled = false
		
		switch self.currentHeaderIndex! {
		case self.headers.count - 1  :
			self.nextButton.hidden = true
			
			break
			
		case self.headers.startIndex :
			self.previousButton.hidden = true
			
			break
			
		default:
			self.nextButton.hidden = false
			self.previousButton.hidden = false
			break
		}
		
		if !self.startData.isEmpty{
			self.currentDataLabel.text = self.startData
			self.numberTextField.text = self.startData
			self.commentTextField.text = self.startData
		}
			
		else{
			self.numberTextField.text = ""
			self.commentTextField.text = ""
			self.currentDataLabel.text = "-"
		}
		
		
		
		
	}
	
	
	
	
	
}
