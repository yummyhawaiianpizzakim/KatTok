# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'KatTok' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for KatTok
  pod 'SnapKit'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Swinject'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
  pod 'FirebaseFirestoreSwift'
  pod 'GoogleSignIn'

post_install do |installer|
         installer.generated_projects.each do |project|
               project.targets.each do |target|
                   target.build_configurations.each do |config|
                       config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
                    end
               end
        end
     end


  target 'KatTokTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'KatTokUITests' do
    # Pods for testing
  end

end
