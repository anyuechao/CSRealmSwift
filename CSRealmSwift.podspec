Pod::Spec.new do |s|
s.name = "CSRealmSwift"
s.authors = "anyuechao"
s.homepage = "https://github.com/anyuechao/CSRealmSwift.git"
s.summary = "CSRealmSwift"
s.version = "1.0.0"
#s.platform = :ios, "8.0"
s.source = { :git => "https://github.com/anyuechao/CSRealmSwift.git", :tag => s.version }

s.dependency 'RealmSwift'
s.dependency 'Moya', '~> 12.0.1'
s.dependency 'ObjectMapper'

s.requires_arc     = true
s.ios.deployment_target = '8.0'
s.source_files = 'YCValue/Source/**/*.{swift}'

end
