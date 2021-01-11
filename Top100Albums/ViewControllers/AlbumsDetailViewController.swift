//
//  AlbumsDetailViewController.swift
//  Top100Albums
//
//  Created by chanakkya mati on 1/10/21.
//

import Foundation
import UIKit

class AlbumsDetailViewController: UIViewController {

    lazy private(set) var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10.0
        stack.alignment = .top
        stack.distribution = .fill
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return stack
    }()

    lazy private(set) var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.pin(height: 200.0)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    lazy private(set) var albumNameLabel = UILabel.multiLineLabel()
    lazy private(set) var artistNameLabel = UILabel.multiLineLabel()
    lazy private(set) var genreLabel = UILabel.multiLineLabel()
    lazy private(set) var releaseDateLabel = UILabel.multiLineLabel()
    lazy private(set) var copyrightInfoLabel = UILabel.multiLineLabel()
    lazy private(set) var itunesButton: UIButton = {
        let button = UIButton(type: .system,
                              primaryAction: UIAction(title: "Go to itunes",
                                                      handler: { _ in
                                                        UIApplication.shared.open(self.viewModel.itunesStoreLink, options: [:], completionHandler: nil)
        }))
        button.pin(height: 40.0)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.0
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    let viewModel: AlbumsDetailViewModel

    init(viewModel: AlbumsDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        updateView()
    }

    func setupView() {
        title = viewModel.albumName
        view.addSubview(stack)
        view.backgroundColor = UIColor.white
        stack.pinToSafeArea(leading: 0, top: 0, trailing: 0)
        stack.addArrangedSubviews(imageView,
                                  albumNameLabel,
                                  artistNameLabel,
                                  genreLabel,
                                  releaseDateLabel,
                                  copyrightInfoLabel,
                                  UIView())
        view.addSubview(itunesButton)

        itunesButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 10.0).isActive = true
        itunesButton.pinToSafeArea(leading: 20, trailing: 20, bottom: 20)
    }

    func updateView() {
        albumNameLabel.text = viewModel.albumNameField
        artistNameLabel.text = viewModel.artistName
        copyrightInfoLabel.text = viewModel.copyright
        releaseDateLabel.text = viewModel.releseDate
        genreLabel.text = viewModel.genre
        viewModel.getImage { [weak self] in
            self?.imageView.image = $0
        }
    }

    @objc
    func openITunesStoreClicked(_ sender: Any) {

    }

}
