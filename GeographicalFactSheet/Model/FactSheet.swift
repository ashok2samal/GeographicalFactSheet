//
//  FactSheet.swift
//  GeographicalFactSheet
//
//  Created by Ashok Samal on 23/06/18.
//  Copyright © 2018 Ashok Samal. All rights reserved.
//

import Foundation

//Model for the entire view.
struct FactSheet: Decodable {
    let title: String?
    let rows: [Fact]?
}

//For each row on the table view.
struct Fact: Decodable {
    let title: String?
    let description: String?
    let imageHref: String?
}
