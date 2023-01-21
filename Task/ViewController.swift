//
//  ViewController.swift
//  Task
//
//  Created by IPS-172 on 20/01/23.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController {

    var companyInfo = CompanyInfoController()
    
    var actionSheet: UIAlertController!
    
    var filterActionSheet: UIAlertController!
    
    var resArr : [Any] = []
    
    var succArr : LaunchInfo!
    
    var ASSfiltArr : LaunchInfo!
    
    var DECfiltArr : LaunchInfo!
    
    var launchInfoArr : LaunchInfo!
    
    @IBOutlet weak var tabView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spacex"
        //self.navigationItem.title = "SpaceX"
        let add = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(onClickMessageButton))
        navigationItem.rightBarButtonItems = [add]
        
        print("----> \(Endpoint.companyInfo.url)")
        print("----> \(Endpoint.launches.url)")
        companyInfo.getCompanyInfo(url: Endpoint.companyInfo.url) { compnayInfo in
            self.resArr.append(compnayInfo)
            self.TabViewConfig()
        }
        companyInfo.getLaunchInfo(url: Endpoint.launches.url) { launchInfo in
            self.resArr.append(launchInfo)
            self.TabViewConfig()
        }
        

    }
    @objc func onClickMessageButton() {
        guard self.resArr.count == 2 else {
            return
        }
        filterActionSheet = UIAlertController(title: "Filters", message: nil, preferredStyle: .actionSheet)

        // create an action
        let firstAction: UIAlertAction = UIAlertAction(title: "Successful launch with ASC Order", style: .default) { action -> Void in
            self.resArr[1] = self.ASSfiltArr
            self.showToast(message: "Filter Applied", font: .systemFont(ofSize: 12.0))
            self.tabView.reloadData()
        }

        let secondAction: UIAlertAction = UIAlertAction(title: "Successful launch with DESC Order", style: .default) { action -> Void in
            self.resArr[1] = self.DECfiltArr
            self.showToast(message: "Filter Applied", font: .systemFont(ofSize: 12.0))
            self.tabView.reloadData()

        }
        
        let thirdAction: UIAlertAction = UIAlertAction(title: "Remove filter", style: .default) { action -> Void in
            self.resArr[1] = self.launchInfoArr
            self.showToast(message: "Filter Removed", font: .systemFont(ofSize: 12.0))
            self.tabView.reloadData()
        }

        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }

        // add actions
        filterActionSheet.addAction(firstAction)
        filterActionSheet.addAction(secondAction)
        filterActionSheet.addAction(thirdAction)
        filterActionSheet.addAction(cancelAction)

        present(filterActionSheet, animated: true) {
        }
    }

    
    func actionSheetConfi(singleLaunchInfo : LaunchInfoElement) {
        actionSheet = UIAlertController(title: "Links", message: nil, preferredStyle: .actionSheet)

        // create an action
        let firstAction: UIAlertAction = UIAlertAction(title: "Article", style: .default) { action -> Void in
            print(singleLaunchInfo.links.article.asStringOrNilText())
            self.presentView(url: singleLaunchInfo.links.article.asStringOrNilText())
        }

        let secondAction: UIAlertAction = UIAlertAction(title: "Wikipedia", style: .default) { action -> Void in
            print(singleLaunchInfo.links.wikipedia.asStringOrNilText())
            self.presentView(url: singleLaunchInfo.links.wikipedia.asStringOrNilText())
        }
        
        let thirdAction: UIAlertAction = UIAlertAction(title: "Video Page", style: .default) { action -> Void in
            print(singleLaunchInfo.links.webcast.asStringOrNilText())
            self.presentView(url: singleLaunchInfo.links.webcast.asStringOrNilText())
        }

        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }

        // add actions
        actionSheet.addAction(firstAction)
        actionSheet.addAction(secondAction)
        actionSheet.addAction(thirdAction)
        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true) {
        }
    }
    
    func TabViewConfig() {
        if self.resArr.count == 2 {
            self.tabView.dataSource = self
            self.tabView.delegate = self
            self.tabView.reloadData()
            
            self.launchInfoArr = self.resArr[1] as! LaunchInfo
            self.succArr = launchInfoArr.filter { launchInfoElement -> Bool in
                if launchInfoElement.success == true && (launchInfoElement.success != nil) {
                    return true
                }else{
                    return false
                }
            }
            
            self.ASSfiltArr = succArr.sorted { (lhs: LaunchInfoElement, rhs: LaunchInfoElement) -> Bool in
                return self.yearInStruct(launchElement: lhs) > self.yearInStruct(launchElement: rhs)
            }
            
            self.DECfiltArr = succArr.sorted { (lhs: LaunchInfoElement, rhs: LaunchInfoElement) -> Bool in
                return self.yearInStruct(launchElement: lhs) < self.yearInStruct(launchElement: rhs)
            }
        }
    }
    
    func yearInStruct(launchElement : LaunchInfoElement) -> Int {
        let dateString = launchElement.dateLocal
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date = Date.getFormattedDate(string: dateString, formatter: "yyyy")
        return Int(date)!
    }
    
    func presentView(url : String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        vc.url = url
        self.present(vc, animated: true, completion: nil)
    }
    
    func isDatePast(date : String) -> String {
        let dateString = date

        // Setup a date formatter to match the format of your string
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        // Create a date object from the string
        if let date = dateFormatter.date(from: dateString) {

            if date < Date() {
                return "since"
            } else {
                return "from"
            }
        }
        return "Now"
    }
    
}
extension ViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        if section == 0 {
            label.text = "COMPANY"
        }else{
            label.text = "LAUNCHS"
        }
        
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        headerView.backgroundColor = .black
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return resArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            let launchData = resArr[section] as! LaunchInfo
            return launchData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let companyInfoData = resArr[indexPath.row] as! companyInfo
            print(companyInfoData.name.asStringOrNilText())
            let cell = tableView.dequeueReusableCell(withIdentifier: "companyInfoCell") as! companyInfoTVCellTableViewCell
            cell.lblInfo.text = "\(companyInfoData.name.asStringOrNilText()) was founded by \(companyInfoData.founder.asStringOrNilText()) in \(companyInfoData.founded.asStringOrNilText()). It has now \(companyInfoData.employees.asStringOrNilText()) employees, \(companyInfoData.launch_sites.asStringOrNilText()) launch sites, and is valued at USD \(companyInfoData.valuation.asStringOrNilText())."
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchInfoTVCell") as! LaunchInfoTVCell
            let launchInfoData = resArr[indexPath.section] as! LaunchInfo
            let launchData = launchInfoData[indexPath.row] as LaunchInfoElement
            cell.missionVlbl.text = launchData.name
            cell.rocketVlbl.text = "\(launchData.name) \(launchData.rocket)"
            cell.dateVlbl.text = "\(Date.getFormattedDate(string: launchData.dateLocal, formatter: "MM/dd/yyyy")) at \(Date.getFormattedDate(string: launchData.dateLocal, formatter: "HH:mm"))"
           
            if let url = launchData.links.patch.small {
                KF.url(URL(string: url)).set(to: cell.patchImg)
            }
            
            
            if let isSuccess = launchData.success {
                cell.islaunchImg.image = UIImage(named: isSuccess ? "checked" : "unChecked")
            }
            
            
            //DATE CALCLATION START
            let date = Date()
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "dd-MM-yyyy hh:mm:ss"
            let currentdate = dateFormatter1.string(from: date)
            
            var dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy hh:mm:ss"

            let smallerDate = dateFormatter.date(from: currentdate)!
            let biggerDate  = dateFormatter.date(from: Date.getFormattedDate(string: launchData.dateLocal, formatter: "dd-MM-yyyy hh:mm:ss"))!
            
            let days = Int(smallerDate.fullDistance(from: biggerDate, resultIn: .day).asStringOrNilText())
            
            if days! > 0 {
                cell.daysHlbl.text = "\(days)"
                cell.isDaysBeforelbl.text = "Days after now :"

            }else{
                cell.daysHlbl.text = "\(abs(days!))"
                cell.isDaysBeforelbl.text = "Days before now :"

            }
            //DATE CALCULATION END
            
            
            cell.selectionStyle = .none
            
            
            
            
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            print("Tap")
        }else{
            let launchInfoData = resArr[indexPath.section] as! LaunchInfo
            let launchData = launchInfoData[indexPath.row] as LaunchInfoElement
            
            self.actionSheetConfi(singleLaunchInfo: launchData)
        }
        
    }
    
}
