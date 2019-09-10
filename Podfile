platform :ios, '10.0'

def codable_extended_pod
  pod 'Codextended', :git => 'https://github.com/JohnSundell/Codextended.git', :tag => '0.3.0'
end

target 'Surveys' do
  use_frameworks!

  pod 'TinyConstraints'
  pod 'Kingfisher', '~> 5.0'
  pod 'SwiftKeychainWrapper'
  codable_extended_pod

  plugin 'cocoapods-keys', {
    :project => "Surveys",
    :keys => [
      "username",
      "password",
      "baseURL"
    ]}
end

target 'SurveysTests' do
  codable_extended_pod
end
