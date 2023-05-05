//
//  DessertDetailsViewController.swift
//  Yumms
//
//  Created by Josfry Barillas on 4/29/23.
//

import UIKit

class DessertDetailsViewController: UIViewController {
    
    var dessertImage = UIImageView()
    var tableView = UITableView()
    var dessertIngredients = [Ingredients]()
    var instructions = ""
    var label = " Instructions"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    // TableView setup
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewProtocols()
        tableView.rowHeight = 100
        tableView.register(DessertInstructionsCell.self, forCellReuseIdentifier: "instructions")
        tableView.register(IngredientCell.self, forCellReuseIdentifier: "ingredient")
        tableViewConstraints()
    }
    
    func setTableViewProtocols() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}

// MARK: Delegate and Datasource set up
extension DessertDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else if (section == 1) {
            
            return dessertIngredients.count
        }
        return dessertIngredients.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section != 0 {
            let headerTitle = "Ingredients"
            return headerTitle
        }
        return "Instructions"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let instructionsCell = tableView.dequeueReusableCell(withIdentifier: "instructions") as! DessertInstructionsCell
            instructionsCell.setupInstructionsCell(instructions: instructions)
            instructionsCell.instructionsLabel.text = instructions
            instructionsCell.selectionStyle = .none
            
            return instructionsCell
        } else {
            let ingredientCell = tableView.dequeueReusableCell(withIdentifier: "ingredient") as! IngredientCell
            ingredientCell.setupIngredientCell(from: dessertIngredients[indexPath.row])
            ingredientCell.selectionStyle = .none
            
            return ingredientCell
        }
        
    }
}
