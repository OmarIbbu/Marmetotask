//
//  ViewController.swift
//  Marmeto
//
//  Created by thincnext on 27/09/18.
//  Copyright © 2018 thincnext. All rights reserved.
//

import UIKit
import GoogleSignIn


class ViewController: UIViewController,GIDSignInUIDelegate  {
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         GIDSignIn.sharedInstance().uiDelegate = self
       
    }
    
  
    func signIn(signIn: GIDSignIn!,
                presentViewController viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
  
    func signIn(signIn: GIDSignIn!,
                dismissViewController viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    


}

