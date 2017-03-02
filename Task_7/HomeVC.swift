//
//  HomeVC.swift
//  Task_7
//
//  Created by Appinventiv on 02/03/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    //MARK: outlets
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var displayView: UIView!
   
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var buttonBottomLine: UIView!
    
    @IBOutlet weak var bottomConstraintOfScrollView: NSLayoutConstraint!
    
    //MARK: View Life Cycle.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mainScrollView.frame.size = CGSize(width: self.view.frame.width, height: 325)

        //instantiate signIn page
        guard let signInPage = self.storyboard?.instantiateViewController(withIdentifier: "SignInVCID") as? SignInVC else{ return
        }
        signInPage.view.frame = CGRect(x: 0,
                                       y: 0,
                                       width: mainScrollView.frame.width,
                                       height: mainScrollView.frame.height)
        
        //instantiate signUp page
        guard let signUpPage = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVCID") as? SignUpVC else{ return
        }
        signUpPage.view.frame = CGRect(x: mainScrollView.frame.width,
                                       y: 0,
                                       width: mainScrollView.frame.width,
                                       height: mainScrollView.frame.height)
        
        //adding child view controllers.
        self.addChildViewController(signInPage)
        self.addChildViewController(signUpPage)
        
        self.mainScrollView.contentSize = CGSize(width: mainScrollView.frame.width*2,
                                                 height: mainScrollView.frame.height)
        
        //adding subviews to scrollview
        self.mainScrollView.addSubview(signInPage.view)
        self.mainScrollView.addSubview(signUpPage.view)
        
        //actions for signup/signin button.
        signInButton.addTarget(self, action: #selector(signInTapped(_:)), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpTapped(_:)), for: .touchUpInside)
        
        signInPage.signUpButton.addTarget(self, action: #selector(signUpTapped(_:)), for: .touchUpInside)
        signUpPage.logInButton.addTarget(self, action: #selector(signInTapped(_:)), for: .touchUpInside)
        
        //setting up delegate for scroll view
        mainScrollView.delegate = self
        
        //Adjust view when Keyboard appears.
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: OperationQueue.main, using: {(Notification) -> Void in
            
            guard let userinfo = Notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue
                else{ return }
            
            let keyboardHeight = userinfo.cgRectValue.height
            
            
            self.bottomConstraintOfScrollView.constant = keyboardHeight-160
            
        })
        
        //Adjust view when Keyboard disappears.
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: OperationQueue.main, using: {(Notification) -> Void in
            
            self.bottomConstraintOfScrollView.constant = 0
            
        })

    }

}

extension HomeVC{
    
    //MARK: signInTapped
    func signInTapped(_ signIn : UIButton){
        
        
       self.mainScrollView.contentOffset.x = 0
  
    }
    
    //MARK: signUpTapped
    func signUpTapped(_ signUp: UIButton){
        
        self.mainScrollView.contentOffset.x = self.view.frame.width
        
        
    }
}

//MARK: UIScrollViewDelegate
extension HomeVC: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        
        let scrollPoint = scrollView.contentOffset.x
        
        let percentMove = self.view.frame.width/self.buttonBottomLine.frame.width
        
        self.buttonBottomLine.transform = CGAffineTransform(translationX: scrollPoint/percentMove, y: 0)
        
        
    }
}
