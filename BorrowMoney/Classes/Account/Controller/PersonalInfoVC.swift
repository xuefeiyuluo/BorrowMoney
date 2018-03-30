//
//  PersonalInfoVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/15.
//  Copyright © 2017年 sparrow. All rights reserved.
//

class PersonalInfoVC: BasicVC, UITableViewDelegate, UITableViewDataSource {
    var headerView : PersonHeaderView = PersonHeaderView()// 头部View
    var baseCertificaView : BasicViewCell = BasicViewCell()// 基本认证
    var largeCertificaView : LargeCertificaCell = LargeCertificaCell()// 大额认证
    var personalTableView : UITableView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 隐藏导航栏
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建UI
        createUI()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    // 创建UI
    func createUI() -> Void {
        self.view.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(184 + 46 * HEIGHT_SCALE)
        }
        self.headerView.backBtn.addTarget(self, action: #selector(backClick), for: UIControlEvents.touchUpInside)
        
        let tableView :UITableView  = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = MAIN_COLOR
        tableView.separatorStyle = .none
        tableView.register(BaseCertificaCell.self, forCellReuseIdentifier: "basicView")
        tableView.register(LargeCertificaCell.self, forCellReuseIdentifier: "largeView")
        self.personalTableView = tableView
        self.view .addSubview(self.personalTableView!)
        self.personalTableView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.headerView.snp.bottom)
            make.left.right.bottom.equalTo(self.view)
        })
        let footerView : PersonFooterView = PersonFooterView()// 底部View
        footerView.frame = CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 100 * HEIGHT_SCALE)
        self.personalTableView?.tableFooterView = footerView
        footerView.recommendBtn.addTarget(self, action: #selector(personRecommendClick), for: UIControlEvents.touchUpInside)
    }
    
    
    // MARK: UITableViewDataSource, UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 220 * HEIGHT_SCALE
        } else {
            return 150 * HEIGHT_SCALE
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        weak var weakSelf = self
        if indexPath.row == 0 {
            let cell : BaseCertificaCell = tableView.dequeueReusableCell(withIdentifier: "basicView") as! BaseCertificaCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.baseBlock = { (tag) in
                weakSelf?.navigationController?.pushViewController(certifica(type: tag), animated: true)
            }
            return cell
        } else {
            let cell : LargeCertificaCell = tableView.dequeueReusableCell(withIdentifier: "largeView") as! LargeCertificaCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.largeBlock = { (tag) in
                weakSelf?.navigationController?.pushViewController(certifica(type: tag), animated: true)
            }
            
            return cell
        }
    }
    
    
    // 为我推荐的按钮
    func personRecommendClick() -> Void {
        APPDELEGATE.tabBarControllerSelectedIndex(index: 1)
        self.comeBack()
    }
    
    
    // 返回按钮
    func backClick() -> Void {
        comeBack()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
