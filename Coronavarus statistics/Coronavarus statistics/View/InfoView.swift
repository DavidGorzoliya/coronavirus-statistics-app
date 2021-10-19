//
//  InfoView.swift
//  Coronavarus statistics
//
//  Created by David on 1/1/21.
//

import UIKit

final class InfoView: UIView {

    private let captionLabel: UILabel = {
        let captionLabel = UILabel()
        captionLabel.text = "—"
        captionLabel.font = UIFont.boldSystemFont(ofSize: 26)
        
        return captionLabel
    }()
    
    let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "—"
        textLabel.font = textLabel.font.withSize(18)
        
        return textLabel
    }()

    init(frame: CGRect = .zero, caption: String) {
        super.init(frame: frame)
        captionLabel.text = caption
        self.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubviews() {
        addSubview(captionLabel)
        captionLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 6, paddingLeft: 6)
        addSubview(textLabel)
        textLabel.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, paddingTop: 6, paddingLeft: 7)
    }
}
