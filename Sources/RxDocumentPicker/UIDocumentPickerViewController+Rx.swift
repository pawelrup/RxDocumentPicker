//
//  UIDocumentPickerViewController+Rx.swift
//  RxDocumentPicker
//
//  Created by Pawel Rup on 28.04.2018.
//  Copyright © 2018 Pawel Rup. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UIDocumentPickerViewController: HasDelegate {
	public typealias Delegate = UIDocumentPickerDelegate
}

private class RxUIDocumentPickerDelegateProxy: DelegateProxy<UIDocumentPickerViewController, UIDocumentPickerDelegate>, DelegateProxyType, UIDocumentPickerDelegate {
	
	public weak private (set) var controller: UIDocumentPickerViewController?
	
	public init(controller: ParentObject) {
		self.controller = controller
		super.init(parentObject: controller, delegateProxy: RxUIDocumentPickerDelegateProxy.self)
	}
	
	static func registerKnownImplementations() {
		register { RxUIDocumentPickerDelegateProxy(controller: $0) }
	}
}

extension Reactive where Base: UIDocumentPickerViewController {
	
	/// Delegate proxy for `UIDocumentPickerViewController`
	public var delegate: DelegateProxy<UIDocumentPickerViewController, UIDocumentPickerDelegate> {
		RxUIDocumentPickerDelegateProxy.proxy(for: base)
	}
	
	/// Tells that user has selected one or more documents.
	@available(iOS 11.0, *)
	public var didPickDocumentsAt: Observable<[URL]> {
		delegate
			.methodInvoked(#selector(UIDocumentPickerDelegate.documentPicker(_:didPickDocumentsAt:)))
			.compactMap { $0.last as? [URL] }
	}
	
	/// Tells that user canceled the document picker.
	public var documentPickerWasCancelled: Observable<()> {
		delegate
			.methodInvoked(#selector(UIDocumentPickerDelegate.documentPickerWasCancelled(_:)))
			.map {_ in () }
	}
	
	/// Tells that user has selected a document or a destination.
	@available(iOS, introduced: 8.0, deprecated: 11.0, message: "Implement documentPicker:didPickDocumentsAtURLs: instead")
	public var didPickDocumentAt: Observable<URL> {
		delegate
			.methodInvoked(#selector(UIDocumentPickerDelegate.documentPicker(_:didPickDocumentAt:)))
			.compactMap { $0.last as? URL }
	}
}
