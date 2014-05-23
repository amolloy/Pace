Pod::Spec.new do |s|
  s.name         = "enios"
  s.version      = "0.0.1"
  s.summary      = "Updated iOS wrapper for EN API"
  s.homepage     = "https://github.com/echonest/enios"
  s.license      = "MIT (example)"
  s.author             = { "The Echo Nest" => "contact@echonest.com" }

  s.source       = { :git => "https://github.com/echonest/enios.git", :commit => "2a47ee19c34d9c5e4f473af45470fa4a3bf47b32" }

  s.source_files  = "ENAPILibrary/ENAPILibrary/*.{h,m}"
  s.public_header_files = "ENAPILibrary/ENAPILibrary/*.h"

  s.requires_arc = true
end
