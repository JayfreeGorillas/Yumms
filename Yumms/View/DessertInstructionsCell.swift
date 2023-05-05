//
//  DessertInstructionsCell.swift
//  Yumms
//
//  Created by Josfry Barillas on 5/1/23.
//

import UIKit

class DessertInstructionsCell: UITableViewCell {
    var instructionsLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(instructionsLabel)
        
        configureInstructionsLabel()
        setIntstructionsLabelConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInstructionsCell(instructions: String) {
        instructionsLabel.text = instructions
    }
    func configureInstructionsLabel() {
        instructionsLabel.numberOfLines = 0
        instructionsLabel.adjustsFontSizeToFitWidth = true
    }

    
    func setIntstructionsLabelConstraints() {
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            instructionsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            instructionsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            instructionsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            instructionsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }

}
