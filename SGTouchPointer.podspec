Pod::Spec.new do |s|
  s.name         = "SGTouchPointer"
  s.version      = "0.1.0"
  s.summary      = "iOS Touch point presenter with AirPlay"
  s.homepage     = "https://github.com/SanggeonPark/SGTouchPointer"

  s.source       = { :git => 'https://github.com/SanggeonPark/SGTouchPointer.git', :tag => s.version.to_s }
  s.authors      = { "Sanggeon Park" => "gunnih@gmail.com" }

  s.ios.deployment_target = '7.1'
  
  s.requires_arc = true 

  s.license	 = { :type => 'BSD-new', :file => 'LICENSE.txt' }

  s.public_header_files = 'SGTouchPointerSource/*.h'

  s.default_subspecs = 'SGTouchPointerSource'

  s.subspec 'SGTouchPointerSource' do |sh|
    sh.source_files  = 'SGTouchPointerSource /*.{h,m}'
  end

end
