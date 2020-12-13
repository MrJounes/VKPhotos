//
//  AuthViewController.swift
//  VKPhotos
//
//  Created by Игорь Дикань on 13.12.2020.
//

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //authService = AuthService()
        authService = AppDelegate.shared().authServise 
    }

    @IBAction func signInTouch(_ sender: UIButton) {
        authService.wakeUpSession()
    }
}
