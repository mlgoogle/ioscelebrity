//
//  APITestCase.swift
//  YStar
//
//  Created by mu on 2017/7/10.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import XCTest
@testable import YStar

class APITestCase: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func ytimeTest(_ funName:String, handle: CompleteBlock) {
        let startTime = Date.nowTimestemp()
        handle(nil)
        let endTime = Date.nowTimestemp()
        let marginTime = endTime - startTime
        if let path = Bundle.main.path(forResource: "ytest", ofType: "plist"){
            if let dic = NSMutableDictionary.init(contentsOfFile: path){
                dic.setValue(marginTime, forKey: funName)
                dic.write(toFile: path, atomically: true)
            }
        }
        
    }
    
    // MARK: - 登录功能
    func testLogin() {
        ytimeTest("testLogin", handle: {_ in 
            let expectOption = expectation(description: "登录测试")
            let param = LoginRequestModel()
            param.phone = "18657195470"
            param.pwd = "123456".md5()
            var idExcept = false
            var phoneExcept = false
            var tokenExcept = false
            AppAPIHelper.commen().login(model: param, complete: { (result) -> ()? in
                
                if let object = result as? StarUserModel{
                    if (object.userinfo?.id) != nil{
                        idExcept = true
                    }
                    if (object.userinfo?.phone) != nil{
                        phoneExcept = true
                    }
                    tokenExcept = object.token.length() > 0
                    expectOption.fulfill()
                }
                return nil
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
            
            XCTAssertTrue(idExcept, "用户id不存在")
            XCTAssertTrue(phoneExcept, "用户手机号不存在")
            XCTAssertTrue(tokenExcept, "token不存在")
            return nil
        })
    }
    // MARK: - 发送验证码
    func testSendCode() {
        let exceptOption = expectation(description: "发送验证码测试")
        let param = SendVerificationCodeRequestModel()
        param.phone = "15557198601"
        AppAPIHelper.commen().sendVerificationCode(model: param, complete: { (result) -> ()? in
            if let model = result as? verifyCodeModel {
                if model.result == 1 {
                    exceptOption.fulfill()
                }
            }
            return nil
        }, error: nil)
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    
    // MARK: - 发送朋友圈
    func testSendCircle(){
        let exceptOption = expectation(description: "发布朋友圈测试")
        let param = SendCircleRequestModel()
        AppAPIHelper.commen().sendCircle(requestModel: param, complete: { (result)in
            if let resultModle = result as? SendCircleResultModel{
                if resultModle.circle_id > 0{
                   exceptOption.fulfill()
                }
            }
            return nil
        }, error: nil)
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    // MARK: - 获取朋友圈列表
    func testCircleList(){
        let exceptOption = expectation(description: "朋友圈测试")
        let model = CircleListRequestModel()
        model.pos = 0
        model.count = 10
        AppAPIHelper.commen().requestCircleList(requestModel: model, complete: { (result) in
            if let circlelist = result as? [CircleListModel]{
                if circlelist.count > 0{
                    exceptOption.fulfill()
                }
            }
            return nil
        }, error: nil)
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    // MARK: - 评论朋友圈
    func testCommentCircle()  {
        let exception = expectation(description: "评论朋友圈")
        let param = CommentCircleModel()
        AppAPIHelper.commen().commentCircle(requestModel: param, complete: { (result) in
            if let model = result as? ResultModel{
                if model.result == 1{
                   exception.fulfill()
                }
            }
            return nil
        }, error: nil)
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    // MARK: - 明星回复朋友圈
    func testStarReply() {
        let exception = expectation(description: "测试明星回复")
        let param = CommentCircleModel()
        AppAPIHelper.commen().starCommentCircle(requestModel: param, complete: { (result) in
            if let model = result as? ResultModel{
                if model.result == 1{
                    exception.fulfill()
                }
            }
            return nil
        }, error: nil)
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    // MARK: - 点赞朋友圈
    func testApproveCircle() {
        let exception = expectation(description: "测试点赞朋友圈")
        let param  = ApproveCircleModel()
        AppAPIHelper.commen().approveCircle(requestModel: param, complete: { (result) in
            if let model = result as? ResultModel{
                if model.result == 1{
                    exception.fulfill()
                }
            }
            return nil
        }, error: nil)
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    // MARK: - 测试所有订单类型
    func testAllOrderTypes() {
        let exception = expectation(description: "测试所有订单类型")
        let param = MeetTypesRequest()
        AppAPIHelper.commen().allOrderTypes(requestModel: param, complete: { (result) in
            if let model = result as? [MeetTypeModel]{
                XCTAssert(model.count > 0, "明星订单类型为空")
                exception.fulfill()
                
            }
            return nil
        }, error: nil)
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    // MARK: - 测试明星订单类型
    func testStarOrderTypes() {
        let exception = expectation(description: "测试明星所有订单类型")
        let param = MeetTypesRequest()
        AppAPIHelper.commen().starOrderTypes(requestModel: param, complete: { (result) in
            if let model = result as? [MeetTypeModel]{
                XCTAssert(model.count > 0, "明星订单类型为空")
                exception.fulfill()
                
            }
            return nil
        }, error: nil)
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    // MARK: - 测试修改明星订单
    func testChangeStarMeetType() {
        let exception = expectation(description: "测试修改明星订单")
        let param  = ChangerMeetTypeRequest()
        AppAPIHelper.commen().changeOrderType(requestModel: param, complete: { (result) in
            if let model = result as? ResultModel{
                if model.result == 1{
                    exception.fulfill()
                }
            }
            return nil
        }, error: nil)
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    // MARK: - 测试约见订单
    func testAllOrder() {
        let exception = expectation(description: "测试约见订单")
        let param = MeetOrderListRequest()
        AppAPIHelper.commen().allOrder(requestModel: param, complete: { (result) in
            if let models = result as? [MeetOrderModel]{
                XCTAssert(models.count > 0, "约见订单为空")
                exception.fulfill()
            }
            return nil
        }, error: nil)
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    // MARK: - 同意订单
    func testAgressOrderTypes() {
        let exception = expectation(description: "明星拥有订单类型")
        let param = AgreeOrderRequest()
        AppAPIHelper.commen().agreeOrder(requestModel: param, complete: { (result) in
            if let model = result as? ResultModel{
                if model.result == 1{
                    exception.fulfill()
                }
            }
            return nil
        }, error: nil)
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    // MARK: - 首页收益列表
    func testRequestEarningInfo() {
        let exception = expectation(description: "测试首页收益列表")
        let param = EarningRequestModel()
        param.stardate = 20170601
        param.enddate = 20170630
        AppAPIHelper.commen().requestEarningInfo(model: param, complete: { (result) -> ()? in
            if let model = result as? [EarningInfoModel] {
                if model.count > 0 {
                    exception.fulfill()
                }
            }
            return nil
        }, error: nil)
        waitForExpectations(timeout: 15, handler: nil)
    }
                
    // MARK: - 今开昨收
    func testrequestYesterdayAndTodayPrice() {
        let exception = expectation(description: "测试今开昨收")
        let param = YesterdayAndTodayPriceRequestModel()
        param.orderdate = 20170627
        AppAPIHelper.commen().requestYesterdayAndTodayPrice(model: param, complete: { (result) -> ()? in
            if let model = result as? YesterdayAndTodayPriceModel {
                if model.max_price > 0 {
                    exception.fulfill()
                }
            }
            return nil
        }, error: nil)
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    // MARK: - 设置交易密码
    func testResetPayPwd() {
        let exception = expectation(description: "测试设置交易密码")
        let param = ResetPayPwdRequestModel()
        param.phone = "15557198601"
        param.pwd = "123456".md5()
        param.timestamp = 1
        param.type = 0
        AppAPIHelper.commen().ResetPayPwd(requestModel: param, complete: { (result) -> ()? in
            if let model = result as? ResultModel {
                if model.result == 0 {
                    exception.fulfill()
                }
            }
            return nil
        }, error: nil)
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    
    
    // MARK: - 校验交易密码
    func testCheckPayPwd() {
        let exception = expectation(description: "测试校验密码")
        let param = CheckPayPwdModel()
        param.uid = Int64(185)
        param.paypwd = "123456".md5()
        AppAPIHelper.commen().CheckPayPwd(requestModel: param, complete: { (result) -> ()? in
            if let model = result as? ResultModel {
                if model.result == 1 {
                    exception.fulfill()
                }
            }
            return nil
        }, error: nil)
        waitForExpectations(timeout: 15, handler: nil)
    }
    

    // MARK: - 提现
    func testWithdrawal() {
        let exception = expectation(description: "测试提现")
        
        let param = WithdrawalRequestModel()
        param.price = 12.22
        AppAPIHelper.commen().Withdrawal(requestModel: param, complete: { (result) -> ()? in
            if let model = result as? ResultModel {
                if model.result == 1 {
                    exception.fulfill()
                }
            }
            return nil
        }, error: nil)
        waitForExpectations(timeout: 15, handler: nil)

        
    }
    
    // MARK: - 提现列表
    func testWithdrawalList() {
        let exception = expectation(description: "测试提现列表")
        let param = WithdrawalListRequetModel()
        param.status = 0
        param.startPos = 10
        AppAPIHelper.commen().withDrawList(requestModel: param, complete: { (result) -> ()? in
            if let model = result as? WithdrawListModel {
                if model.withdrawList != nil {
                    if model.withdrawList.count > 0 {
                        exception.fulfill()
                    }
                }
            }
            return nil
        }, error: nil)
        waitForExpectations(timeout: 15, handler: nil)

    }
    
    // MARK: - 网易云测试
    func testWYIM() {
        let exception = expectation(description: "测试提现列表")
        let param = RegisterWYIMRequestModel()
        param.name_value = "15557198601"
        param.phone = "15557198601"
        param.uid = 185
        AppAPIHelper.commen().registWYIM(model: param, complete: { (result) -> ()? in
            if let model = result as? WYIMModel {
                if model.result_value == "success"{
                    exception.fulfill()
            }
          }
            return nil
        }, error: nil)
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    // MARK: - 是否绑定银行卡
    func testIsBindCardNo() {
        let exception = expectation(description: "测试是否绑定银行卡")
        let param = BankCardListRequestModel()
        param.id = 185
        param.token = UserDefaults.standard.object(forKey: AppConst.UserDefaultKey.token.rawValue) as! String
        
        AppAPIHelper.commen().bankCardList(model: param, complete: { (result) -> ()? in
            if let model = result as? BankListModel {
                if model.cardNo.length() > 0 {
                     exception.fulfill()
                }
            }
            return nil
        }, error: nil)
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    // MARK: - 银行卡信息
    func testBankInfo() {
        let exception = expectation(description: "测试银行卡信息")
        let param = BankCardInfoRequestModel()
        param.cardNo = "6214835895926259"
        AppAPIHelper.commen().bankCardInfo(model: param, complete: { (result) -> ()? in
            if let model = result as? BankInfoModel {
                if model.bankName == "招商银行" {
                    exception.fulfill()
                }
            }
            return nil
        }, error: nil)
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    // MARK: - 粉丝列表
    func testFansList() {
        let exception = expectation(description: "测试粉丝列表")
        let param = FansListRquestModel()
        param.starcode = "1001"
        AppAPIHelper.commen().requestFansList(model: param, complete: { (result) -> ()? in
            if let model = result as? [FansListModel] {
                if model.count > 0 {
                    exception.fulfill()
                }
            }
            return nil
        }, error: nil)
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    //  MARK: - 性能测试：测试登录功能和Add方法性能表现
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            
        }
    }
    
    
    
}
