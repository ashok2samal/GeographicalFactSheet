//
//  FactSheetViewController.swift
//  GeographicalFactSheet
//
//  Created by Ashok Samal on 23/06/18.
//  Copyright © 2018 Ashok Samal. All rights reserved.
//

import UIKit
import SDWebImage

class FactSheetViewController: UIViewController {

    private var factSheet: FactSheet?
    private var facts: [Fact] = []
    let factsTableView = UITableView()
    
    lazy var refresher: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action:
            #selector(FactSheetViewController.pullDownRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refresher.tintColor = UIColor.blue
        return refresher
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(factsTableView)
        setupNavigationController()
        setup(tableView: factsTableView)
        downloadFactsData()
    }
    
    //Calls service class method for downloading the json data. Then stores them in model objects & reloads the table.
    //Incase of network issue shows alert to the user.
    func downloadFactsData() {
        if FactSheetService.isConnectedToInternet {
            FactSheetService.getFacts() { (result) in
                self.factSheet = result
                if let factsArray = self.factSheet?.rows {
                    self.facts = factsArray.filter({ (fact) -> Bool in
                        fact.title != nil
                    })
                }
                self.navigationItem.title = self.factSheet?.title
                self.factsTableView.reloadData()
            }
        } else {
            showAlert()
        }
    }
    
    //Prepares an Alert & presents.
    func showAlert()
    {
        let alert = UIAlertController(title: kConnectionErrorAlertTitle,
                                      message: kConnectionErrorAlertMessage,
                                      preferredStyle: .alert)
    
        let retryButton = UIAlertAction(title: kAlertRetryButtonText, style: UIAlertActionStyle.default, handler: { action in
            self.downloadFactsData()
        })
        alert.addAction(retryButton)
        self.present(alert, animated: true, completion:nil)
    }
    
    //This func gets called when user pulls down on table view to refresh
    @objc func pullDownRefresh(_ refreshControl: UIRefreshControl) {
        refresh()
        refreshControl.endRefreshing()
    }
    
    //Clears stored images & reloads all data.
    @objc func refresh() {
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk()
        downloadFactsData()
    }
    
    //Sets up the navigation controller during view load.
    func setupNavigationController() {
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) ]
        let refreshButton = UIBarButtonItem(image: UIImage(named: kRefreshImageName), style: .plain, target: self, action: #selector(FactSheetViewController.refresh))
        self.navigationItem.rightBarButtonItem  = refreshButton
    }
    
    //Sets up the table view during view load.
    func setup(tableView: UITableView) {
        tableView.dataSource = self
        tableView.register(FactTableViewCell.self, forCellReuseIdentifier: kCustomTableViewCellIdentifier)
        setupConstraints(forTable: tableView)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.addSubview(refresher)
    }
    
    //Sets the auto layout constraints for the table view.
    func setupConstraints(forTable tableView: UITableView) {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

//Separate container for the table view datasource methods.
extension FactSheetViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: kCustomTableViewCellIdentifier, for: indexPath) as? FactTableViewCell {
            cell.fact = facts[indexPath.row] //The 'fact' when set assigns the values to the other elements in the cell.
            return cell
        }
        return tableCell
    }

}
