platform :ios, '8.0'
use_frameworks!

def shared_pods
    pod 'PureLayout'
    pod 'DZNEmptyDataSet'
    pod 'IQKeyboardManagerSwift'
    pod 'M13Checkbox'
    pod 'Firebase'
    pod 'Firebase/Database'
    pod 'Firebase/Storage'
    pod 'SwiftOverlays'
    pod 'SDWebImage'
    pod 'ActiveLabel'
    pod 'DownPicker'
    pod 'KMPlaceholderTextView'
    pod 'GooglePlaces'
    pod 'GooglePlacePicker'
    pod 'GoogleMaps'
    pod 'TSMessages'
end

target 'Skypass' do
    shared_pods
end

target 'SkypassAdmin' do
    shared_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
