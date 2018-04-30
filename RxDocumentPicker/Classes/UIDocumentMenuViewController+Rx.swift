//
//  UIDocumentMenuViewController+Rx.swift
//  RxDocumentPicker
//
//  Created by Pawel Rup on 28.04.2018.
//  Copyright © 2018 Pawel Rup. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

@available(iOS, introduced: 8.0, deprecated: 11.0, message: "UIDocumentMenuViewController is deprecated. Use UIDocumentPickerViewController directly.")
extension UIDocumentMenuViewController: HasDelegate {
	public typealias Delegate = UIDocumentMenuDelegate
}

@available(iOS, introduced: 8.0, deprecated: 11.0, message: "UIDocumentMenuViewController is deprecated. Use UIDocumentPickerViewController directly.")
private class RxUIDocumentMenuDelegateProxy: DelegateProxy<UIDocumentMenuViewController, UIDocumentMenuDelegate>, DelegateProxyType, UIDocumentMenuDelegate {
	
	public weak private (set) var controller: UIDocumentMenuViewController?
	
	let didPickDocumentPickerSubject = PublishSubject<UIDocumentPickerViewController>()
	
	public init(controller: ParentObject) {
		self.controller = controller
		super.init(parentObject: controller, delegateProxy: RxUIDocumentMenuDelegateProxy.self)
	}
	
	static func registerKnownImplementations() {
		self.register { RxUIDocumentMenuDelegateProxy(controller: $0) }
	}
	
	func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
		didPickDocumentPickerSubject.onNext(documentPicker)
		forwardToDelegate()?.documentMenu(documentMenu, didPickDocumentPicker: documentPicker)
	}
}

@available(iOS, introduced: 8.0, deprecated: 11.0, message: "UIDocumentMenuViewController is deprecated. Use UIDocumentPickerViewController directly.")
extension Reactive where Base: UIDocumentMenuViewController {
	
	/// Delegate proxy for `UIDocumentMenuViewController`
	public var delegate: DelegateProxy<UIDocumentMenuViewController, UIDocumentMenuDelegate> {
		return RxUIDocumentMenuDelegateProxy.proxy(for: base)
	}
	
	/// Tells that the user has selected a document picker from the menu.
	@available(iOS 8.0, *)
	public var didPickDocumentPicker: Observable<UIDocumentPickerViewController> {
		let proxy = RxUIDocumentMenuDelegateProxy.proxy(for: base)
		return proxy.didPickDocumentPickerSubject
	}
	
	/// Tells that the user dismissed the document menu.
	@available(iOS 8.0, *)
	public var documentMenuWasCancelled: Observable<()> {
		return delegate.methodInvoked(#selector(UIDocumentMenuDelegate.documentMenuWasCancelled(_:)))
			.map { _ in () }
	}
}
