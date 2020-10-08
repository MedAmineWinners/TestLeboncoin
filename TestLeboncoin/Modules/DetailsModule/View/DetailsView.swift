//
//  DetailsView.swift
//  TestLeboncoin
//
//  Created by Stimlog on 08/10/2020.
//

import UIKit

class DetailsView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }
    
    func createSubviews() {
        // create and add scroll View
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        // create and add parent stackView
        let parentStackView = UIStackView()
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.axis = .vertical
        parentStackView.spacing = 20
        scrollView.addSubview(parentStackView)
        parentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        parentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        parentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        parentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        // create and add header stackView
        let headerStackView = UIStackView()
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.axis = .vertical
        headerStackView.spacing = 8
        parentStackView.addArrangedSubview(headerStackView)
        headerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        headerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        // add itemImageView and constraints
        headerStackView.addArrangedSubview(itemImageView)
        itemImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        itemImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        itemImageView.heightAnchor.constraint(equalTo: itemImageView.widthAnchor, multiplier: 0.8).isActive = true
        
        // add titleLabel and constraints
        headerStackView.addArrangedSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        // add priceLabel and constraints
        headerStackView.addArrangedSubview(priceLabel)
        priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        // add date and state stackView and components
        let dateStateStackView = UIStackView()
        dateStateStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.addArrangedSubview(dateStateStackView)
        dateStateStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        dateStateStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        dateStateStackView.addArrangedSubview(dateLabel)
        dateStateStackView.addArrangedSubview(urgentLabel)
        
        // add description stackview and omponents
        let descriptionStackView = UIStackView()
        descriptionStackView.axis = .vertical
        descriptionStackView.spacing = 10
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.addArrangedSubview(descriptionStackView)
        descriptionStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        descriptionStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        descriptionStackView.addArrangedSubview(separatorView)
        descriptionStackView.addArrangedSubview(titleDescriptionLabel)
        descriptionStackView.addArrangedSubview(descriptionLabel)
        separatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let urgentLabel: UILabel = {
        let label = UILabel()
        label.text = "Article Urgent"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .systemRed
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let itemImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "leboncoinBanner")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let urgentIcon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "urgentIcon"), for: .normal)
        return button
    }()
}
