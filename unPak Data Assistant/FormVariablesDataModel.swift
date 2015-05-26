//
//  FormVariablesDataModel.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 5/26/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit
import CoreData

@objc(FormVariablesDataModel)
class FormVariablesDataModel: NSManagedObject {
	@NSManaged	var plantId: String
	@NSManaged	var plantPosition: String
	
   
}
