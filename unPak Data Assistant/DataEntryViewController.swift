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

	override func viewDidLoad() {
		super.viewDidLoad()
		print(self.formService.description())
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

}
