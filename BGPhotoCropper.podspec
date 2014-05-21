Pod::Spec.new do |s|
  s.name                = "BGPhotoCropper"
  s.version             = "0.0.3"
  s.summary             = "Fresher BGPhotoCropper made with love in Ludwigshafen."
  s.homepage            = "http://www.stocard.de"
  s.license             = { :type => "MIT", :file => "LICENSE" }
  s.author              = { "Bjoern Goss" => "goss@stocard.de" }
  s.social_media_url    = "https://twitter.com/BjoernGoss"
  s.platform            = :ios, "7.0"
  s.source              = { :git => "https://github.com/bgoss/BGPhotoCropper.git", :tag => "0.0.3" }
  s.source_files        = "BGPhotoCropper/*.{h,m}"
  s.resources		= "BGPhotoCropper/*.storyboard"
  s.public_header_files = "BGPhotoCropper/**/*.h"
  s.requires_arc        = true
end
