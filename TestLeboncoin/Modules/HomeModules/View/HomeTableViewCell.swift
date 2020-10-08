//
//  HomeTableViewCell.swift
//  TestLeboncoin
//
//  Created by Stimlog on 06/10/2020.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(displayP3Red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.cornerRadius(radius: 8)
        return view
    }()
    
    let parentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    let infosStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.axis = .vertical
        return stackView
    }()
    
    let titlePriceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let itemImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "leboncoinBanner")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "hello"
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "1$"
        label.textColor = .systemGreen
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let urgentLabel: UILabel = {
        let label = UILabel()
        label.text = "Article Urgent"
        label.textColor = .red
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var item: Item! {
        didSet {
            titleLabel.text = item.title
            priceLabel.text = "\(item.price ?? 0.0)€"
            urgentLabel.isHidden = !item.is_urgent!
            itemImageView.image = UIImage(named: "leboncoinBanner")
            if let url = URL(string: item.images_url?.small ?? "") {
                itemImageView.loadWithAnimation(url: url)
            }
        }
    }
    
    var category: Category! {
        didSet {
            categoryLabel.text = category.name
        }
    }
    
    func setupView() {
        addBaseView(view: view)
        addParentStackView(parentStackView: parentStackView)
        addStackView(stackView: infosStackView)
        addTitlePriceStackView(titlePriceStackView: titlePriceStackView)
        
        infosStackView.addArrangedSubview(titlePriceStackView)
        infosStackView.addArrangedSubview(categoryLabel)
        infosStackView.addArrangedSubview(urgentLabel)
        setInfosStackViewItemsConstraints()
    }
    
    func addBaseView(view: UIView) {
        self.addSubview(view)
        view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        view.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        view.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        view.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
    
    func addParentStackView(parentStackView: UIStackView) {
        view.addSubview(parentStackView)
        parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        parentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        parentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        parentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func addStackView(stackView: UIStackView) {
        parentStackView.addArrangedSubview(itemImageView)
        parentStackView.addArrangedSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    }
    
    func addTitlePriceStackView(titlePriceStackView: UIStackView) {
        titlePriceStackView.addArrangedSubview(titleLabel)
        titlePriceStackView.addArrangedSubview(priceLabel)
    }
    
    func setInfosStackViewItemsConstraints() {
        urgentLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        itemImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        itemImageView.widthAnchor.constraint(equalToConstant: 130).isActive = true
        itemImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        itemImageView.image = nil
    }
}
