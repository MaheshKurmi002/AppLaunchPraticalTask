//
//  CompanyInfoController.swift
//  Task
//
//  Created by IPS-172 on 20/01/23.
//

import Foundation
import Alamofire

struct CompanyInfoController {
    
    func getCompanyInfo(url : String, completion: @escaping (companyInfo?) -> Void) {
        AF.request(Endpoint.companyInfo.url).responseJSON { response in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let compnayInfoRequest = try decoder.decode(companyInfo.self, from: data)
                completion(compnayInfoRequest)
            } catch let error {
                print(error)
                completion(nil)
            }
        }
    }
    
    func getLaunchInfo(url : String, completion: @escaping ([LaunchInfoElement]?) -> Void) {
        AF.request(Endpoint.launches.url).responseJSON { response in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let compnayInfoRequest = try decoder.decode([LaunchInfoElement].self, from: data)
                completion(compnayInfoRequest)
            } catch let error {
                print(error)
                completion(nil)
            }
        }
    }
    
}
