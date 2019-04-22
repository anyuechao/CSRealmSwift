Pod::Spec.new do |s|
s.name = "CSRealmSwift"
s.authors = "anyuechao"
s.homepage = "https://github.com/anyuechao/CSRealmSwift.git"
s.summary = "CSRealmSwift"
s.version = "3.0.0"
#s.platform = :ios, "8.0"
s.source = { :git => "https://github.com/anyuechao/CSRealmSwift.git", :tag => s.version }

s.dependency 'RealmSwift'
s.dependency 'ObjectMapper'

s.requires_arc     = true
s.ios.deployment_target = '8.0'
s.source_files = 'CSRealmSwift/Source/**/*.{swift}'

end
