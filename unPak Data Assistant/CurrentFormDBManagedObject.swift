//
//  CurrentFormDBManagedObject.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 5/26/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit
import CoreData

@objc(CurrentFormDBManagedObject)

class CurrentFormDBManagedObject: NSManagedObject {
	@NSManaged	var userInitials:String
	@NSManaged	var formPath:String
	@NSManaged	var formName:String
	
	@NSManaged	var headers:[String]
	@NSManaged	var plantIds:[String]
	@NSManaged	var rowsInfo:[Dictionary<String,String>]
	@NSManaged	var editedRows:Dictionary<String,(Dictionary<String,String>)>
	
	
	override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
		super.init(entity: entity, insertIntoManagedObjectContext: context)
	}
	
}
