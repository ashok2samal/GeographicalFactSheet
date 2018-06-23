//
//  FactTableViewCell.swift
//  GeographicalFactSheet
//
//  Created by Ashok Samal on 23/06/18.
//  Copyright © 2018 Ashok Samal. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

class FactTableViewCell: UITableViewCell {
    
    let factImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .center
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let factTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let factDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var fact: Fact? {
        didSet {
            guard let factItem = fact else { return }
            updateCellWithData(fromItem: factItem)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutChildViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func layoutChildViews() {
        self.contentView.addSubview(factImage)
        containerView.addSubview(factTitle)
        containerView.addSubview(factDescription)
        self.contentView.addSubview(containerView)
        
        factImage.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(8)
            make.centerX.equalTo(contentView.snp.centerX)
            make.bottom.equalTo(containerView.snp.top).offset(-8)
        }
        factTitle.snp.makeConstraints { (make) in
            make.top.equalTo(containerView).offset(8)
            make.left.equalTo(containerView).offset(8)
            make.right.equalTo(containerView).offset(-8)
            make.bottom.equalTo(factDescription.snp.top).offset(-8)
        }
        factDescription.snp.makeConstraints { (make) in
            make.top.equalTo(factTitle.snp.bottom).offset(8)
            make.left.equalTo(containerView).offset(8)
            make.right.equalTo(containerView).offset(-8)
            make.bottom.equalTo(containerView).offset(-8)
        }
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(factImage.snp.bottom).offset(8)
            make.left.equalTo(contentView).offset(0)
            make.right.equalTo(contentView).offset(0)
            make.bottom.equalTo(contentView).offset(0)
        }
    }
    
    func updateCellWithData(fromItem fact: Fact) {
        if let imageURL = fact.imageHref {
            self.factImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"), options: [SDWebImageOptions.cacheMemoryOnly,SDWebImageOptions.allowInvalidSSLCertificates], completed: { (image, error, fetchedFrom, originalUrl) in
                if error == nil {
                    if image != nil {
                        self.factImage.image = image
                    }
                    else {
                        self.factImage.image = UIImage(named: "placeholder.png")
                    }
                    if let tableView = self.superview as? UITableView {
                        if let indexPath = tableView.indexPath(for: self) {
                            tableView.reloadRows(at: [indexPath], with: .automatic)
                        }
                    }
                }
                
            })
        } else {
            self.factImage.image = UIImage(named: "placeholder.png")
        }
        if let title = fact.title {
            self.factTitle.text = title
        } else {
            self.factTitle.text = ""
        }
        if let description = fact.description {
            self.factDescription.text = description
        } else {
            self.factDescription.text = ""
        }
    }
}
