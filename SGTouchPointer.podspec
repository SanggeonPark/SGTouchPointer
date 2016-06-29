Pod::Spec.new do |s|
  s.name         = "SGTouchPointer"
  s.version      = "0.1.5"
  s.summary      = "iOS Touch point presenter with AirPlay"
  s.homepage     = "https://github.com/SanggeonPark/SGTouchPointer"

  s.source       = { :git => 'https://github.com/SanggeonPark/SGTouchPointer.git', :tag => s.version.to_s }
  s.authors      = { "Sanggeon Park" => "gunnih@gmail.com" }

  s.ios.deployment_target = '6.0'
  
  s.requires_arc = true 

  s.license	 = { :type => 'BSD-new', :file => 'LICENSE.txt' }

  s.source_files  = 'SGTouchPointerSource/*.{h,m}'

  s.public_header_files = 'SGTouchPointerSource/*.h'
  
end
