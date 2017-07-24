//
//  VCTestCase.swift
//  YStar
//
//  Created by mu on 2017/7/21.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import XCTest
@testable import YStar

class VCTestCase: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

class LoginTestCase: XCTestCase {
    let loginVC = UIStoryboard.init(name: "main", bundle: nil).instantiateViewController(withIdentifier: LoginVC.className()) as! LoginVC
    
    override func setUp() {
        super.setUp()
        
    }
    
}
