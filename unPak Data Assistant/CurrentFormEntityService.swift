//
//  CurrentFormEntityService.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 6/5/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//
// This class will help manage the current csv file to the CoreData entity

import UIKit
import CoreData

class CurrentFormEntityService {
	
	// Reference to AppDelegate
	
	private let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
	private let fetch: NSFetchRequest = NSFetchRequest(entityName:"CurrentFormDB")

	private var contxt: NSManagedObjectContext
	private var ent: NSEntityDescription
	
	private var form: CurrentFormDBManagedObject!
	
	
	// Form variables 
	private var headers:[String]!
	private var plantIds:[String]!
	private var rowsInfo:[Dictionary<String, String>]!
	private var editedRows: Dictionary <String,Dictionary<String,String>>!
	
	private var userInitials:String!
	private var formPath:String!
	private var formName:String!
	

	
	init(useLatest:Bool) {
		
		// Reference managed object context
		self.contxt		= self.appDel.managedObjectContext!
		self.ent		= NSEntityDescription.entityForName("CurrentFormDB", inManagedObjectContext: self.contxt)!
		
		
		// Assign proper form 
		
		if useLatest {
			self.assignLatestForm()
		}
		
		else{
			self.createForm()
		}
		
		
		
	}
	
	//Methods to assign proper form
	
		//Assigns the latest added entity or creates new form if none exsists
	private func assignLatestForm(){
		
		let fetchRequestArray:Array<AnyObject> = try! contxt.executeFetchRequest(self.fetch)

		if !fetchRequestArray.isEmpty{
		
			// Local array variable containing ALL available CurrentFormDB Objects
			
			// Get current form from fetchRequestArray
			self.form = fetchRequestArray.last as! CurrentFormDBManagedObject
			
		}
		
		else{
			self.createForm()
		}
	}
	
		//Create a new form
	
	private func createForm(){
		// Create instatance of data model and initialize
		self.form		= CurrentFormDBManagedObject(entity: self.ent, insertIntoManagedObjectContext: self.contxt)
		do {
			try self.contxt.save()
		} catch _ {
		}
		
	}
	
	
	// Setting methods for form attributes
	func setHeaders(headersArray:[String]) -> Void{
		self.form.headers = headersArray
		
		
		
		do {
			// Save context
			
			try contxt.save()
		} catch _ {
		}
		self.syncHeaders()
		
	}
	
	func setPlantIds(plantIdArray:[String]) -> Void{
		self.form.plantIds = plantIdArray
		
		do {
			// Save context
			
			try contxt.save()
		} catch _ {
		}
		self.syncPlantIds()
	}
	
	func setRowInfo(rowInfoArray:[Dictionary<String, String>]) -> Void {
		self.form.rowsInfo = rowInfoArray
		
		do {
			// Save context
			
			try contxt.save()
		} catch _ {
		}
		self.syncRowsInfo()
		
	}
	
	func setInitials(initials:String) -> Void{
		self.form.userInitials = initials
		
		do {
			// Save context
			
			try contxt.save()
		} catch _ {
		}
		self.syncUserInitials()
		
	}

	func setPath(path:String) -> Void{
		self.form.setValue(path, forKey: "formPath")
		
		do {
			// Save context
			
			try contxt.save()
		} catch _ {
		}
		self.syncFormPath()
		
	}

	func setName(name:String) -> Void{
		self.form.formName = name
		
		do {
			// Save context
			
			try contxt.save()
		} catch _ {
		}
		self.syncFormName()
		
	}

	func addEditedRow(plantId:String,dictionary: Dictionary<String,String>) {
		self.form.editedRows.updateValue(dictionary, forKey: plantId)
		
		do {
			//Save context 
			try contxt.save()
		} catch _ {
		}
		self.syncEditedRows()
	}
	
	
	// Getting methods for form attributes 
		//All methods return and optional object. If value is empty
	func getHeaders() -> [String]?{
		if self.headers != nil{
			return self.headers
		}
		
		return nil
		
	}
	
	func getPlantIds() -> [String]?{
		
		if self.plantIds != nil{
			return self.plantIds
		}
		
		return self.form.plantIds
		
	}
	
	func getRowsInfo() -> [Dictionary<String, String>]?{
		return self.form.rowsInfo
	}
	
	func getUserInitials() -> String?{
		return self.form.userInitials
	}
	
	func getFormPath() -> String?{
		return self.form.formPath
	}
	
	func getFormName() -> String?{
		return self.form.formName
	}
	
	func getEditedRows() -> Dictionary <String,Dictionary<String,String>> {
		return self.form.editedRows
	}
	
	
	// Remove current form entity object 
	
	func removeForm() -> Void{
		
		self.contxt.deleteObject(self.form)
		
		do {
			try self.contxt.save()
		} catch _ {
		}
	
	}
	
	//Sync local variables from core data entity
	
	func syncAllData() -> Void {
		self.headers	= self.form.headers
		self.plantIds	= self.form.plantIds
		self.rowsInfo	= self.form.rowsInfo
		self.editedRows = self.form.editedRows
		
		self.userInitials = self.form.userInitials
		self.formPath	= self.form.formPath
		self.formName	= self.form.formName
	}
	
	private func syncHeaders() -> Void {
		self.headers	= self.form.headers
	}
	
	private func syncPlantIds() -> Void {
		self.plantIds	= self.form.plantIds
	}
	
	private func syncRowsInfo() -> Void {
		self.rowsInfo	= self.form.rowsInfo
	}
	
	private func syncUserInitials() -> Void {
		self.userInitials = self.form.userInitials
	}
	
	private func syncFormPath() -> Void {
		self.formPath	= self.form.valueForKey("formPath") as! String
	}
	
	private func syncFormName() -> Void {
		self.formName	= self.form.formName
	}
	
	private func syncEditedRows() -> Void {
		self.editedRows = self.form.editedRows
	}
	
	

	func description() -> String {
		return self.form.description
	}
	
	
	
	

	
	
	
	
	
	
	
}
