Pod::Spec.new do |s|
  s.name         = "UIAlertView-Blocks"
  s.version      = "0.0.1"
  s.summary      = "A category for UIAlertView which allows you to use blocks to handle the pressed button events rather than implementing a delegate."
  s.homepage     = "https://github.com/SlaunchaMan/UIAlertView-Blocks"
  s.license      = 'MIT'
  s.authors      = { "Jeff Kelley" => "SlaunchaMan@gmail.com", "Jiva DeVoe" => "info@random-ideas.net" }
  s.source       = { :git => "https://github.com/SlaunchaMan/UIAlertView-Blocks.git", :commit => "814db348b919220e2d49796ce778c02dd27f9460" }
  s.platform     = :ios
  s.source_files = '*.{h,m}'
  s.frameworks   = 'UIKit', 'Foundation'
  s.requires_arc = true
end
