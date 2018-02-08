//
//  LoginViewModel.swift
//  RxPracticalIniOS
//
//  Created by Rohit Singh on 2/8/18.
//  Copyright © 2018 Rohit Singh. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct LoginViewModel {
    var emailText = Variable<String>("")
    var passwordText = Variable<String>("")
    
    var isValidLogin: Observable<Bool> {
        return Observable.combineLatest(emailText.asObservable(), passwordText.asObservable()) { email, pass in
           email.count >= 3 && pass.count >= 3
        }
    }
}
