//
//  LoginViewModel.swift
//  NetworkFramework
//
//  Created by SmartPan on 4/24/21.
//

import Foundation
import RxSwift

struct UIViewModel {
    let msg: String
}
enum Status {
    case sucess(UIViewModel)
    case fail
    case loading
}

class LoginViewModel {
    let disposBag = DisposeBag()
    let behavioralSbj = BehaviorSubject<Status>(value: .loading)
    
    func getUserData(params: LoginParams) {
        
        LoginUseCase.build(param: params).subscribe( onNext: { [weak self] result in
            guard let selfObjct = self else { return }
            selfObjct.behavioralSbj.onNext(result)
        }, onError: { error in
            print(error)
        }).disposed(by: disposBag)
    }
}
