//
//  WebService.swift
//  MVVMExample
//
//  Created by Rinki Ganguly on 13/12/22.
//

import Foundation
protocol WebServiceProtocol {
    func getEmployees(completion: @escaping (_ success: Bool, _ results: Results?, _ error: String?) -> ())
    
}

class WebService: WebServiceProtocol {
    var countryList :String = ""
  
    func getEmployees(completion: @escaping (Bool, Results?, String?) -> ()) {
        let searchString = String(UserDefaults.standard.string(forKey: "searchText") ?? "")
        HttpRequestHelper().GET(url: "http://www.nactem.ac.uk/software/acromine/dictionary.py", params:["sf": searchString], httpHeader: .application_json) {success, data in
            if success {
                do {
                      let model = try JSONDecoder().decode(Results.self, from: data!)
                        completion(true, model, nil)
                    } catch {
                        completion(false, nil, "Error: Trying to parse Employees to model")
                    }
            } else {
                completion(false, nil, "Error: Employees GET Request failed")
            }
        }
    }
}
