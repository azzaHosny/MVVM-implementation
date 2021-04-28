//
//  LoginUseCase.swift
//  NetworkFramework
//
//  Created by SmartPan on 4/27/21.
//

import Foundation
import RxSwift
import Alamofire
class LoginUseCase {
    
    static func build(param: LoginParams) -> Observable<Status> {
        return LoginRepoImpl.login(param: param).map({
            guard let dataObjct = $0.data else {return .fail}
            let viewModel = UIViewModel(msg: "\(dataObjct.userId!)")
            return .sucess(viewModel)
        })
    }
}
