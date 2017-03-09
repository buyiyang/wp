 //
//  AppDelegate.swift
//  viossvc
//
//  Created by yaowang on 2016/10/29.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
//import XCGLogger
import SVProgressHUD
import Fabric
import Crashlytics
import Alamofire
import DKNightVersion
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, GeTuiSdkDelegate, WXApiDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        //URL types
        
        appearance()
        window?.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: "main")
        wechat()
      
        AppDataHelper.instance().initData()
        AppServerHelper.instance().initServer()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        YD_CountDownHelper.shared.pause()
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.EnterBackground), object: nil, userInfo: nil)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        YD_CountDownHelper.shared.reStart()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
   
    

    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var token = deviceToken.description
        token = token.replacingOccurrences(of: " ", with: "")
        token = token.replacingOccurrences(of: "<", with: "")
        token = token.replacingOccurrences(of: ">", with: "")
        
//        XCGLogger.debug("\(token)")
#if true
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: { () in
            GeTuiSdk.registerDeviceToken(token)
        })
#endif
       
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        WXApi.handleOpen(url, delegate: self)
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    
        
        let urlString = url.absoluteString
        if urlString.hasPrefix("com.newxfin.goods") {
            
           UPPaymentControl.default().handlePaymentResult(url, complete: { (code, data) in
                 let str : String = "\(code!)"
            //校验签名
//            let strdata = try? JSONSerialization.data(withJSONObject: data!, options: [])
//             let signdata = String(data:strdata!, encoding: String.Encoding.utf8)
            
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.UnionPay.UnionErrorCode), object: str, userInfo:nil)
        
            })
            
        }else{
             WXApi.handleOpen(url, delegate: self)
        }
     
       
        return true
    }
    func verify(sign : String) -> Bool {
        return false
    }
  
    fileprivate func appearance() {
        let navigationBar:UINavigationBar = UINavigationBar.appearance() as UINavigationBar;
        navigationBar.shadowImage = UIImage.init(named: "nav_clear")
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white];
        navigationBar.isTranslucent = false;
        navigationBar.tintColor = UIColor.white;
        navigationBar.setBackgroundImage(UIImage.init(named: "nav_main"), for: .any, barMetrics: .default)
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for:.default);
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent;
        UITableView.appearance().backgroundColor = AppConst.Color.C6;
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.setMinimumDismissTimeInterval(2)
    }
   
   
    
    //MARK: --Wechat
    fileprivate func wechat() {
        WXApi.registerApp("wx9dc39aec13ee3158")
    }
    func onResp(_ resp: BaseResp!) {
        //微信登录返回
        if resp.isKind(of: SendAuthResp.classForCoder()) {
            let authResp:SendAuthResp = resp as! SendAuthResp
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.WechatKey.ErrorCode), object: NSNumber.init(value: resp.errCode), userInfo:nil)
            if authResp.errCode == 0{
                let param = [SocketConst.Key.appid : AppConst.WechatKey.Appid,
                             SocketConst.Key.code : authResp.code,
                             SocketConst.Key.secret : AppConst.WechatKey.Secret,
                             SocketConst.Key.grant_type : "authorization_code"]
                Alamofire.request(AppConst.WechatKey.AccessTokenUrl, method: .get, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (result) in
                })
            }
            return
        }

        // 支付返回
        if resp.isKind(of: PayResp.classForCoder()) {
            let authResp:PayResp = resp as! PayResp
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.WechatPay.WechatKeyErrorCode), object: NSNumber.init(value: authResp.errCode), userInfo:nil)

            return
        }

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.window?.endEditing(true)
    }
   
    func tint(color: UIColor, blendMode: CGBlendMode,image: UIImage) -> UIImage
    {
        //(0.0, 0.0,image.size.width , image.size.height)
        let drawRect = CGRect.init(x: 0, y: -20, width: image.size.width, height: image.size.height+20)
        UIGraphicsBeginImageContextWithOptions(image.size, false, 1)
        color.setFill()
        UIRectFill(drawRect)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
    
    
   
}


