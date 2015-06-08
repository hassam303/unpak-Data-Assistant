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
		
		let fetchRequestArray:Array<AnyObject> = contxt.executeFetchRequest(self.fetch, error: nil)!

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
		self.contxt.save(nil)
		
	}
	
	
	// Setting methods for form attributes
	func setHeaders(headersArray:[String]) -> Void{
		self.form.headers = headersArray
		
		
		
		// Save context
		
		contxt.save(nil)
		self.syncHeaders()
		
	}
	
	func setPlantIds(plantIdArray:[String]) -> Void{
		self.form.plantIds = plantIdArray
		
		// Save context
		
		contxt.save(nil)
		self.syncPlantIds()
	}
	
	func setRowInfo(rowInfoArray:[Dictionary<String, String>]) -> Void {
		self.form.rowsInfo = rowInfoArray
		
		// Save context
		
		contxt.save(nil)
		self.syncRowsInfo()
		
	}
	
	func setInitials(initials:String) -> Void{
		self.form.userInitials = initials
		
		// Save context
		
		contxt.save(nil)
		self.syncUserInitials()
		
	}

	func setPath(path:String) -> Void{
		self.form.setValue(path, forKey: "formPath")
		
		// Save context
		
		contxt.save(nil)
		self.syncFormPath()
		
	}

	func setName(name:String) -> Void{
		self.form.formName = name
		
		// Save context
		
		contxt.save(nil)
		self.syncFormName()
		
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
	
	func getEditedRows() -> [Dictionary<String,String>]{
		return self.form.editedRows
	}
	
	
	// Remove current form entity object 
	
	func removeForm() -> Void{
		
		self.contxt.deleteObject(self.form)
		
		self.contxt.save(nil)
	
	}
	
	//Sync local variables from core data entity
	
	func syncAllData() -> Void {
		self.headers	= self.form.headers
		self.plantIds	= self.form.plantIds
		self.rowsInfo	= self.form.rowsInfo
		
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
	
	

	func description() -> String {
		return self.form.description
	}
	
	
	
	

	
	
	
	
	
	
	
}
