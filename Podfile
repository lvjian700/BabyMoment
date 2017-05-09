source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target 'BabyMoment' do
  pod 'RealmSwift'
  pod 'DateToolsSwift'
  pod 'UIColor_Hex_Swift', '~> 3.0.2'
  pod 'IQKeyboardManagerSwift', '4.0.8'

  target "BabyMomentTests" do
    inherit! :search_paths

    pod 'Quick'
    pod 'Nimble'
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end

