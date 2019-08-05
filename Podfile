# Uncomment the next line to define a global platform for your project

target 'SwiftyEventBus' do
  platform :ios, '8.0'
  use_frameworks!
end

target 'SwiftyEventBusTests' do
  platform :ios, '8.0'
  use_frameworks!
  pod 'Quick'
  pod 'Nimble'
  pod 'SwiftyEventBus', :path=>'./'
  pod 'SwiftyEventBusRx', :path=>'./'
end

target 'SwiftyEventBus-watchOS' do
  platform :watchos, '4.3'
  use_frameworks!
  pod 'SwiftyEventBus', :path=>'./'
  pod 'SwiftyEventBusRx', :path=>'./'
end

target 'SwiftyEventBus-macOS' do
    platform :osx, '10.10'
    use_frameworks!
    pod 'SwiftyEventBus', :path=>'./'
    pod 'SwiftyEventBusRx', :path=>'./'
end

target 'SwiftyEventBus-macOSTests' do
  platform :osx, '10.10'
  use_frameworks!
  pod 'SwiftyEventBus', :path=>'./'
  pod 'SwiftyEventBusRx', :path=>'./'
  pod 'Quick'
  pod 'Nimble'
end

target 'SwiftyEventBus-tvOS' do
    platform :tvos, '9.0'
    use_frameworks!
end

target 'SwiftyEventBus-tvOSTests' do
  platform :tvos, '9.0'
  use_frameworks!
  pod 'SwiftyEventBus', :path=>'./'
  pod 'SwiftyEventBusRx', :path=>'./'
  pod 'Quick'
  pod 'Nimble'
end
