//
//  CountryCell.swift
//  Coronavarus statistics
//
//  Created by David on 1/1/21.
//

import UIKit

class CountryCell: UITableViewCell {

    // MARK: - Properties
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        return nameLabel
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureSubviews() {
        contentView.addSubview(nameLabel)
        nameLabel.centerY(inView: contentView, leftAnchor: contentView.leftAnchor, paddingLeft: 8)
    }
    
    func set(countryName: String) {
        nameLabel.text = countryName
    }
    
}
