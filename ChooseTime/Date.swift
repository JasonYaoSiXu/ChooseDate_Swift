//
//  Date.swift
//  ChooseTime
//
//  Created by yaosixu on 16/6/16.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

struct TimeInfo {
    var year = 0
    var month = 0
    var weekDay = 0
    var day = 0
    var dayString = ""
}

class Date : NSObject {
    
    private let nowDate = NSDate()
    private let calendar = NSCalendar.currentCalendar()
    private var comp = NSDateComponents()
    
    var year = 0
    var month = 0
    var week = 0
    var day = 0
    var dayString = ""
    var timeInfoArray : [TimeInfo] = []
    var firstWeekDay  = TimeInfo()
    var lastWeekDay = TimeInfo()
    
    override init() {
        super.init()
        comp =  NSCalendar.currentCalendar().components([NSCalendarUnit.Year,NSCalendarUnit.Month,NSCalendarUnit.Weekday,NSCalendarUnit.Day], fromDate: nowDate)
         year = comp.year
        month = comp.month
        week = comp.weekday
        
        if week == 1 {
            week = 7
        } else {
            week = week - 1
        }
        
        day = comp.day
        dayString = "\(day)"
        var timeInfo = TimeInfo()
        timeInfo.year = year
        timeInfo.month = month
        timeInfo.weekDay = week
        timeInfo.day = day
        timeInfo.dayString = dayString

        self.currDay(timeInfo)
    }
    
    /***/
    func getYear() -> Int {
        return comp.year
    }
    
    /***/
    func getMonth() -> Int {
        return comp.month
    }
    
    /***/
    func getWeek()  -> Int {
        
        if comp.weekday == 1 {
            return 7
        } else {
          return  comp.weekday - 1
        }
    }
    
    /***/
    func getDay() -> Int {
        return comp.day
    }
    
    /**  获取当前日期所属月份的天数 */
    func getCountDayOfYearAndMonth() -> Int {
        switch month {
        case 1,3,5,7,8,10,12:
            return 31
        case 2:
            if (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0) {
                return 29
            } else {
                return 28
            }
        default:
            return 30
        }
    }
    
    /**  获取指定年份，月份的天数 */
    func getCountDay(year: Int, month: Int) -> Int {
        switch month {
        case 1,3,5,7,8,10,12:
            return 31
        case 2:
            if (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0) {
                return 29
            } else {
                return 28
            }
        default:
            return 30
        }
    }
    
    
    /** 获取包含当前日期的星期 */
    func currDay(timeInfo: TimeInfo) {
        
        let countDay = getCountDay(timeInfo.year, month: timeInfo.month)
        
        if timeInfo.day - timeInfo.weekDay <= 0 {
            /** 当前星期内，包含一个比当前月份小的月份，或是旧的一年的结束 */
            preMonth(timeInfo)
        } else if  countDay - timeInfo.day  <= 6 {
            /** 当前星期内，包含一个比当前月份大的月份，或是新的一年的开始 */
            nextMonth(timeInfo)
        } else {
            initTimeInfoArray(timeInfo)
        }
    }
    
    /** 当前星期的前一个星期 */
    func otherMonthLeft() {
        
        var preStart = TimeInfo()

        if firstWeekDay.day == 1 {
            if firstWeekDay.month == 1 {
                preStart.year = firstWeekDay.year - 1
                preStart.month = 12
                preStart.day = getCountDay(preStart.year, month: preStart.month)
            } else {
                preStart.year = firstWeekDay.year
                preStart.month = firstWeekDay.month - 1
                preStart.day = getCountDay(preStart.year, month: preStart.month)
            }
        } else {
            preStart.year = firstWeekDay.year
            preStart.month = firstWeekDay.month
            preStart.day = firstWeekDay.day - 1
        }
        
        preStart.weekDay = 7
        preStart.dayString = "\(preStart.day)"
        let dayCount = getCountDay(preStart.year, month: preStart.month)
        
        if preStart.day - preStart.weekDay < 0 {
            /** 当前星期内，包含一个比当前月份小的月份，或是旧的一年的结束 */
            preMonth(preStart)
        } else if dayCount - preStart.day  <= 6 && dayCount - preStart.day != 0 {
            /** 当前星期内，包含一个比当前月份大的月份，或是新的一年的开始 */
            nextMonth(preStart)
        } else {
            initTimeInfoArray(preStart)
        }
    }
    
    /** 当前星期的下一个星期 */
    func otherMonthRight() {
        
        var nextStart = TimeInfo()

        if lastWeekDay.day == getCountDay(lastWeekDay.year, month: lastWeekDay.month) {
            if lastWeekDay.month == 12 {
                nextStart.year = lastWeekDay.year + 1
                nextStart.month = 1
            } else {
                nextStart.year = lastWeekDay.year
                nextStart.month = lastWeekDay.month + 1
            }
            nextStart.day = 1
        } else {
            nextStart.year = lastWeekDay.year
            nextStart.month = lastWeekDay.month
            nextStart.day = lastWeekDay.day + 1
        }
        
        nextStart.weekDay = 1
        nextStart.dayString = "\(nextStart.day)"
        
        if nextStart.day - nextStart.weekDay < 0 {
            /** 当前星期内，包含一个比当前月份小的月份，或是旧的一年的结束 */
            preMonth(nextStart)
        } else if getCountDay(nextStart.year, month: nextStart.month) - nextStart.day  <= 6 {
            /** 当前星期内，包含一个比当前月份大的月份，或是新的一年的开始 */
            nextMonth(nextStart)
        } else {
            initTimeInfoArray(nextStart)
        }
    }
    
    
    
