//
//  FormMenuViewController.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 5/20/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit

class FormMenuViewController: UIViewController {
	
	@IBOutlet weak var formNameLabel: UILabel!
	
	@IBOutlet weak var initalsTextField: UITextField!
	
	var userInitials:String!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	@IBAction func submitButtonWasPressed(sender: AnyObject) {
		if self.initalsTextField.hasText(){
			self.userInitials = self.initalsTextField.text
		
		}
	}
	
	

}
