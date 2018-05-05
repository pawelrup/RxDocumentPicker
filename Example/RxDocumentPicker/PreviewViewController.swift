//
//  PreviewViewController.swift
//  RxDocumentPicker_Example
//
//  Created by Pawel Rup on 30.04.2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
	
	@IBOutlet private weak var imageView: UIImageView!
	
	var image: UIImage?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		imageView.image = image
	}
}
