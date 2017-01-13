//
//  RechargeVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class RechargeVC: BaseTableViewController {
    @IBOutlet weak var arrow: UIImageView!
    
    //用户账户
    @IBOutlet weak var userIdText: UITextField!
    
    //余额
    @IBOutlet weak var moneyText: UITextField!
    
    //银行卡号
    @IBOutlet weak var bankNumText: UITextField!
    
    //充值金额
    @IBOutlet weak var rechargeMoneyLabel: UITextField!
    
    //充值方式*
    @IBOutlet weak var rechargeTypeLabel: UILabel!
    
    //自定义cell
    @IBOutlet weak var rechargeMoneyCell: UITableViewCell!
    //自定义cell
    @IBOutlet weak var rechargeTypeCell: UITableViewCell!
    
    @IBOutlet weak var bankTableView: RechargeVcTableView!
    // 来用来判断刷新几个区
    var selectRow : Bool!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bankTableView.didRequest()
        
    }
    
    
    //网络请求
    override func didRequest() {
        
        AppAPIHelper.user().creditdetail(rid:1111000011, complete: { (result) -> ()? in
        
            //
            return nil
        }, error: errorBlockFunc())
        
    }
    //MARK: --UI
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    deinit {
        
        self.bankTableView.removeObserver(self, forKeyPath: "selectType", context: nil)
         ShareModel.share().shareData.removeAll()
    }
    func initUI(){
        
        arrow.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI*0.5))
        // 设置 提现记录按钮
        let btn : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 70, height: 30))
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        btn.setTitle("充值记录", for:  UIControlState.normal)
        
        btn.addTarget(self, action: #selector(rechargeList), for: UIControlEvents.touchUpInside)
        
        let barItem :UIBarButtonItem = UIBarButtonItem.init(customView: btn as UIView)
        self.navigationItem.rightBarButtonItem = barItem
        self.bankTableView.addObserver(self, forKeyPath: "selectType", options: .new, context: nil)
        
    }
    //MARK: 属性的变化
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "selectType" {
            
            if let base = change? [NSKeyValueChangeKey.newKey] as? String {
                
                ShareModel.share().shareData["bid"] = base
            }
        }
    }
    //MARK:-进入充值吗列表页面
    func rechargeList(){
        self.performSegue(withIdentifier: "PushTolist", sender: nil)
    }
    
    
    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        selectRow = false
        title = "充值"
        initData()
        initUI()
    }
    //MARK: --DATA
    func initData() {
        didRequest()
        
    }
    
    //自动识别银行卡
    @IBAction func bankNumBtnTapped(_ sender: UIButton) {
        
    }
    
    //MARK: -进入绑定银行卡
    @IBAction func addBank(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "addBankCard", sender: nil)
        
        
        
        
    }
    //MARK: -提交
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        
        let  story  =  UIStoryboard.init(name: "Share", bundle: nil)
        
        let new  = story.instantiateViewController(withIdentifier: "MyWealtVC")
        
        self.navigationController?.pushViewController(new, animated: true)
        
        
    }
    //MARK: -tableView dataSource
    override   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if section==0 {
            return 2
        }
        if section==1 {
            return 4
        }
        if selectRow == true  {
            return 1
        }else{
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.section==1){
            if(indexPath.row == 3){
                
                if selectRow == true {
                    arrow.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI*0.5))
                }else{
                    arrow.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI*1.5))
                }
                selectRow = !selectRow
                tableView.reloadSections(IndexSet.init(integer: 2), with: UITableViewRowAnimation.fade)
            }
            
        }
        
    }
}



