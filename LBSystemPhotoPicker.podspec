Pod::Spec.new do |spec|
  spec.name         = "LBSystemPhotoPicker"
  spec.version      = "0.0.1"
  spec.summary      = "集成系统的调用相册和相机，以ActionSheet弹框选择方式。"
  spec.description  = "集成系统的调用相册和相机，几句代码集成，方便快捷，以ActionSheet弹框选择方式。"
  spec.homepage     = "https://github.com/A1129434577/LBSystemPhotoPicker"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "刘彬" => "1129434577@qq.com" }
  spec.platform     = :ios
  spec.ios.deployment_target = '8.0'
  spec.source       = { :git => 'https://github.com/A1129434577/LBSystemPhotoPicker.git', :tag => spec.version.to_s }
  spec.source_files = "LBSystemPhotoPicker/**/*.{h,m}"
  spec.requires_arc = true
end
