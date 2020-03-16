Pod::Spec.new do |spec|
  spec.name         = "PureSwiftUITools"
  spec.version      = "1.2.0"
  spec.summary      = "PureSwiftUITools is a companion package to PureSwiftUI which is designed to provide useful implementation of various concepts written for SwiftUI."
  spec.description  = <<-DESC
Since SwiftUI is still relatively new, there are many use-cases that are not addressed either directly by Apple or by the community in general. PureSwiftUITools is a way of formulating various ideas into tools which can be used directly in projects, or used as a basis for learning, extending for bespoke purposes, or as a foundation for building a more robust approach. I see this package as a educational platform as much as anything else. As various utilities are introduced they will be accompanied by appropriate demos and gists that demonstrate usage.
                   DESC
  spec.homepage     = "https://github.com/CodeSlicing/pure-swift-ui-tools"
  spec.license      = { :type => "MIT", :file => "Assets/Docs/LICENCE.md" }
  spec.author             = "Adam Fordyce"
  spec.social_media_url   = "https://twitter.com/CodeSlice"
  
  spec.ios.deployment_target = "13.0"
  
  spec.source = { :git => "https://github.com/CodeSlicing/pure-swift-ui-tools.git", :tag => "#{spec.version}" }

  spec.source_files  = "Sources/**/*.{swift}"
  spec.swift_version = "5.1"
  spec.framework  = "SwiftUI"
  spec.dependency 'PureSwiftUI', :git => 'https://github.com/Brett-Best/pure-swift-ui.git', :branch => 'develop'
end
