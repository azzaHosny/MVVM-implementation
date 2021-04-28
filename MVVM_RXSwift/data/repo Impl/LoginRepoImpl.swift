//
//  LoginRepoImpl.swift
//  NetworkFramework
//
//  Created by SmartPan on 4/27/21.
//

import Foundation
import RxSwift
import Alamofire

class LoginRepoImpl: LoginRepo {
    static func login(param: LoginParams) -> Observable<LoginResponse> {
        let params: [String: Any] = ["username": param.email, "password": param.password, "langId": param.langId, "deviceId": param.deviceId]
       return APICaller.makeRequest(url: "https://demobr.fodo.live/api/Authentication/LogIn", method: .post, paramters: params, header: [:])
    }
}
