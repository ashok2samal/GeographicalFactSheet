//
//  FactSheetService.swift
//  GeographicalFactSheet
//
//  Created by Ashok Samal on 23/06/18.
//  Copyright © 2018 Ashok Samal. All rights reserved.
//

import Foundation
import Alamofire

class FactSheetService {
    
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    static func getFacts(completion: @escaping (_ result: FactSheet) -> Void) {
        var factSheet: FactSheet?
        Alamofire.request("https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json").responseJSON { response in
            if let data = response.data, let dataAsString = String(data: data, encoding: .isoLatin1) {
                let encodedData = dataAsString.data(using: .utf8)
                do {
                    factSheet = try JSONDecoder().decode(FactSheet.self, from: encodedData!) as FactSheet
                    completion(factSheet!)
                } catch let jsonError {
                    print(jsonError.localizedDescription)
                }
            }
        }
    }
}
