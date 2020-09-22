Pod::Spec.new do |s|

  s.name               = "MACoolLoaderFramework"
  s.version            = "1.0.0"
  s.summary            = "MACoolLoaderFramework is a light-weight, easy to use library providing custom loading indicators."
  s.description        = "From six types of loaders, users can choose any one for any particular view and customize the loader colors accordingly to appear nicely on their views."
  s.homepage           = "https://github.com/natashamalam/MACoolLoaderFramework"
  s.license            = "MIT"
  s.swift_version      = "5.0"
  s.author             = { "Mahjabin Alam" => "natasha.mahjabin@gmail.com" }
  s.platform           = :ios, "11.0"
  s.source       = { :git => "https://github.com/natashamalam/MACoolLoaderFramework.git", :tag => "1.0.0" }
  s.source_files  = "MACoolLoaderFramework/**/*{.swift,.h,.m}"
  s.exclude_files = "MACoolLoaderFramework/**/*.plist"

end
