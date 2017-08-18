Pod::Spec.new do |s|
  s.name         = "HNBKit"
  s.version      = "0.0.8"
  s.summary      = "A kit for obect-c"
  s.homepage     = "https://github.com/ByronChengChen/HNBKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "chengkang" => "chengkang_boy@163.com" }
  s.source       = { :git => "https://github.com/ByronChengChen/HNBKit.git", :tag => "0.0.8" }
  s.platform     = :ios, '8.0'
  s.source_files  = "HNBKit", "HNBKit/**/*"
  s.dependency 'Masonry', '1.0.2'
  s.dependency 'MJRefresh', '3.1.12'
  s.dependency 'MJExtension', '3.0.13'
end
