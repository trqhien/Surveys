platform :ios, '10.0'

target 'Surveys' do
  use_frameworks!

  pod 'Codextended', :git => 'https://github.com/JohnSundell/Codextended.git', :tag => '0.3.0'
  pod 'TinyConstraints'
  pod 'Kingfisher', '~> 5.0'

  plugin 'cocoapods-keys', {
    :project => "Surveys",
    :keys => [
      "accessToken",
    ]}
end
