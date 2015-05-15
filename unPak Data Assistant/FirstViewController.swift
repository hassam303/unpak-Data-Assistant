//
//  FirstViewController.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 5/15/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	@IBAction func signInWasPressed(sender: AnyObject) {
		
		   DBSession.sharedSession().linkFromController(self)
		
	}
	
	
	@IBAction func didRefresh(sender: AnyObject) {
		
		DBChooser.defaultChooser().openChooserForLinkType(DBChooserLinkTypePreview, fromViewController: self, completion: { (results: [AnyObject]!) -> Void in
			
			if !results.isEmpty {
				var dbResult:DBChooserResult = results [0] as! DBChooserResult
				
				println(dbResult.link)

			}
			
			else {
				// User canceled the action
			}
		})
	
		
		
		
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

