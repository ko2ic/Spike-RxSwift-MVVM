def shared_all
    pod 'SwiftLint'
end
def shared_ui
	pod 'RKNotificationHub'
	pod 'Google/Analytics'    
	pod 'GoogleIDFASupport'
	pod 'Fabric'
	pod 'Crashlytics'
end

def shared_domains
    pod 'SwiftyBeaver'
end

abstract_target 'All' do
    platform :ios, '11.0'
    use_frameworks!

    # UI層
    target 'Spike-RxSwift-MVVM' do
        shared_all
        shared_ui
    end

    target 'Domains' do
        shared_all
        shared_domains
        target 'DomainsTests' do
             inherit! :search_paths
        end
    end

    target 'Infrastructures' do
        shared_all
        target 'InfrastructuresTests' do
             inherit! :search_paths
        end
    end

    target 'Spike-RxSwift-MVVMTests' do
        inherit! :search_paths
        # Pods for testing
        shared_all
        shared_ui
    end

    target 'Spike-RxSwift-MVVMUITests' do
        inherit! :search_paths
        # Pods for testing
    end
end

post_install do |installer|
    puts("Update debug pod settings to speed up build time")
    Dir.glob(File.join("Pods", "**", "Pods*{debug,Private}.xcconfig")).each do |file|
        File.open(file, 'a') { |f| f.puts "\nDEBUG_INFORMATION_FORMAT = dwarf" }
    end
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
            config.build_settings['ENABLE_BITCODE'] = 'NO'
            cflags = config.build_settings['OTHER_CFLAGS'] || ['$(inherited)']
            cflags << '-fembed-bitcode'
            config.build_settings['OTHER_CFLAGS'] = cflags
            #config.build_settings['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
        end
    end
end
