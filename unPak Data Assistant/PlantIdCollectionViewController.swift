//
//  PlantIdCollectionViewController.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 5/22/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit

class PlantIdCollectionViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
	
	var numberOfItemsInRow:Int = 4
	var numberOfRows:Int = 8
	
	var csvHeadersArray: [String] = []
	var csvplantIdArray:Array<String> = []
	var csvRowsDataArray: [Dictionary<String, String>]!

	
	@IBOutlet weak var collectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView.dataSource = self
		
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let iP:NSIndexPath = indexPath
		
		let cell:PlantIdCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("plantIdCell", forIndexPath: iP) as! PlantIdCollectionViewCell
		
		
		
		cell.cellLabel.text = self.csvplantIdArray[iP.row]
		
		return cell
	}
	
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.csvplantIdArray.count
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
		return UIEdgeInsetsMake(1, 1, 1, 1)
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		return CGSizeMake(50, 50)
	}
	
	
	
	
}
