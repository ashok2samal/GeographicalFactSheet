//
//  FactSheetViewController.swift
//  GeographicalFactSheet
//
//  Created by Ashok Samal on 23/06/18.
//  Copyright © 2018 Ashok Samal. All rights reserved.
//

import UIKit

class FactSheetViewController: UIViewController {

    private var factSheet: FactSheet?
    private var facts: [Fact] = []
    let factsTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(factsTableView)
        setupNavigationController()
        setup(tableView: factsTableView)
        downloadFactsData()
    }
    
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
    
    func setupNavigationController() {
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) ]
    }
    
    func setup(tableView: UITableView) {
        tableView.dataSource = self
        tableView.register(FactTableViewCell.self, forCellReuseIdentifier: kCustomTableViewCellIdentifier)
        setupConstraints(forTable: tableView)
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func setupConstraints(forTable tableView: UITableView) {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension FactSheetViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: kCustomTableViewCellIdentifier, for: indexPath) as? FactTableViewCell {
            cell.fact = facts[indexPath.row]
            return cell
        }
        return tableCell
    }

}
