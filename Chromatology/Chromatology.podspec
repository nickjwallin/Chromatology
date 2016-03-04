Pod::Spec.new do |s|
  s.name     = 'Chromatology'
  s.version  = '0.0.1'
  s.license  = 'MIT'
  s.platform = :ios, '8.0'
  s.homepage = 'https://github.com/nickjwallin/Chromatology'
  s.summary  = 'A UIColor category providing an intuitive way to mix colors'
  s.authors  = { 'Nick Wallin' => 'nickjwallin@gmail.com',
                 'Carl Benson' => 'carl@carldbenson.com' }
  s.source   = { :git => 'https://github.com/nickjwallin/Chromatology.git',
                 :tag => s.version.to_s }
  s.source_files = 'Chromatology/*.{h,m}'
  s.public_header_files = 'Chromatology/*.h'
  s.requires_arc = true
end
