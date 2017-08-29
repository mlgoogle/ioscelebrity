//
//  NSDateExt.swift
//  HappyTravel
//
//  Created by 木柳 on 2016/11/21.
//  Copyright © 2016年 陈奕涛. All rights reserved.
//

import Foundation

extension Date{
    
    static func nowTimestemp() -> TimeInterval{
        return Date().timeIntervalSince1970
    }
    /* date 转时间戳*/
   static  func  stringToTimeStamp(stringTime:String)->Int {
        
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy.MM.dd HH:mm:ss"
        let date = dfmatter.date(from: stringTime)
        
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        let dateSt:Int = Int(dateStamp)
        return dateSt
    }
    

    
    static func startTimestemp() -> TimeInterval{
        let nowDateStr = yt_convertDateToStr(Date(), format: "yyyy-MM-dd")
        let nowDate = yt_convertDateStrToDate(nowDateStr, format: "yyyy-MM-dd")
        let timestemp = nowDate.timeIntervalSince1970
        return timestemp 
    }
    
    /**
     *  字符串转日期
     */
    static func yt_convertDateStrToDate(_ dateStr: String, format: String) -> Date {
        if dateStr == "0000-00-00 00:00:00" {
            return Date()
        }
        let formatter = DateFormatter.init()
        formatter.dateFormat = format
        return formatter.date(from: dateStr)!
    }
    
    /**
     *  日期转字符串
     */
    static func yt_convertDateToStr(_ date: Date, format: String) -> String {
        let formatter = DateFormatter.init()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    /**
     *  时间戳转日期字符串
     */
    static func yt_convertDateStrWithTimestemp(_ timeStemp: Int, format: String) -> String {
        let formatter = DateFormatter.init()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.autoupdatingCurrent
        let date = Date.init(timeIntervalSince1970: Double(timeStemp) as TimeInterval)
        return yt_convertDateToStr(date, format: format)
    }
    /**
     *  时间戳转日期字符串
     */
    static func yt_convertDateStrWithTimestempWithSecond(_ timeStemp: Int, format: String) -> String {
        let formatter = DateFormatter.init()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.autoupdatingCurrent
        let date = Date.init(timeIntervalSince1970: Double(timeStemp) as TimeInterval)
        return yt_convertDateToStr(date, format: format)
    }
    /**
     *  时间戳转日期字符串
     */
    static func getWeekDay(dateTime:String)->String{
        
        let weekDays = [NSNull.init(),"周日","周一","周二","周三","周四","周五","周六","周日"] as [Any]
        let dateFmt = DateFormatter()
        dateFmt.dateFormat = "yyyy-MM-dd"
        
//        let currentdate = NSDate()
//        let timeInterval = currentdate.timeIntervalSince1970
//        if dateFmt.date(from: dateTime) ==  date{
//        
//            return "今天"
//        }
        

        dateFmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFmt.date(from: dateTime)
        let interval = Int(date!.timeIntervalSince1970)
       
        let days = Int(interval/86400) // 24*60*60
        let weekday = (days - 3) % 7
        
        // ? 7 : weekday
        return   weekday == 0 ? "周日" : weekDays[weekday+1] as! String
    }
    
    /**
     *  时间间隔字符串： 刚刚（一分钟内），几分钟前（一小时内），几小时前（一天内），几天前（一月内），几月前（一年内）
     */
    static func marginDateStr(_ timestamp: Int) -> String{
        let now = Int(Date.nowTimestemp())
        let margin  = now - timestamp
        if margin < 60 {
            return "刚刚"
        }
        
        let marginMiu = margin / 60
        if marginMiu < 60{
            return "\(marginMiu+1)分钟前"
        }
        
        
        let marginHour = margin / 3600
        if marginHour <  24{
            return "\(marginHour+1)小时前"
        }
        
        
        let marginDay = margin / (60*60*24)
        if marginDay < 30 {
            return "\(marginDay+1)天前"
        }
        
        
        
        let date = Date.init(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFmt = DateFormatter()
        dateFmt.dateFormat = "yyyy-MM-dd"
        return dateFmt.string(from: date)
    }
    
    /**
     *  获取当前月份
     */
    func yt_month() -> Int {
        let compents: DateComponents = (Calendar.current as NSCalendar).components(.month, from: self)
        return compents.month!
    }
    
    /**
     *  获取当前年份
     */
    func yt_year() -> Int {
        let compents: DateComponents = (Calendar.current as NSCalendar).components(.year, from: self)
        return compents.year!
    }
    
    /**
     *  获取当前日期
     */
    func yt_day() -> Int {
        let compents: DateComponents = (Calendar.current as NSCalendar).components(.day, from: self)
        return compents.day!
    }
    
    /**
     *  获取当前周几
     */
    func yt_weekday() -> Int {
        let compents: DateComponents = (Calendar.current as NSCalendar).components(.weekday, from: self)
        return compents.weekday!
    }

    
    /**
     *  获取当前几点
     */
    func yt_hour() -> Int {
        let compents: DateComponents = (Calendar.current as NSCalendar).components(.hour, from: self)
        return compents.hour!
    }
}



public extension Date {
    
    static func date_form(str: String?) -> Date? {
        
        return self.date_from(str: str, formatter: "yyyy-MM-dd HH:mm:ss")
    }
    
    static func date_from(str: String?, formatter: String?) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        if let da_formatter = formatter {
            dateFormatter.dateFormat = da_formatter
            if let time_str = str {
                let date = dateFormatter.date(from: time_str)
                return date
            }
        }
        return nil
    }
    
    func string_from(formatter: String?) -> String {
        
        if let format = formatter {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.current
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = format
            let date_str = dateFormatter.string(from: self)
            return date_str
        }
        return ""
    }
}
public extension NSDate {
    
    class func date_form(str: String?) -> NSDate? {
        
        return self.date_from(str: str, formatter: "yyyy-MM-dd HH:mm:ss")
    }
    class func date_from(str: String?, formatter: String?) -> NSDate? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        if let da_formatter = formatter {
            dateFormatter.dateFormat = da_formatter
            if let time_str = str {
                let date = dateFormatter.date(from: time_str)
                return date as NSDate?
            }
        }
        return nil
    }
    func string_from(formatter: String?) -> String {
        
        if let format = formatter {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.current
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = format
            let date_str = dateFormatter.string(from: self as Date)
            return date_str
        }
        return ""
    }
}







