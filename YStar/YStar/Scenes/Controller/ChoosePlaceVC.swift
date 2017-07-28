//
//  ChoosePlaceVC.swift
//  YStar
//
//  Created by MONSTER on 2017/7/28.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

private let KnomalCellID = "nomalCell"

typealias ChoosePlaceBlock = (_ placeCity:String) -> Void


class ChoosePlaceVC: BaseTableViewController {
    
    var placeBlock : ChoosePlaceBlock?
    
    /// 懒加载 城市数据
    lazy var cityDic: [String: [String]] = { () -> [String : [String]] in
        let path = Bundle.main.path(forResource: "city.plist", ofType: nil)
        let dic = NSDictionary(contentsOfFile: path ?? "") as? [String: [String]]
        return dic ?? [:]
    }()
    
    /// 懒加载 标题数组
    lazy var titleArray: [String] = { () -> [String] in
        var array = [String]()
        for str in self.cityDic.keys {
            array.append(str)
        }
        // 标题排序
        array.sort()
        return array
    }()
    
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        
        self.title = "选择城市"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: KnomalCellID)
        
    }
    
    // MARK: - 多少组
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return titleArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let key = titleArray[section]
        return cityDic[key]!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: KnomalCellID, for: indexPath)
        let key = titleArray[indexPath.section]
        cell.textLabel?.text = cityDic[key]![indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.textLabel?.text != "" {
            if self.placeBlock != nil {
               self.placeBlock!((cell?.textLabel?.text)!)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - section头视图
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)
        -> String? {
            return self.titleArray[section]
    }
    
    // MARK: - 右边索引
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return titleArray
    }
    
    // MARK: - 高度
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
}

