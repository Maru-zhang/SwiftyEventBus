# Uncomment the next line to define a global platform for your project

target 'SwiftyEventBus' do
  platform :ios, '8.0'
  use_frameworks!
  pod 'RxSwift'
  target 'SwiftyEventBusTests' do
    inherit! :search_paths
    pod 'Quick'
    pod 'Nimble'
  end
end

target 'SwiftyEventBus-watchOS' do
    use_frameworks!
    pod 'RxSwift'
end

target 'SwiftyEventBus-macOS' do
    platform :osx, '10.10'
    use_frameworks!
    pod 'RxSwift'
    target 'SwiftyEventBus-macOSTests' do
        inherit! :search_paths
        pod 'Quick'
        pod 'Nimble'
    end
end

target 'SwiftyEventBus-tvOS' do
    platform :tvos, '9.0'
    use_frameworks!
    pod 'RxSwift'
    target 'SwiftyEventBus-tvOSTests' do
        inherit! :search_paths
        pod 'Quick'
        pod 'Nimble'
    end
end
