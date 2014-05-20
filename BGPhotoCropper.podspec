Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name         = "BGPhotoCropper"
  s.version      = "0.0.2"
  s.summary      = "Fresher BGPhotoCropper made with love in Ludwigshafen."

  s.description  = <<-DESC
                   BGPhotoCropper: An iOS PhotoCropper we are using in our Stocard-iOS App.

                   * Small & lightweight
                   DESC

  s.homepage     = "http://www.stocard.de"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license      = { :type => "MIT", :file => "LICENSE" }

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.author             = { "Bjoern Goss" => "goss@stocard.de" }
  s.social_media_url   = "https://twitter.com/BjoernGoss"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.platform     = :ios, "7.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source       = { :git => "https://github.com/bgoss/BGPhotoCropper.git", :tag => "0.0.2" }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source_files  = "BGPhotoCropper", "BGPhotoCropper/**/*.{h,m}"
  # s.exclude_files = "Classes/Exclude"
  s.public_header_files = "BGPhotoCropper/**/*.h"

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.requires_arc = true

end
