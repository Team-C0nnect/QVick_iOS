//
//  LoginViewModel.swift
//  QVick
//
//  Created by dgsw8th16 on 1/17/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import Alamofire

class LoginViewModel: ObservableObject {
  
    
    @Published var tokenData = LoginModel()
    
    
    func googleSignIn() {
        guard let viewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
        
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { signinResult, error in
            if error == nil {
                if let idToken = signinResult?.user.idToken?.tokenString {
                    AF.request("\(Constant.url)/auth",
                               
                               method: .post,
                               parameters: ["idToken":idToken] as Dictionary,
                               encoding: JSONEncoding()
                               
                               
                               
                    )
                    .validate()
                    .responseDecodable(of: LoginModel.self) { response in
                        switch response.result {
                        case .success(let data):
                            self.tokenData = data
                            return
                        case .failure(let error):
                            break
                        }
                    }
                }
            }
            
        }
    }
}


