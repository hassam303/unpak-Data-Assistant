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
	
	let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
	let fetch: NSFetchRequest = NSFetchRequest(entityName:"CurrentFormDB")

	var contxt: NSManagedObjectContext
	var ent: NSEntityDescription
	
	var form: CurrentFormDBManagedObject!
	
	
	// Form variables 
	var headers:[String]!
	var plantIds:[String]!
	var rowsInfo:[Dictionary<String, String>]!
	
	var userInitials:String!
	var formPath:String!
	var formName:String!
	

	
	init(useLatest:Bool) {
		
		// Initiate form Attributes 
		self.headers	= Array<String>()
		self.plantIds	= Array<String>()
		self.rowsInfo	= Array<Dictionary<String,String>>()
		
		self.userInitials = String()
		self.formPath	= String ()
		self.formName	= String ()
		
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
			
			//Test prints
			println("Current form properly assigned")
			
			
		}
		
		else{
			self.createForm()
		}
	}
	
		//Create a new form
	
	private func createForm(){
		// Create instatance of data model and initialize
		self.form		= CurrentFormDBManagedObject(entity: self.ent, insertIntoManagedObjectContext: self.contxt)
		
	}
	
	
	// Setting methods for form attributes
	func setHeaders(headersArray:[String]) -> Void{
		self.headers = headersArray
		
		// Save context
		
		contxt.save(nil)
		
	}
	
	func setPlantIds(plantIdArray:[String]) -> Void{
		self.plantIds = plantIdArray
		
		// Save context
		
		contxt.save(nil)
	}
	
	func setRowInfo(rowInfoArray:[Dictionary<String, String>]) -> Void {
		self.rowsInfo = rowInfoArray
		
		// Save context
		
		contxt.save(nil)
		
	}
	
	func setInitials(initials:String) -> Void{
		self.userInitials = initials
		
		// Save context
		
		contxt.save(nil)
		
	}

	func setPath(path:String) -> Void{
		self.formPath = path
		
		// Save context
		
		contxt.save(nil)
		
	}

	func setName(name:String) -> Void{
		self.formName = name
		
		// Save context
		
		contxt.save(nil)
		
	}

	
	
	// Getting methods for form attributes 
		//All methods return and optional object. If value is empty
	func getHeaders() -> [String]?{
		if !self.headers.isEmpty{
			return self.headers
		}
		
		return nil
		
	}
	
	func getPlantIds() -> [String]?{
		
		if !self.plantIds.isEmpty{
			return self.plantIds
		}
		
		return nil
		
	}
	
	func getRowsInfo() -> [Dictionary<String, String>]?{
		if !self.rowsInfo.isEmpty{
			return self.rowsInfo
		}
		
		return nil
	}
	
	func getUserInitials() -> String?{
		if !self.userInitials.isEmpty{
			return self.userInitials
		}
		
		return nil
	}
	
	func getFormPath() -> String?{
		if !self.formPath.isEmpty{
			return self.formPath
		}
		
		return nil
	}
	
	func getFormName() -> String?{
		if !self.formName.isEmpty{
			return self.formName
		}
		
		return nil
	}
	
	
	// Remove current form entity object 
	
	func removeForm() -> Void{
		
		self.contxt.deleteObject(self.form)
		
		self.contxt.save(nil)
	
	}
	
	
	

	
	
	
	
	

	
	
	
	
	
	
	
}
