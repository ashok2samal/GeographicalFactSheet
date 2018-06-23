//
//  FactSheet.swift
//  GeographicalFactSheet
//
//  Created by Ashok Samal on 23/06/18.
//  Copyright © 2018 Ashok Samal. All rights reserved.
//

import Foundation

struct FactSheet: Decodable {
    let title: String?
    let rows: [Fact]?
}

struct Fact: Decodable {
    let title: String?
    let description: String?
    let imageHref: String?
}
