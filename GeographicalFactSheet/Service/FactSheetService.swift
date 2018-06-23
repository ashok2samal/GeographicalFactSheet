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
    
    //Checks if the device has internet connection or not.
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    //Requests for the data using Alamofire.
    static func getFacts(completion: @escaping (_ result: FactSheet) -> Void) {
        var factSheet: FactSheet?
        Alamofire.request(kFactResourceEndpoint).responseJSON { response in
            //Received json(isoLatin1) is converted to utf8 data then decoded using model class.
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
