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
    
    let view = UIView()
    let parentStackView = UIStackView()
    let stackView = UIStackView()
    let titlePriceStackView = UIStackView()
    
    let itemImageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 170, height: 170))
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
        label.text = "Urgent Item"
        label.textColor = .red
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var item: Item! {
        didSet {
            titleLabel.text = item.title
            categoryLabel.text = "category"
            priceLabel.text = "\(item.price ?? 0.0)€"
            urgentLabel.isHidden = !item.is_urgent!
            itemImageView.load(url: URL(string: item.images_url?.small ?? "")!)
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
        addStackView(stackView: stackView)
       addTitlePriceStackView(titlePriceStackView: titlePriceStackView)
       
        stackView.addArrangedSubview(titlePriceStackView)
        stackView.addArrangedSubview(categoryLabel)
        stackView.addArrangedSubview(urgentLabel)
        setStackViewItemsConstraints()
    }
    
    func addBaseView(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        self.addSubview(view)
        view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        view.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        view.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        view.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        view.cornerRadius(radius: 8)
    }
    
    func addParentStackView(parentStackView: UIStackView) {
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.spacing = 10
        parentStackView.axis = .horizontal
        parentStackView.distribution = .fill
        parentStackView.alignment = .center
        view.addSubview(parentStackView)
        parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        parentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        parentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        parentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func addStackView(stackView: UIStackView) {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.axis = .vertical
        parentStackView.addArrangedSubview(itemImageView)
        parentStackView.addArrangedSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    }
    
    func addTitlePriceStackView(titlePriceStackView: UIStackView) {
        titlePriceStackView.axis = .vertical
        titlePriceStackView.spacing = 8
        titlePriceStackView.distribution = .fillProportionally
        titlePriceStackView.addArrangedSubview(titleLabel)
        titlePriceStackView.addArrangedSubview(priceLabel)
    }
    
    func setStackViewItemsConstraints() {

        urgentLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
   
        itemImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        itemImageView.widthAnchor.constraint(equalToConstant: 130).isActive = true
        itemImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
