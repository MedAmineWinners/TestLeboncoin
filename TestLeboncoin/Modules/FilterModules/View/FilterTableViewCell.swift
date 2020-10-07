//
//  FilterTableViewCell.swift
//  TestLeboncoin
//
//  Created by Stimlog on 07/10/2020.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let stackView = UIStackView()
    
    let categoryImageView: UIImageView = {
        let image = UIImageView()
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
    

    
    var category: Category! {
        didSet {
            categoryLabel.text = category.name
            categoryImageView.image = UIImage(named: "\(category.id!)")
        }
    }
    
    func setupView() {
        addStackView(stackView: stackView)
        stackView.addArrangedSubview(categoryImageView)
        stackView.addArrangedSubview(categoryLabel)
        categoryImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        categoryImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        categoryImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
    }
    
    func addStackView(stackView: UIStackView) {
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.spacing = 20
        stackView.axis = .horizontal
       
    }
}
