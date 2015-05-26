//
//  UserVariablesDataModel.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 5/26/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit
import CoreData

class UserVariablesDataModel: NSManagedObject {
	@NSManaged	var formMetaData:	DBMetadata
	@NSManaged	var formName:		String
	@NSManaged	var userInitials:	String
   
}
