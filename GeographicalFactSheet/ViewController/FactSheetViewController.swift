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
        //TODO: Service call for fetching data and storing in facts array.
        factSheet = FactSheet(title: "Canada", rows: [Fact(title: "Title", description: "Description", imageHref: "Image Link")])
        if let factsArray = factSheet?.rows {
            self.facts = factsArray
        }
        factsTableView.reloadData()
    }
    
    func setupNavigationController() {
        navigationItem.title = factSheet?.title
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
}

extension FactSheetViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "factCell", for: indexPath)
        cell.textLabel?.text = facts[indexPath.row].title
        return cell
    }

}
