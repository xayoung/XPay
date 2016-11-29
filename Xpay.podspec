
Pod::Spec.new do |s|
  s.name         = "XPay"
  s.version      = "0.0.1"
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
    alipay.vendored_libraries = 'lib/Channels/AliPay/*.a'
    alipay.source_files = 'lib/Channels/AliPay/*.{h,m}'
    alipay.ios.vendored_frameworks = 'lib/Channels/AliPay/AlipaySDK.framework'
    alipay.resource = 'lib/Channels/AliPay/AlipaySDK.bundle'
    alipay.dependency 'XPay/Base'
  end

  s.subspec 'WxPay' do |wx|
    wx.vendored_libraries = 'lib/Channels/WxPay/*.a'
    wx.source_files = 'lib/Channels/WxPay/*.{h,m}'
    wx.public_header_files = 'lib/Channels/WxPay/*.h'
    wx.source_files = 'lib/Channels/WxPay/*.h'
    wx.ios.library = 'sqlite3'
    wx.dependency 'XPay/Base'
  end

  s.subspec 'UnionPay' do |unionpay|
    unionpay.vendored_libraries = 'lib/Channels/UnionPay/*.a'
    unionpay.source_files = 'lib/Channels/UnionPay/*.{h,m}'
    unionpay.public_header_files = 'lib/Channels/UnionPay/*.h'
    unionpay.source_files = 'lib/Channels/UnionPay/*.h'
    unionpay.dependency 'XPay/Base'
  end

end
