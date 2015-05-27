//
//  NewFormManagedObject.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 5/26/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit
import CoreData

@objc(NewFormManagedObject)
class NewFormManagedObject: NSManagedObject {
	@NSManaged	var formPath:		String
	@NSManaged	var formName:		String
	@NSManaged	var userInitials:	String
	
	
	override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
		super.init(entity: entity, insertIntoManagedObjectContext: context)
	}
   
}
