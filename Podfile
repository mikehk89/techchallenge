#Specs
source 'https://github.com/CocoaPods/Specs.git'

def sharedpods
  pod 'Alamofire'
end

target 'TechChallenge' do
  use_frameworks!
  platform :ios, '10.0'

  sharedpods

  #Unit Test Target
  target 'TechChallengeTests' do
    use_frameworks!
    inherit! :search_paths
    sharedpods
  end

  #UI Test Target
    target 'TechChallengeUITests' do
    use_frameworks!
    inherit! :search_paths
    sharedpods
  end

end
