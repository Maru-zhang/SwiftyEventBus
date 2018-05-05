#
# Be sure to run `pod lib lint SwiftyEventBus.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftyEventBus'
  s.version          = '0.1.0'
  s.summary          = 'A short description of SwiftyEventBus.'
  s.homepage         = 'https://github.com/Maru-zhang/SwiftyEventBus'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Maru-zhang' => 'zhangbinhui@souche.com' }
  s.source           = { :git => 'https://github.com/Maru-zhang/SwiftyEventBus.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'

  s.subspec 'Core' do |ss|
    ss.source_files = 'SwiftyEventBus/Core/**/*.swift'
ss.dependency 'RxSwift'
  end

  s.subspec 'Rx' do |ss|
    ss.source_files = 'SwiftyEventBus/Rx/**/*.swift'
    ss.dependency 'RxSwift'
  end
end
