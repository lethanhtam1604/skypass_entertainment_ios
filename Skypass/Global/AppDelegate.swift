//
//  AppDelegate.swift
//  Maxi Unlock
//
//  Created by Luu Nguyen on 10/28/16.
//  Copyright © 2016 Lavamy. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // map
        
        GMSPlacesClient.provideAPIKey(Global.mapKey)
        
        // firebase
        
        var fileName = "GoogleService-Info-User"
        #if Admin
            fileName = "GoogleService-Info-Admin"
        #endif
        
        let filePath = Bundle.main.path(forResource: fileName, ofType: "plist")!
        let options = FIROptions(contentsOfFile: filePath)!
        FIRApp.configure(with: options)
        
        // keyboard
        
        let keyboardManager = IQKeyboardManager.sharedManager()
        keyboardManager.enable = true
        // keyboardManager.previousNextDisplayMode = .alwaysHide
        
        // navigation
        
        let appearance = UINavigationBar.appearance()
        appearance.barStyle = .black
        appearance.barTintColor = Global.colorPrimary
        appearance.tintColor = Global.colorBg
        appearance.isTranslucent = false
        appearance.shadowImage = UIImage()
        appearance.setBackgroundImage(UIImage(named: "navBar.png"), for: .default)
        appearance.titleTextAttributes = [NSFontAttributeName: Global.semiboldFont(ip6(34))]
        let backButtonImage = UIImage(named: "back.png")!.resize(CGSize(20,20)).withAlignmentRectInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        appearance.backIndicatorImage = backButtonImage
        appearance.backIndicatorTransitionMaskImage = backButtonImage
        
        let barAppearance = UIBarButtonItem.appearance()
        barAppearance.setTitleTextAttributes([NSFontAttributeName: Global.semiboldFont(ip6(34))], for: .normal)
        barAppearance.tintColor = UIColor.black

        // create new window
        
        let nav = UINavigationController(rootViewController: MainViewController())
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("Font Names = [\(names)]")
        }
    }
}
