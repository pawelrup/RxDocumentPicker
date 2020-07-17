#
# Be sure to run `pod lib lint RxDocumentPicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxDocumentPicker'
  s.version          = '0.2.0'
  s.summary          = 'Reactive extension for UIDocumentMenuViewController and UIDocumentPickerViewController.'

  s.description      = <<-DESC
  RxDocumentPicker is an RxSwift reactive extension for UIDocumentMenuViewController and UIDocumentPickerViewController.
  Requires Xcode 12 with Swift 5.3.
                       DESC

  s.homepage         = 'https://github.com/pawelrup/RxDocumentPicker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Paweł Rup' => 'pawelrup@lobocode.pl' }
  s.source           = { :git => 'https://github.com/pawelrup/RxDocumentPicker.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.swift_version = '5.3'

  s.source_files = 'Sources/RxDocumentPicker/**/*'

  s.frameworks = 'UIKit'
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
end
