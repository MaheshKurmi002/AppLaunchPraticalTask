//
//  Utils.swift
//  Task
//
//  Created by IPS-172 on 20/01/23.
//

import Foundation
import UIKit

class Utils {
    
}

enum Endpoint {
    case companyInfo
    case launches
}

private extension String {
    static func makeForEndpoint(_ endpoint: String) -> String {
        "https://api.spacexdata.com/v4/\(endpoint)"
    }
}

extension Endpoint {
    var url: String {
        switch self {
        case .companyInfo:
            return .makeForEndpoint("company")
        case .launches:
            return .makeForEndpoint("launches")
        }
    }
}


extension Optional {
    func asStringOrEmpty() -> String {
        switch self {
            case .some(let value):
                return String(describing: value)
            case _:
                return ""
        }
    }

    func asStringOrNilText() -> String {
        switch self {
            case .some(let value):
                return String(describing: value)
            case _:
                return "(nil)"
        }
    }
}

extension Date {
    static func getFormattedDate(string: String , formatter:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = formatter
        
        let date: Date? = dateFormatterGet.date(from: string)
        return dateFormatterPrint.string(from: date!);
    }
    
    
    func fullDistance(from date: Date, resultIn component: Calendar.Component, calendar: Calendar = .current) -> Int? {
        calendar.dateComponents([component], from: self, to: date).value(for: component)
    }

    func distance(from date: Date, only component: Calendar.Component, calendar: Calendar = .current) -> Int {
        let days1 = calendar.component(component, from: self)
        let days2 = calendar.component(component, from: date)
        return days1 - days2
    }

    func hasSame(_ component: Calendar.Component, as date: Date) -> Bool {
        distance(from: date, only: component) == 0
    }

    
}

extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
}
    
}
//CompanyInfoID
//LaunchInfoID

/*
 (lldb) po type(of: compnayInfo)
 Swift.Optional<Task.companyInfo>

 (lldb) po type(of: launchInfo)
 Swift.Optional<Swift.Array<Task.LaunchInfoElement>>
 */
