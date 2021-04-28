//
//  LoginRepo.swift
//  NetworkFramework
//
//  Created by SmartPan on 4/27/21.
//

import Foundation
import RxSwift
import Alamofire

protocol LoginRepo {
    static func login(param: LoginParams)
        -> Observable<LoginResponse>
}
