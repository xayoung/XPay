
Pod::Spec.new do |s|
  s.name         = "XPay"
  s.version      = "0.0.4"
  s.summary      = "XPay is a AliPay & WxPay & UnionPay frameworks"

  s.description  = <<-DESC
                    XPay is a AliPay & WxPay & UnionPay frameworks
                   DESC

  s.homepage     = "https://github.com/xayoung/Xpay"
  s.license      = "MITexample"
  s.author       = { "xayoung" => "xayoung@hotmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/xayoung/XPay.git", :tag => "#{s.version}" }
  s.requires_arc = true
  s.default_subspecs = 'Base', 'AliPay', 'WxPay','UnionPay'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-lObjC','ENABLE_BITCODE' => 'NO'}

  s.subspec 'Base' do |base|
    base.source_files = 'lib/*.{h,m}'
    base.public_header_files = 'lib/*.h'
    base.vendored_libraries = 'lib/*.a'
    base.frameworks = 'UIKit','Foundation', 'CoreGraphics','CoreText','QuartzCore','CoreTelephony','SystemConfiguration','CoreMotion','CFNetwork'
    base.libraries = 'c++', 'stdc++', 'z','sqlite3.0'
  end

  s.subspec 'AliPay' do |alipay|
    alipay.vendored_libraries = 'lib/AliPay/*.a'
    alipay.source_files = 'lib/AliPay/*.{h,m}'
    alipay.ios.vendored_frameworks = 'lib/AliPay/AlipaySDK.framework'
    alipay.resource = 'lib/AliPay/AlipaySDK.bundle'
    alipay.dependency 'XPay/Base'
  end

  s.subspec 'WxPay' do |wx|
    wx.vendored_libraries = 'lib/WxPay/*.a'
    wx.source_files = 'lib/WxPay/*.{h,m}'
    wx.public_header_files = 'lib/WxPay/*.h'
    wx.source_files = 'lib/WxPay/*.h'
    wx.ios.library = 'sqlite3'
    wx.dependency 'XPay/Base'
  end

  s.subspec 'UnionPay' do |unionpay|
    unionpay.vendored_libraries = 'lib/UnionPay/*.a'
    unionpay.source_files = 'lib/UnionPay/*.{h,m}'
    unionpay.public_header_files = 'lib/UnionPay/*.h'
    unionpay.source_files = 'lib/Channels/UnionPay/*.h'
    unionpay.dependency 'XPay/Base'
  end

end
