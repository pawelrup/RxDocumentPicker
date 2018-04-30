//
//  ViewController.swift
//  RxDocumentPicker
//
//  Created by pawelrup on 04/30/2018.
//  Copyright (c) 2018 pawelrup. All rights reserved.
//

import UIKit
import MobileCoreServices
import RxSwift
import RxCocoa
import RxDocumentPicker

class ViewController: UIViewController {
	
	let disposeBag = DisposeBag()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let font = UIFont.systemFont(ofSize: 10, weight: .medium)
		print(font.fontName, font.familyName)
	}
	
	@IBAction private func documentMenuAction() {
		if #available(iOS 11.0, *) {
			print("UIDocumentMenuViewController is deprecated. Use UIDocumentPickerViewController directly.")
		} else {
			let menu = UIDocumentMenuViewController(documentTypes: [kUTTypePDF as String], in: .import)
			menu.rx
				.didPickDocumentPicker
				.do(onNext: { [weak self] (picker: UIDocumentPickerViewController) in
					self?.present(picker, animated: true, completion: nil)
				})
				.flatMap { $0.rx.didPickDocumentAt }
				.subscribe(onNext: {
					print($0)
				})
				.disposed(by: disposeBag)
			present(menu, animated: true, completion: nil)
		}
	}
	
	@IBAction private func documentPickerAction() {
		
		let picker = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String], in: .import)
		picker.rx
			.documentPickerWasCancelled
			.subscribe(onNext: {
				print($0)
			})
			.disposed(by: disposeBag)
		if #available(iOS 11.0, *) {
			picker.rx
				.didPickDocumentsAt
				.subscribe(onNext: { [weak self] (urls: [URL]) in
					print(urls)
					let img = self?.drawPDFfromURL(url: urls.first!)
					self?.performSegue(withIdentifier: "preview", sender: img)
				})
				.disposed(by: disposeBag)
		} else {
			picker.rx
				.didPickDocumentAt
				.subscribe(onNext: { [weak self] (url: URL) in
					print(url)
					let img = self?.drawPDFfromURL(url: url)
					self?.performSegue(withIdentifier: "preview", sender: img)
				})
				.disposed(by: disposeBag)
		}
		present(picker, animated: true, completion: nil)
	}
	
	func drawPDFfromURL(url: URL) -> UIImage? {
		guard let document = CGPDFDocument(url as CFURL) else { return nil }
		guard let page = document.page(at: 1) else { return nil }
		
		let pageRect = page.getBoxRect(.mediaBox)
		let renderer = UIGraphicsImageRenderer(size: pageRect.size)
		let img = renderer.image { ctx in
			UIColor.white.set()
			ctx.fill(pageRect)
			
			ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
			ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
			
			ctx.cgContext.drawPDFPage(page)
		}
		
		return img
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "preview", let controller = segue.destination as? PreviewViewController, let image = sender as? UIImage {
			controller.image = image
		}
	}
}
