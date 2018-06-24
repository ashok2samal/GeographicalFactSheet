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
        img.contentMode = .center //image gets center without any proportion change.
        img.translatesAutoresizingMaskIntoConstraints = false //Enables auto layout.
        return img
    }()
    
    let factTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 0 //Allows multiline.
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let factDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 0 //Allows multiline.
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
    
    //Adds the subviews to the content view of the cell & applies auto layout using SnapKit
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
    
    //Updates the cell with Fact data received from the controller.
    func updateCellWithData(fromItem fact: Fact) {
        if let imageURL = fact.imageHref {
            if FactSheetService.isConnectedToInternet {
                //SDWebImage: Fetches from memory if image is already cached, else sends a request for the image.
                //The placeholder image is shown for the time when images is being fetched or if the link is broken
                factImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: kPlaceholderImageName), options: [SDWebImageOptions.cacheMemoryOnly,SDWebImageOptions.allowInvalidSSLCertificates], completed: { (image, error, fetchedFrom, originalUrl) in
                    if error == nil {
                        self.factImage.image = image
                        if let tableView = self.superview as? UITableView {
                            if let indexPath = tableView.indexPath(for: self) {
                                tableView.reloadRows(at: [indexPath], with: .automatic)
                            }
                        }
                    }
                })
            } else {
                //No connection: Placeholder image is set & alert is shown
                factImage.image = UIImage(named: kPlaceholderImageName)
                ((window?.rootViewController as? UINavigationController)?.viewControllers[0] as? FactSheetViewController)?.showAlert(title: kConnectionErrorAlertTitle, message: kConnectionErrorAlertMessage)
            }
        } else {
            //When value for image key is null
            factImage.image = UIImage(named: kNullImagePlaceHolderName)
        }
        
        if let title = fact.title {
            factTitle.text = title
        } else {
            factTitle.text = kBlankString
        }
        if let description = fact.description {
            factDescription.text = description
            factDescription.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else {
            factDescription.text = kNotAvailable
            factDescription.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
}
