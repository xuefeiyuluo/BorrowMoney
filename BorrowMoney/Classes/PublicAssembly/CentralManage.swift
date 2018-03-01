//
//  CentralManage.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/10/16.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

func userLogin(successHandler : (()->(Void))?,cancelHandler : (()->(Void))?) -> Void {
    // 判断是否登录
    if ASSERLOGIN! {
        successHandler?();
    } else {
        let vc = LoginVC()
        
        vc.successHandler = {
            vc.dismiss(animated: true, completion: {
                if successHandler != nil {
                    successHandler!()
                }
            })
        }
        
        vc.cancelHandler = {
            vc.dismiss(animated: true, completion: {
                if cancelHandler != nil {
                    cancelHandler!()
                }
            })
        }
        
        let nav : CustomNavigationController = CustomNavigationController(rootViewController: vc)
        rootViewController?.present(nav, animated: true, completion: nil)
    }
}


// 个人信息
func personalInfo() -> BasicVC {
    let personInfo : PersonalInfoVC = PersonalInfoVC()
    personInfo.hidesBottomBarWhenPushed = true
    return personInfo
}


// 个人中心webView界面
func userCenterWebViewWithUrl(url : String) -> BasicVC {
    let userCenterWeb : UserCenterWebVC = UserCenterWebVC()
    userCenterWeb.hidesBottomBarWhenPushed = true
    userCenterWeb.url = url
    return userCenterWeb
}


// 设置
func setUp() -> BasicVC {
    let setUp : SetUpVC = SetUpVC()
    setUp.hidesBottomBarWhenPushed = true
    return setUp
}


// 修改密码
func modifyPassword() -> BasicVC {
    let modifyPsw : ModifyPasswordVC = ModifyPasswordVC()
    return modifyPsw
}


// 关于
func about() -> BasicVC {
    let about : AboutVC = AboutVC()
    return about
}


// 消息中心
func messageCenter() -> BasicVC {
    let messageCenter : MessageCenterVC = MessageCenterVC()
    messageCenter.hidesBottomBarWhenPushed = true
    return messageCenter
}


// 还款管理
func repayManage() -> BasicVC {
    let repayManage : RepayManageVC = RepayManageVC()
    repayManage.hidesBottomBarWhenPushed = true
    return repayManage
}


// 订单管理
func orderManage() -> BasicVC {
    let orderManage : OrderManageVC = OrderManageVC()
    orderManage.hidesBottomBarWhenPushed = true
    return orderManage
}

// 还款记录
func repayRecord() -> BasicVC {
    let repayRecord : RepayRecordVC = RepayRecordVC()
    return repayRecord
}


// 账单详情
func billDetail(model : LoanManageData) -> BasicVC {
    let detail : BillDetailVC = BillDetailVC()
    detail.loanModel = model
    return detail
}


// 首页搜索结果页面
func searchResult(dataDict:NSDictionary) -> BasicVC {
    let result : SearchResultVC = SearchResultVC()
    result.hidesBottomBarWhenPushed = true
    result.dataDict = dataDict
    return result
}


// 贷款详情页面
func loanDetail(hotLoan : HotLoanModel) -> BasicVC {
    let result : LoanDetailVC = LoanDetailVC()
    result.hotLoan = hotLoan
    result.hidesBottomBarWhenPushed = true
    return result
}


// 大额贷款
func largeLoan() -> BasicVC {
    let largeLoan : LargeLoanVC = LargeLoanVC()
    largeLoan.hidesBottomBarWhenPushed = true
    return largeLoan
}


// 微信公众号
func weChatFocus() -> BasicVC {
    let weChat : WeChatFocusVC = WeChatFocusVC()
    weChat.hidesBottomBarWhenPushed = true
    return weChat
}


// 贷款计算器
func loanCalculator() -> BasicVC {
    let loanCalculator : LoanCalculatorVC = LoanCalculatorVC()
    loanCalculator.hidesBottomBarWhenPushed = true
    return loanCalculator
}


// 我的现金
func cash() -> BasicVC {
    let cash : MyCashVC = MyCashVC()
    cash.hidesBottomBarWhenPushed = true
    return cash
}


// 我的免息卷
func interestFree() -> BasicVC {
    let interestFree : MyInterestFreeVC = MyInterestFreeVC()
    interestFree.hidesBottomBarWhenPushed = true
    return interestFree
}


// 我要攒积分
func integral() -> BasicVC {
    let integral : MyIntegralVC = MyIntegralVC()
    integral.hidesBottomBarWhenPushed = true
    return integral
}


// 账号管理
func accountManage() -> BasicVC {
    let accountManage : AccountManageVC = AccountManageVC()
    accountManage.hidesBottomBarWhenPushed = true
    return accountManage
}


// 资金明细
func capitalDetails() -> BasicVC {
    let capitalDetails : CapitalDetailsVC = CapitalDetailsVC()
    return capitalDetails
}


// 添加银行卡
func bankCard() -> BasicVC {
    let bankCard : BankCardVC = BankCardVC()
    return bankCard
}
