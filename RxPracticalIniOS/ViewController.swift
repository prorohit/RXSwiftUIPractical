//
//  ViewController.swift
//  RxPracticalIniOS
//
//  Created by Rohit Singh on 2/7/18.
//  Copyright © 2018 Rohit Singh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var topTitleLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    let dBag = DisposeBag()
    
    let loginVM = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = emailTextField.rx.text.map {$0 ?? ""}.bind(to: loginVM.emailText)
        _ = passwordTextField.rx.text.map {$0 ?? ""}.bind(to: loginVM.passwordText)
        
        _ = loginVM.isValidLogin.bind(to: loginButton.rx.isEnabled)
        
        let sub = loginVM.isValidLogin.subscribe {[unowned self] (val) in
            self.statusLabel.text = val.element! ? "Enabled" : "Not enabled"
            self.statusLabel.textColor = val.element! ? .green : .red
            self.loginButton.backgroundColor = val.element! ? .green : .red
        }
        sub.disposed(by: dBag)
        
      
    }

    @IBAction func tapLoginButton(_ sender: UIButton) {
        let obj = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RxTableViewVC") as! RxTableViewVC
        self.navigationController?.pushViewController(obj, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

