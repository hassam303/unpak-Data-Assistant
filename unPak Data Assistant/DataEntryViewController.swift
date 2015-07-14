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
	
	// Variables relating to AlertView Textfeild
	var textDataEntered:Bool = false
	var textDataEnteredString:String!
	
	
	
	@IBOutlet weak var nextButton: UIButton!
	@IBOutlet weak var previousButton: UIButton!
	@IBOutlet weak var saveButton: UIBarButtonItem!

	@IBOutlet weak var navigationTitleBar: UINavigationItem!
	@IBOutlet weak var textSwitch: UISwitch!
	@IBOutlet weak var stepper: UIStepper!
	
	let TEXT_FIELD_PLACEHOLDER:String = "Enter Data:"
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
		self.numberTextField.placeholder = self.TEXT_FIELD_PLACEHOLDER
		
		self.headers = self.formService.getHeaders()
		self.editedRows = self.formService.getEditedRows()

		
		//Set-up comment alert window
		alert = UIAlertController(title: "Enter Comment", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
		
		cancelButtonActionStyle = UIAlertActionStyle.Cancel
		cancelButtonAction = UIAlertAction(title: "Cancel", style: cancelButtonActionStyle, handler: nil)
		
		
		confirmButtonActionStyle = UIAlertActionStyle.Default
		confirmButtonAction = UIAlertAction(title: "Confirm", style: confirmButtonActionStyle, handler: { (alert) in
			var alertTextField:UITextField = self.alert.textFields![0] as! UITextField
			
			
			if alertTextField.text != self.startData{
				self.textDataEnteredString = alertTextField.text
				self.textDataEntered = true
				
				self.saveButton.enabled = true
				

	
			}
			
			alertTextField.text = nil
			
			
			
			print(alertTextField.text)
			
			
			

		})
		
		

		alert.addAction(confirmButtonAction)
		alert.addAction(cancelButtonAction)
		
		alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
			
			textField.secureTextEntry = false
			
			if self.startData != nil{
				textField.placeholder = self.startData
				
			}
			
			else {
				textField.placeholder = self.TEXT_FIELD_PLACEHOLDER

			}
			
		})
		
		
		
		
		
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		self.loadData()
	}
	
	
	
	//UI related logic methods
	@IBAction func previousButtonWasPressed(sender: AnyObject) {
		
//		if self.checkDataForSave(self.getTextFieldInput()){
//			self.saveData()
//		}
		
		self.saveData()
		
		self.currentHeaderIndex! -= 1
		
		self.loadData()
		
		
	}
	@IBAction func nextButtonWasPressed(sender: AnyObject) {
		
		
//		if self.checkDataForSave(self.getTextFieldInput()){
//			self.saveData()
//		}
		
		self.saveData()
		self.currentHeaderIndex! += 1
		
		self.loadData()
		
		}
	
	
	@IBAction func saveWasPressed(sender: AnyObject) {
			self.saveData()
	
			self.numberTextField.resignFirstResponder()
	
	
		
	}
	
	@IBAction func textInputButtonPressed(sender: AnyObject) {
	
		
		self.presentViewController(alert, animated: true, completion: nil)
		
		
		
		
	}
	
	@IBAction func stepperTriggered(sender: AnyObject) {
		
	}

	@IBAction func numberValueChanged(sender: AnyObject) {
		self.navigationItem.hidesBackButton = true
		self.saveButton.enabled = true
		
		
	}
	
	
	
	//Private convenience methods relating to current data and view set-up
	
	private func checkDataForSave(testData:String) -> Bool {
		var rtnval:Bool = false
		
		if testData != self.startData &&  testData != self.TEXT_FIELD_PLACEHOLDER {
			self.newData = testData
			rtnval = true
		}
		
		
		
		
		return rtnval
	}
	
	private func getTextFieldInput() -> String {
		var testData:String
		
		if self.textDataEntered {
			
			testData = self.textDataEnteredString
		}
		
		else {
			testData = self.numberTextField.text

			
		}
		
		
		return testData
		
		
		
	}
	
	private func saveData(){
		
		if self.checkDataForSave(self.getTextFieldInput()){
			self.rowInfoForPlantId[self.headers[self.currentHeaderIndex]] = self.newData
			
			self.formService.addEditedRow(currentPlantId, dictionary: self.rowInfoForPlantId)
			
			self.navigationItem.hidesBackButton = false
		}
		
		
		
		self.loadData()

	}


	
	private func loadData(){
		
		self.textDataEntered = false
		
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
			
			var stringToInt:Int? = self.startData.toInt()
			
			print(stringToInt)
			
			
			self.numberTextField.text = self.startData
		}
			
		else{
			self.numberTextField.text = ""
			self.currentDataLabel.text = "-"
		}
		
		
		
		
	}
	
	
// Camera Set-Up
	
	
	
	

	
	
}