    // -- Mark: 计算当前星期所包含的日期
    
    /**  当前星期内包含的日期只是当前月份的 */
    func initTimeInfoArray(timeInfo: TimeInfo) {
        timeInfoArray.removeAll()
        for i in 1...7 {
            var time = TimeInfo()
            if i < timeInfo.weekDay {
                time.weekDay = i
                time.day = timeInfo.day - (timeInfo.weekDay - i)
            } else if i > timeInfo.weekDay {
                time.weekDay = i
                time.day = timeInfo.day + (i - timeInfo.weekDay)
            } else {
                time.weekDay = timeInfo.weekDay
                time.day = timeInfo.day
            }
            
            time.year = timeInfo.year
            time.month = timeInfo.month
            
            if includeToDay(time) {
                time.dayString = "今"
            } else {
                time.dayString = "\(time.day)"
            }
            timeInfoArray.insert(time, atIndex: i - 1)
        }
        recoderFirstAndLast()
    }

    
    /** 当前星期内包含的日期有比当前月份小的 */
    func preMonth(timeInfo: TimeInfo) {
        timeInfoArray.removeAll()
        //当前星期内包含前一个月日期的天数
        let count = timeInfo.weekDay - timeInfo.day
        
        /**  */
        var pre = TimeInfo()
        
        if timeInfo.month == 1 {
            pre.year = timeInfo.year - 1
            pre.month = 12
        } else {
            pre.year = timeInfo.year
            pre.month = timeInfo.month - 1
        }
        pre.day = getCountDay(pre.year, month: pre.month)
        pre.dayString = "\(pre.day)"
        pre.weekDay = count
        
        for i in 1...6 {
            var time = TimeInfo()
            
            if i < count {
                time.year = pre.year
                time.month = pre.month
                time.weekDay = i
                time.day = pre.day - (pre.weekDay - i)
            } else if i > count {
                time.year = timeInfo.year
                time.month = timeInfo.month
                time.weekDay = i
                time.day = timeInfo.day - (timeInfo.weekDay - i)
            } else {
                time = pre
            }
            if includeToDay(time) {
                time.dayString = "今"
            } else {
                time.dayString = "\(time.day)"
            }
            timeInfoArray.insert(time, atIndex: i - 1)
        }
        timeInfoArray.insert(timeInfo, atIndex: 6)
        
        recoderFirstAndLast()
    }
    
    
    /**  当前星期内包含的日期有比当前月份大的 */
    func nextMonth(timeInfo: TimeInfo) {
        timeInfoArray.removeAll()
        // 当前星期内包含下一个月的日期数
        
        let countDay = 7 - (getCountDay(timeInfo.year, month: timeInfo.month) - timeInfo.day + 1)
        print("getCountDay = \(getCountDay(timeInfo.year, month: timeInfo.month)) timeInfo.day = \(timeInfo.day),countDay = \(countDay)")
        var next = TimeInfo()
        
        if timeInfo.month == 12 {
            next.year = timeInfo.year + 1
            next.month = 1
        } else {
            next.year = timeInfo.year
            next.month = timeInfo.month + 1
        }
        
        next.day = 1
        next.dayString = "\(next.day)"
        next.weekDay = 7 - (countDay - 1)
        
        for i in 1...7 {
            var time = TimeInfo()
            
            if i <= 7 - countDay {
                if i == 1 {
                    time = timeInfo
                } else {
                    time.year = timeInfo.year
                    time.month = timeInfo.month
                    time.day = timeInfo.day + i - 1
                    time.weekDay = timeInfo.weekDay + i - 1
                }
            } else if i > 7 - countDay {
                time.year = next.year
                time.month = next.month
                time.day = next.day + i - countDay
                time.weekDay = next.weekDay + i - countDay
            }
            
            if includeToDay(time) {
                time.dayString = "今"
            } else {
                time.dayString = "\(time.day)"
            }
            timeInfoArray.insert(time, atIndex: i - 1)
        }
        recoderFirstAndLast()
    }
    
    
    /** 记录当前显示星期的星期－ 和星期天 */
    func recoderFirstAndLast() {
        guard let firstDay = timeInfoArray.first else {
            return
        }
        firstWeekDay = firstDay
        guard let lastDay = timeInfoArray.last else {
            return
        }
        lastWeekDay = lastDay
    }
    
    /** 判断当前显示的星期内有没有包含今天 */
    func includeToDay(time: TimeInfo) -> Bool {
        
        if time.year == year && time.month == month && time.day == day {
            return true
        } else {
            return false
        }
    }
    
}
