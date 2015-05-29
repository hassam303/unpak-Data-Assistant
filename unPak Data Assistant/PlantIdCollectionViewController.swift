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
	var passedMetaData:DBMetadata!
	var plantIdArray:Array<String> = ["hello","world"]

	
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
		
		cell.cellLabel.text = self.plantIdArray[iP.row]
		
		return cell
	}
	
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.plantIdArray.count
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
		return UIEdgeInsetsMake(5, 5, 5, 5)
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		return CGSizeMake(50, 50)
	}
	
	
	
	
}
