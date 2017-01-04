//
//  DealApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import Foundation

protocol DealApi{
    //获取分时接口
    func minDealInfo(type: Int, complete: CompleteBlock?, error:ErrorBlock?);
    //当前仓位列表
    func currentDeals(complete: CompleteBlock?, error:ErrorBlock?)
    //当前仓位详情
    func currentDealDetail(positionId: Int, complete: CompleteBlock?, error:ErrorBlock?)
    //历史仓位列表
    func historyDeals(complete: CompleteBlock?, error:ErrorBlock?)
    //历史仓位详情
    func historyDealDetail(positionId: Int, complete: CompleteBlock?, error:ErrorBlock?)
    //建仓
    func buildDeal(model: PositionModel, complete: CompleteBlock?, error:ErrorBlock?)
    //平仓
    func sellOutDeal(positionId: Int, price: Int, complete: CompleteBlock?, error:ErrorBlock?)
    //修改持仓
    func changeDeal(model: PositionModel, complete: CompleteBlock?, error:ErrorBlock?)
}
