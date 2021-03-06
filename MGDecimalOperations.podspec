Pod::Spec.new do |s|
  s.name                  = 'MGDecimalOperations'
  s.version               = '1.0.0'
  s.summary               = 'Lightweight framework for decimal operations in Objective-C'
  s.homepage              = 'https://github.com/elpassion/MGDecimalOperations-iOS'
  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.author                = { 'Maciej Gomolka' => 'mgomolka92@gmail.com' }
  s.platform              = :ios
  s.ios.deployment_target = '8.0'
  s.source                = { :git => 'https://github.com/elpassion/MGDecimalOperations-iOS.git', :tag => s.version }
  s.source_files          = 'MGDecimalOperations/**/*{h,m}'
  s.private_header_files  = ['MGDecimalOperations/Converters/*.h', 'MGDecimalOperations/Factory/*.h', 'MGDecimalOperations/OperationObjects/*.h', 'MGDecimalOperations/Validators/*.h']
  s.requires_arc          = true
end
