//
//  SignInVC.swift
//  Task_7
//
//  Created by Appinventiv on 02/03/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

    //outlets
    @IBOutlet weak var googleSignInButton: UIButton!
    
    @IBOutlet weak var fbSignInButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        fbSignInButton.layer.cornerRadius = fbSignInButton.frame.width/2
        
        googleSignInButton.layer.cornerRadius = googleSignInButton.frame.width/2
        
    }

}
