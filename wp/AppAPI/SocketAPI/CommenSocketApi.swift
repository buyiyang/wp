//
//  CommenSocketApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class CommenSocketApi: BaseSocketAPI, CommenApi {

    func imageToken(complete: CompleteBlock?, error: ErrorBlock?) {
        startRequest(SocketDataPacket.init(opcode: .imageToken, type:SocketConst.type.error), complete: complete, error: error)
    }
    
    //错误
    func errorCode(complete: CompleteBlock?, error:ErrorBlock?){
        startRequest(SocketDataPacket.init(opcode: .errorCode), complete: complete, error: error)
    }
    
    //发送验证码
    func verifycode(verifyType: Int64, phone: String, complete: CompleteBlock?, error: ErrorBlock?){
        let param = [SocketConst.Key.phone: phone,
                     SocketConst.Key.type: verifyType,
                     SocketConst.Key.verifyType: verifyType] as [String : Any]
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .verifycode, dict: param as [String : AnyObject] , type: SocketConst.type.user)
        startRequest(packet, complete: complete, error: error)
    }
    
    //发送验证码(模型)
    func verifycode(param: CheckPhoneParam, complete: CompleteBlock?, error: ErrorBlock?){
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .verifycode, model: param , type: .user)
        startRequest(packet, complete: complete, error: error)
    }
    
    //版本更新提醒
    func update(type: Int, complete: CompleteBlock?, error: ErrorBlock?){
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .update, dict: ["ttype": type as AnyObject], type: .user)
        startModelRequest(packet, modelClass: UpdateParam.self, complete: complete, error: error)
    }
  
    //心跳包
    func heartBeat(complete: CompleteBlock?, error: ErrorBlock?){
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .heart, model: BaseParam(), type: .user)
        startRequest(packet, complete: complete, error: error)
    }
}
