//
//  DessertCell.swift
//  Yumms
//
//  Created by Josfry Barillas on 4/28/23.
//

import UIKit

class DessertCell: UITableViewCell {

    var dessertNameLabel = UILabel()
    var dessertImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(dessertImageView)
        contentView.addSubview(dessertNameLabel)

        configureDessertImage()
        setImageConstraints()
        setLabelConstraints()
        configureNameLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDessertCell(dessert: Dessert) {
        guard let icon = dessert.strMealThumb else { return }
        dessertNameLabel.text = dessert.strMeal
        dessertImageView.downloaded(from: icon)
    }
// Setting Properties
    func configureNameLabel() {
        dessertNameLabel.numberOfLines = 0
        dessertNameLabel.adjustsFontSizeToFitWidth = true
        dessertNameLabel.textColor = .white
        dessertNameLabel.adjustsFontSizeToFitWidth = true
        dessertNameLabel.font = .italicSystemFont(ofSize: 40)
    }
    
    func configureDessertImage() {
        dessertImageView.layer.cornerRadius = 10
        dessertImageView.clipsToBounds = true
        dessertImageView.image = .checkmark
    }
// Setting Constraints
    func setImageConstraints() {
        dessertImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dessertImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            dessertImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            dessertImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            dessertImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    

    func setLabelConstraints() {
        dessertNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dessertNameLabel.leadingAnchor.constraint(equalTo: dessertImageView.leadingAnchor, constant: 5),
            dessertNameLabel.heightAnchor.constraint(equalToConstant: 40),
            dessertNameLabel.trailingAnchor.constraint(equalTo: dessertImageView.trailingAnchor, constant: -5),
            dessertNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

}
