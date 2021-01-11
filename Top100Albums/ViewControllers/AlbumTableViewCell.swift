//
//  AlbumTableViewCell.swift
//  Top100Albums
//
//  Created by chanakkya mati on 1/9/21.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10.0
        stack.isLayoutMarginsRelativeArrangement = true
        stack.alignment = .top
        return stack
    }()
    private let labelContainerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10.0
        return stack
    }()
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.pin(height: 40.0, width: 40.0)
        imageView.backgroundColor = UIColor.blue
        return imageView
    }()
    let albumNameLabel = UILabel()
    let artistNameLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        thumbnailImageView.image = nil
    }

    private func setupView() {
        contentView.addSubview(stack)
        stack.pinToSuperView()
        stack.addArrangedSubviews(thumbnailImageView, labelContainerStack)
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        labelContainerStack.addArrangedSubviews(albumNameLabel, artistNameLabel)
    }

}


