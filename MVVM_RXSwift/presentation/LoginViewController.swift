//
//  ViewController.swift
//  NetworkFramework
//
//  Created by SmartPan on 4/24/21.
//

import UIKit
import RxSwift
class LoginViewController: UIViewController {
    let dispoasBag = DisposeBag()
    private var result: Disposable?
    private lazy var viewModel: LoginViewModel = {
        return LoginViewModel()
    }()
    
    @IBOutlet weak var msgLB: UILabel!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    @IBAction func loginIsPressed(_ sender: Any) {
        callLogin()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    func setup() {
        result = viewModel.behavioralSbj.subscribe { [weak self] event in
            guard let self = self else { return }
            if let element = event.element {
                self.configureUI(status: element)
            }
        }
    }
    
    func callLogin(){
        let param = LoginParams(email: "admin", password: "0000", langId: 1, deviceId: 1002000165)
        viewModel.getUserData(params: param)
    }
    
    func configureUI(status: Status) {
        switch status {
        case .fail:
            print("")
        case .sucess(let data):
            msgLB.text = data.msg

        case .loading:
            break
        
        }
        result?.dispose()
    }

}

