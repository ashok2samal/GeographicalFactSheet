//
//  FactSheetViewController.swift
//  GeographicalFactSheet
//
//  Created by Ashok Samal on 23/06/18.
//  Copyright © 2018 Ashok Samal. All rights reserved.
//

import UIKit

class FactSheetViewController: UIViewController,UITableViewDataSource {

    let factsTableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        view.addSubview(factsTableView)
        setupNavigationController()
        setup(tableView: factsTableView)
    }

    func setupNavigationController() {
        navigationItem.title = "Canada"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.foregroundColor:#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) ]
    }
    
    func setup(tableView: UITableView) {
        tableView.dataSource = self
        factsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "factCell")
        setupConstraints(forTable: tableView)
    }
    
    func setupConstraints(forTable tableView: UITableView) {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "factCell", for: indexPath)
        cell.textLabel?.text = "Test"
        return cell
    }
}

