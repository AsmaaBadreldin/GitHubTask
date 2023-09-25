//
//  DateHelper.swift
//  GitHubTask
//
//  Created by Asmaa Badreldin on 9/25/23.
//

import Foundation

import Foundation

class DateHelper : NSObject {
    
    static var sharedDateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    static func checkDate(givenDateStr:String , comparedToDateStr: String) -> String?{
        var dateString: String = ""
        if let givenDate = DateHelper.sharedDateFormatter.date(from: givenDateStr){
            if let comparedToDate = DateHelper.sharedDateFormatter.date(from: comparedToDateStr){
                if givenDate < comparedToDate {
                    dateString = DateHelper.firstDateFormat(date:givenDate)
                }else{
                    dateString = DateHelper.secondDateFormat(givenDate:givenDate)
                }
            }
        }
        
        return dateString
    }
    
    static func firstDateFormat(date: Date) -> String{
        //Thursday, Oct 22, 2020
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.dateFormat = "EEEE MM dd, yyyy"
        formatter.dateStyle = .long

        let dateStr = formatter.string(from: date)
        return dateStr
    }

    static func secondDateFormat(givenDate: Date) -> String{
        // “8 months ago”
       let month = DateHelper.diffBetweenDates(start: givenDate)
       let dateStr = "\(month) months ago"
        
       return dateStr
    }
    
    static func diffBetweenDates(start:Date!) -> TimeInterval{
        let components = Calendar.current.dateComponents([.month], from: start, to: Date())
        var monthDiff :TimeInterval = 0.0
        if let comp =  components.month {
            if(comp > 0 ){
                let month = Double(components.month!)
                monthDiff = month
                print(monthDiff)
            }
        }
        return monthDiff
    }
}
