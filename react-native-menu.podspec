require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-menu"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]
  s.source       = { :git => "https://github.com/react-native-menu/menu.git", :tag => "#{s.version}" }

  s.ios.deployment_target = "9.0"
  s.ios.source_files = "ios/**/*.{h,m,mm,swift}"

  s.osx.deployment_target = "10.14"
  s.osx.source_files = "macos/**/*.{h,m,mm,swift}"
  
  s.dependency "React"
end
