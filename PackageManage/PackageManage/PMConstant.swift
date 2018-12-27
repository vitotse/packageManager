//
//  PMConstant.swift
//  PackageManage
//
//  Created by vitotse88 on 2018/12/27.
//  Copyright © 2018 vitotse88. All rights reserved.
//

import Foundation

import UIKit

// MARK: 系统相关
/// Info
public let kAppBundleInfoVersion = Bundle.main.infoDictionary ?? Dictionary()
/// plist:  AppStore 使用VersionCode 1.0.1
public let kAppBundleVersion = (kAppBundleInfoVersion["CFBundleShortVersionString" as String] as? String ) ?? ""
/// plist: 例如 1
public let kAppBundleBuild = (kAppBundleInfoVersion["CFBundleVersion"] as? String ) ?? ""
public let kAppDisplayName = (kAppBundleInfoVersion["CFBundleDisplayName"] as? String ) ?? ""

// MARK: 系统相关
public let kSystemOS = UIDevice.current.systemVersion
public let kiOSBase = 9.0
public let kOSGreaterOrEqualToiOS8 = ( (Double(UIDevice.current.systemVersion) ?? kiOSBase) > 8.0 ) ? true : false;
public let kOSGreaterOrEqualToiOS9 = ((Double(UIDevice.current.systemVersion) ?? kiOSBase) >= 9.0 ) ? true : false;
public let kOSGreaterOrEqualToiOS10 = ((Double(UIDevice.current.systemVersion) ?? kiOSBase) >= 10.0 ) ? true : false;
public let kOSGreaterOrEqualToiOS11 = ((Double(UIDevice.current.systemVersion) ?? kiOSBase) >= 11.0 ) ? true : false;

//设备宽高、机型
public let kScreenHeight = UIScreen.main.bounds.size.height
public let kScreenWidth = UIScreen.main.bounds.size.width
public let kStatusBarheight = UIApplication.shared.statusBarFrame.size.height
public let kNavBarHeight_StatusHeight: ((UIViewController) -> CGFloat) = {(vc : UIViewController ) -> CGFloat in
    weak var weakVC = vc;
    var navHeight = weakVC?.navigationController?.navigationBar.bounds.size.height ?? 0.0
    return (navHeight + kStatusBarheight)
    
}

// MARK: ============================================================================
// MARK: 设置颜色
/// 设置颜色值
public let HexRGB:((Int) -> UIColor) = { (rgbValue : Int) -> UIColor in
    return HexRGBAlpha(rgbValue,1.0)
}

/// 通过 十六进制字符串来设置颜色值  （ 样式： "#ff00ff" ）
public let HexStringRGB:((String) -> UIColor) = { (colorStr : String) -> UIColor in
    var cString : String = colorStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString = (cString as NSString).substring(from: 1)
    }
    
    if (cString.count != 6) {
        return UIColor.black
    }
    
    let index2 = cString.index(cString.startIndex, offsetBy: 2)
    let index4 = cString.index(cString.startIndex, offsetBy: 4)
    let index6 = cString.index(cString.startIndex, offsetBy: 6)
    
    let rString = cString[cString.startIndex..<index2]
    let gString = cString[index2..<index4]
    let bString = cString[index4..<index6]
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    Scanner(string: String(rString)).scanHexInt32(&r)
    Scanner(string: String(gString)).scanHexInt32(&g)
    Scanner(string: String(bString)).scanHexInt32(&b)
    
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    
}


/// 通过 十六进制与alpha来设置颜色值  （ 样式： 0xff00ff ）
public let HexRGBAlpha:((Int,Float) -> UIColor) = { (rgbValue : Int, alpha : Float) -> UIColor in
    return UIColor(red: CGFloat(CGFloat((rgbValue & 0xFF0000) >> 16)/255), green: CGFloat(CGFloat((rgbValue & 0xFF00) >> 8)/255), blue: CGFloat(CGFloat(rgbValue & 0xFF)/255), alpha: CGFloat(alpha))
}


/// 通过 red 、 green 、blue 、alpha 颜色数值
public let RGBAlpa:((Float,Float,Float,Float) -> UIColor ) = { (r: Float, g: Float , b: Float , a: Float ) -> UIColor in
    return UIColor.init(red: CGFloat(CGFloat(r)/255.0), green: CGFloat(CGFloat(g)/255.0), blue: CGFloat(CGFloat(b)/255.0), alpha: CGFloat(a))
    
}

//計算執行代碼所耗時間，并打印
/**
 例子
 let useTime = SumPerformUseTime({ () in
 //需要執行的代碼
 })
 */
public let SumPerformUseTime:((() -> (Void)) -> CFAbsoluteTime) = { (funcBlock:(() -> (Void))) in
    let startTime = CFAbsoluteTimeGetCurrent()
    funcBlock()
    let endTime = CFAbsoluteTimeGetCurrent()
    let useTime = endTime - startTime;
    print("耗时: \(useTime)")
    return useTime
}
