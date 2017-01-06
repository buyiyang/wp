//
//  UserSocketApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class UserSocketApi: BaseSocketAPI, UserApi {
    
    //设置用户信息
    func userInfo(user: UserInfo, complete: CompleteBlock?, error: ErrorBlock?){
        let param = [SocketConst.Key.uid : UserModel.share().currentUser?.id]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .userInfo, dict: param as [String : AnyObject])
        startRequest(packet, complete: complete, error: error)
    }
    //设置账号信息
    func accountNews(complete: CompleteBlock?, error: ErrorBlock?)
    {
        let param:[String : Any] = [SocketConst.Key.uid : UserModel.share().currentUser?.id ?? 0,
                                    SocketConst.Key.token : UserModel.token ?? ""]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .userInfo, dict: param as [String : AnyObject])
        startRequest(packet, complete: complete, error: error)
    }
    //流水列表
    func flowList(flowType: String, startPos: Int32, count: Int32, complete: CompleteBlock?, error: ErrorBlock?){
        
        let param = [SocketConst.Key.uid: UserModel.share().currentUser?.id ?? 0,
                     SocketConst.Key.token: UserModel.token ?? "",
                     SocketConst.Key.flowType: flowType,
                     SocketConst.Key.startPos: startPos,
                     SocketConst.Key.countNuber: count] as [String : Any]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .flowList, dict: param as [String : AnyObject])
        startRequest(packet, complete: complete, error: error)
    }
    //流水详情
    func flowDetails(flowld: Int64, flowType: Int8, complete: CompleteBlock?, error: ErrorBlock?){
        
        let param = [SocketConst.Key.uid: UserModel.share().currentUser?.id ?? 0,
                     SocketConst.Key.token: UserModel.token ?? "",
                     SocketConst.Key.flowld: flowld,
                     SocketConst.Key.flowType: flowType] as [String : Any]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .flowDetails, dict: param as [String : AnyObject])
        startRequest(packet, complete: complete, error: error)
    }
    //银行卡列表
    func bankcardList(complete: CompleteBlock?, error: ErrorBlock?){
        let param = [SocketConst.Key.uid: UserModel.share().currentUser?.id ?? 0,
                     SocketConst.Key.token: UserModel.token ?? ""] as [String : Any]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .bankcardList, dict: param as [String : AnyObject])
        startRequest(packet, complete: complete, error: error)
    }
    //绑定银行卡
    func bingcard(bank: String, branchBank: String, province: String, city: String, cardNo: String, name:String, complete: CompleteBlock?, error: ErrorBlock?){
        let param = [SocketConst.Key.uid: UserModel.share().currentUser?.id ?? 0,
                     SocketConst.Key.token: UserModel.token ?? "",
                     SocketConst.Key.bank: bank,
                     SocketConst.Key.branchBank: branchBank,
                     SocketConst.Key.province: province,
                     SocketConst.Key.city: city,
                     SocketConst.Key.cardNo:cardNo,
                     SocketConst.Key.name: name] as [String : Any]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .bingcard, dict: param as [String : AnyObject])
        startRequest(packet, complete: complete, error: error)
        
    }
    //解绑银行卡
    func unbindcard(bankId: Int32, vCode:Int32, complete: CompleteBlock?, error: ErrorBlock?){
        
        let param = [SocketConst.Key.uid: UserModel.share().currentUser?.id ?? 0,
                     SocketConst.Key.token: UserModel.token ?? "",
                     SocketConst.Key.bankId: bankId,
                     SocketConst.Key.code: vCode] as [String : Any]
        
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .unbindcard, dict: param as [String : AnyObject])
        startRequest(packet, complete: complete, error: error)
    }
    //充值列表
    func creditlist(status: String, pos: Int32, count: Int32, complete: CompleteBlock?, error: ErrorBlock?){
        let param = [SocketConst.Key.uid: UserModel.share().currentUser?.id ?? 0,
                     SocketConst.Key.token: UserModel.token ?? "",
                     SocketConst.Key.status: status,
                     SocketConst.Key.pos: pos,
                     SocketConst.Key.countNuber: count] as [String : Any]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .rechageList, dict: param as [String : AnyObject])
       
        startModelsRequest(packet, modelClass: RechargeListModel.self, complete: complete, error: error)
       
    }
    //充值详情
    func creditdetail(rid: Int64, complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String : Any] = [SocketConst.Key.uid: UserModel.share().currentUser?.id ?? 0,
                                     SocketConst.Key.token: UserModel.token ?? "",
                                     SocketConst.Key.rid: rid]
        
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .recharge, dict: param as [String : AnyObject])
       
        
        startModelRequest(packet, modelClass: RechargeDetailModel.self, complete: complete, error: error)
    }
    //银行卡提现
    func withdrawcash(money: Double, bld: Int64, password: String, complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String : Any] = [SocketConst.Key.uid: UserModel.share().currentUser?.id ?? 0,
                                     SocketConst.Key.token: UserModel.token ?? "",
                                     SocketConst.Key.money: money,
                                     SocketConst.Key.bld: bld,
                                     SocketConst.Key.password: password]
        
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .withdrawCash, dict: param as [String : AnyObject])
        startRequest(packet, complete: complete, error: error)
    }
    //提现列表
    func withdrawlist(status: String, pos: Int32, count: Int32, complete: CompleteBlock?, error: ErrorBlock?){
        let param = [SocketConst.Key.uid: UserModel.share().currentUser?.id ?? 0,
                     SocketConst.Key.token: UserModel.token ?? "",
                     SocketConst.Key.status: status,
                     SocketConst.Key.pos: pos,
                     SocketConst.Key.countNuber: count] as [String : Any]
        
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .withdrawList, dict: param as [String : AnyObject])
        startRequest(packet, complete: complete, error: error)
    }
    //提现详情
    func withdrawdetail(withdrawld: Int64, complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String : Any] = [SocketConst.Key.uid: UserModel.share().currentUser?.id ?? 0,
                                     SocketConst.Key.token: UserModel.token ?? "",
                                     SocketConst.Key.withdrawld: withdrawld]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .withdrawdetail, dict: param as [String : AnyObject])
        startRequest(packet, complete: complete, error: error)
    }
    
}





