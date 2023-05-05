//
//  IngredientCell.swift
//  Yumms
//
//  Created by Josfry Barillas on 5/1/23.
//

import UIKit

class IngredientCell: UITableViewCell {

    var ingredientLabel = UILabel()
    var measurementLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(ingredientLabel)
        contentView.addSubview(measurementLabel)
        
        configureIngredientLabel()
        configureMeasurementLabel()
        setMeasurementLabelConstraints()
        setIngredientLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupIngredientCell(from dessert: Ingredients) {
        ingredientLabel.text = dessert.ingredient
        measurementLabel.text = dessert.measureMent
    }
    // Setting properties
    func configureIngredientLabel() {
        ingredientLabel.numberOfLines = 0
        ingredientLabel.adjustsFontSizeToFitWidth = true
        ingredientLabel.font = .italicSystemFont(ofSize: 16)
    }
    
    func configureMeasurementLabel() {
        measurementLabel.numberOfLines = 0
        measurementLabel.adjustsFontSizeToFitWidth = true
        measurementLabel.font = .italicSystemFont(ofSize: 16)
    }
    
    // Setting Constraints
    func setIngredientLabelConstraints() {
        ingredientLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ingredientLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            ingredientLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15)
        ])
    }

    func setMeasurementLabelConstraints() {
        measurementLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            measurementLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            measurementLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            measurementLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

    }

}
