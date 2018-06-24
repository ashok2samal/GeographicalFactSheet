//
//  GeographicalFactSheetTests.swift
//  GeographicalFactSheetTests
//
//  Created by Ashok Samal on 23/06/18.
//  Copyright © 2018 Ashok Samal. All rights reserved.
//

import XCTest
@testable import GeographicalFactSheet

class GeographicalFactSheetTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testResourceUrl() {
        let expectation = XCTestExpectation(description: "Check if URL is working. Download JSON Data.")
        let url = URL(string: kFactResourceEndpoint)!
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            XCTAssertNotNil(data, "Data couldn't be downloaded. Broken URL.")
            expectation.fulfill()
            
        }.resume()
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testServiceMethod() {
        FactSheetService.getFacts { (factSheet, error) in
            XCTAssertNotNil(factSheet, "Data not received via Service method.")
        }
    }
    
    func testViewSetup() {
        let factViewController = FactSheetViewController()
        XCTAssertTrue(factViewController.view.backgroundColor == #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), "View background color is not correct.")
        XCTAssertTrue(factViewController.factsTableView.superview == factViewController.view, "Table not present on the view.")
        XCTAssertTrue(factViewController.refresher.superview == factViewController.factsTableView, "Refresher not added to the table.")
    }
    
    func testTableCell() {
        let factCell = FactTableViewCell()
        XCTAssertTrue(factCell.containerView.superview == factCell.contentView, "Container view not added to cell.")
        XCTAssertTrue(factCell.factTitle.superview == factCell.containerView, "Title not added to cell.")
        XCTAssertTrue(factCell.factDescription.superview == factCell.containerView, "Description not added to cell.")
        XCTAssertTrue(factCell.factImage.superview == factCell.contentView, "Image not added to cell.")
        var sampleFact = Fact(title: "Title1", description: "Description1", imageHref: "http://farm4.static.flickr.com/3221/2658147888_826edc8465.jpg")
        factCell.fact = sampleFact
        XCTAssertTrue(factCell.factTitle.text == "Title1", "Title not set.")
        XCTAssertTrue(factCell.factDescription.text == "Description1", "Description not set.")
        XCTAssertTrue(factCell.factImage.image != nil, "Image not set.")
        sampleFact = Fact(title: nil, description: nil, imageHref: nil)
        factCell.fact = sampleFact
        XCTAssertTrue(factCell.factTitle.text == kBlankString, "Title should be blank.")
        XCTAssertTrue(factCell.factDescription.text == kNotAvailable, "Description should be 'Not Available'.")
        XCTAssertTrue(factCell.factImage.image == UIImage(named: kNullImagePlaceHolderName), "Placeholder image not set.")
    }
}
