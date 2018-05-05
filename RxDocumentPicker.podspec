#
# Be sure to run `pod lib lint RxDocumentPicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxDocumentPicker'
  s.version          = '0.1.1'
  s.summary          = 'Reactive extension for UIDocumentMenuViewController and UIDocumentPickerViewController.'

  s.description      = <<-DESC
  RxDocumentPicker is an RxSwift reactive extension for UIDocumentMenuViewController and UIDocumentPickerViewController.
  Requires Xcode 9.3 with Swift 4.1.
                       DESC

  s.homepage         = 'https://github.com/pawelrup/RxDocumentPicker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Paweł Rup' => 'pawelrup@lobocode.pl' }
  s.source           = { :git => 'https://github.com/pawelrup/RxDocumentPicker.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  
  s.swift_version = '4.1'

  s.source_files = 'RxDocumentPicker/Classes/**/*'
  s.pod_target_xcconfig =  {
	  'SWIFT_VERSION' => '4.1',
  }
  
  s.frameworks = 'UIKit'
  s.dependency 'RxSwift', '~> 4.1.2'
  s.dependency 'RxCocoa', '~> 4.1.2'
end
