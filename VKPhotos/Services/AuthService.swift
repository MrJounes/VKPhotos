//
//  AuthService.swift
//  VKPhotos
//
//  Created by Игорь Дикань on 13.12.2020.
//

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: class {
    func authServiceShouldShow(_ viewController: UIViewController)
    func authServiseSignIn()
    func authServiceDidSignInFail()
}

final class AuthService: NSObject {
    
    // MARK: - Internal vars
    private let appId = "7696771"
    private let vkSdk: VKSdk
    weak var delegate: AuthServiceDelegate?
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.initialize ")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
}

// MARK: - Internal logic
extension AuthService {
        
    func wakeUpSession() {
        let scope = ["offline"]
        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
            if state == VKAuthorizationState.authorized {
                print("VKAuthorizationState.authorized")
                delegate?.authServiseSignIn()
            } else if state == VKAuthorizationState.initialized {
                print("VKAuthorizationState.initialized")
                VKSdk.authorize(scope)
            } else {
                print("Auth problem, state \(state) error \(String(describing: error))")
                delegate?.authServiceDidSignInFail()
            }
        }
    }
}

// MARK: - AuthServiceDelegate
extension AuthService: AuthServiceDelegate {
    
    func authServiceShouldShow(_ viewController: UIViewController) {
        print(#function)
    }
    
    func authServiseSignIn() {
        print(#function)
    }
    
    func authServiceDidSignInFail() {
        print(#function)
    }
}

// MARK: - VKSdkDelegate
extension AuthService: VKSdkDelegate {
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            self.delegate?.authServiseSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
}

// MARK: - VKSdkUIDelegate
extension AuthService: VKSdkUIDelegate {
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        self.delegate?.authServiceShouldShow(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
