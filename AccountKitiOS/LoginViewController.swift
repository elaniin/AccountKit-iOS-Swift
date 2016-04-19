//
//  LoginViewController.swift
//  AccountKitiOS
//
//  Created by Adrian Gomez on 4/18/16.
//  Copyright © 2016 Elaniin Digital. All rights reserved.
//

import AccountKit

class LoginViewController: UIViewController, AKFViewControllerDelegate{
    
    var accountKit: AKFAccountKit!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize Account Kit
        if accountKit == nil {
            // may also specify AKFResponseTypeAccessToken
            self.accountKit = AKFAccountKit(responseType: AKFResponseType.AccessToken)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (accountKit.currentAccessToken != nil) {
            // if the user is already logged in, go to the main screen
            print("User already logged in go to ViewController")
            dispatch_async(dispatch_get_main_queue(), {
                self.performSegueWithIdentifier("showhome", sender: self)
            })
            
    
        }
        
    }


    func viewController(viewController: UIViewController!, didCompleteLoginWithAccessToken accessToken: AKFAccessToken!, state: String!) {
        print("Login succcess with AccessToken")
    }
    func viewController(viewController: UIViewController!, didCompleteLoginWithAuthorizationCode code: String!, state: String!) {
        print("Login succcess with AuthorizationCode")
    }
    func viewController(viewController: UIViewController!, didFailWithError error: NSError!) {
        print("We have an error \(error)")
    }
    func viewControllerDidCancel(viewController: UIViewController!) {
        print("The user cancel the login")
    }

    func prepareLoginViewController(loginViewController: AKFViewController) {
        
        loginViewController.delegate = self
        loginViewController.advancedUIManager = nil
        
        //Costumize the theme
        let theme:AKFTheme = AKFTheme.defaultTheme()
        theme.headerBackgroundColor = UIColor(red: 0.325, green: 0.557, blue: 1, alpha: 1)
        theme.headerTextColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        theme.iconColor = UIColor(red: 0.325, green: 0.557, blue: 1, alpha: 1)
        theme.inputTextColor = UIColor(white: 0.4, alpha: 1.0)
        theme.statusBarStyle = .Default
        theme.textColor = UIColor(white: 0.3, alpha: 1.0)
        theme.titleColor = UIColor(red: 0.247, green: 0.247, blue: 0.247, alpha: 1)
        loginViewController.theme = theme
        
        
    }

    @IBAction func loginWithPhone(sender: AnyObject) {
        //login with Phone
        let inputState: String = NSUUID().UUIDString
        let viewController:AKFViewController = accountKit.viewControllerForPhoneLoginWithPhoneNumber(nil, state: inputState)  as! AKFViewController
        viewController.enableSendToFacebook = true
        self.prepareLoginViewController(viewController)
        self.presentViewController(viewController as! UIViewController, animated: true, completion: nil)
    }
    @IBAction func loginWithEmail(sender: AnyObject) {
        //login with Email
        let inputState: String = NSUUID().UUIDString
        let viewController: AKFViewController = accountKit.viewControllerForEmailLoginWithEmail(nil, state: inputState)  as! AKFViewController
        self.prepareLoginViewController(viewController)
        self.presentViewController(viewController as! UIViewController, animated: true, completion: { _ in })
    }
}
