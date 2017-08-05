//
//  MeetTypeVC.swift
//  YStar
//
//  Created by mu on 2017/7/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class MeetTypeVC: BaseTableViewController {
    
    @IBOutlet weak var typeCell: MeetTypeCell!
    
    var allOrders : [MeetTypeModel] = []
    var starOrders : [MeetTypeModel] = []
    var ordersDic : [String: Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestAllTypes()
    }
    
    func requestAllTypes() {
        let param = MeetTypesRequest()
        if self.starOrders != nil {
            self.starOrders.removeAll()
        }
        AppAPIHelper.commen().allOrderTypes(requestModel: param, complete: { [weak self](result) in
            if let models = result as? [MeetTypeModel]{
                self?.allOrders = models
                for (index,model) in models.enumerated() {
                    self?.ordersDic[model.name] = index
                }
                self?.requestStarAllTypes()
            }
            return nil
        }, error: nil)
    }
    
    func requestStarAllTypes() {
        let param = MeetTypesRequest()
        AppAPIHelper.commen().starOrderTypes(requestModel: param, complete: { [weak self](result) in
            if let models = result as? [MeetTypeModel]{
                self?.starOrders = models
                for model in models{
                    if let index = self?.ordersDic[model.name]{
                        if let order = self?.allOrders[index]{
                            order.status = 1
                            model.showpic_url = order.showpic_url
                            model.price = order.price
                        }
                    }
                }
                self?.typeCell.setMeetType(models)
                self?.tableView.reloadData()
            }
            return nil
        }, error: nil)
        
//        let param = MeetTypesRequest()
//        AppAPIHelper.commen().starOrderTypes(requestModel: param, complete: {[weak self] (result) -> ()? in
//            if let models = result as? [MeetTypeModel] {
//                self?.starOrders = models
//                for model in models {
//                    if let index = self?.ordersDic[model.name] {
//                        if let order = self?.allOrders[index] {
//                            order.status = 1
//                            model.showpic_url = order.showpic_url
//                            model.price = order.price
//                        }
//                    }
//                }
//                self?.typeCell.setMeetType(models)
//                self?.tableView.reloadData()
//                
//            }
//            return nil
//        }) { (error) -> ()? in
//            self.didRequestError(error)
//            self.starOrders.removeAll()
//            self.tableView.reloadData()
//            return nil
//        }
    }
    
    @IBAction func AddMeetTypeAction(_ sender: UIButton) {
        if let meetTypeDetailVC = UIStoryboard.init(name: "Meet", bundle: nil).instantiateViewController(withIdentifier: MeetTypeDetailVC.className()) as? MeetTypeDetailVC{
            meetTypeDetailVC.items = allOrders
            self.navigationController?.pushViewController(meetTypeDetailVC, animated: true)

        }
    }
}
