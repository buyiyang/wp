//
//  DealPasswordVC.swift
//  wp
//
//  Created by macbook air on 17/1/9.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class DealPasswordVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var oldPassword: UITextField!
    
    @IBOutlet weak var newPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        oldPassword.clearButtonMode = UITextFieldViewMode.whileEditing
        newPassword.clearButtonMode = UITextFieldViewMode.whileEditing

    }
  
    @IBAction func confirmBtn(_ sender: Any) {
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showTabBarWithAnimationDuration()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabBarWithAnimationDuration()
        translucent(clear: false)
    }
   
    
   


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
