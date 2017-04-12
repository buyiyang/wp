//
//  LoginApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import Foundation

protocol LoginApi {
    //登录
    func login(phone: String, pwd: String, complete: CompleteBlock?, error: ErrorBlock?)
    //token登录
    func tokenLogin(uid: Int, token: String, complete: CompleteBlock?, error: ErrorBlock?)
    //注册（模型）
    func register(model:RegisterParam, complete: CompleteBlock?, error: ErrorBlock?)
    //重置密码
    func repwd(phone: String, type: Int, pwd: String, code: String, complete: CompleteBlock?, error: ErrorBlock?)
}
