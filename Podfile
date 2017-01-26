source 'https://gitlab.belgrade.maxeler.com/ios/Specs.git'
source 'https://github.com/CocoaPods/Specs.git'

# enable transitive dependencies that include static binaries
pre_install do |installer|
    # workaround for https://github.com/CocoaPods/CocoaPods/issues/3289
    def installer.verify_no_static_framework_transitive_dependencies; end
end

platform :ios, '8.0'
use_frameworks!

target ‘backgamon’ do
    # Internal pods
    pod 'MaxelerComponents'
end

# Add GoogleMobileAds where necessary
post_install do |installer|
    project = installer.pods_project
    
    installer.aggregate_targets.each do |target|
        project.build_configurations.each do |build_configuration|
            configFilePath = target.xcconfig_path(build_configuration.name)
            configFile = File.read(configFilePath)
            configFile = configFile.gsub(/-framework "GoogleMobileAds" /, '')
            File.open(configFilePath, 'w') { |file| file << configFile }
        end
    end
end
