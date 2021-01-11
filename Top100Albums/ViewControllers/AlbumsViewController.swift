//
//  ViewController.swift
//  Top100Albums
//
//  Created by chanakkya mati on 1/5/21.
//

import UIKit

class AlbumsViewController: UITableViewController {

    let viewModel: AlbumsFeedViewModelType
    let imageCache = ImageCache.shared

    // MARK: - Init
    init(viewModel: AlbumsFeedViewModelType = AlbumsFeedViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCellRegistarion()
        viewModelRegistrations()
        refresh()
    }

    private func viewModelRegistrations() {
        viewModel.OnFeedUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    private func setupView() {
        title = "Top 100 Albums"
        tableView.rowHeight = 67.0
        tableView.allowsMultipleSelection = false
        clearsSelectionOnViewWillAppear = true
    }

    private func setupCellRegistarion() {
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "AlbumTableViewCell")
    }

    func refresh() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.pinToSuperviewCenter(offsetX: 0, offsetY: 0)
        viewModel.fetchAlbums(success: { _ in
            activityIndicator.isHidden = true
        }, failure: { _ in
            activityIndicator.isHidden = true
        })
    }


}

extension AlbumsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfAlbums
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as? AlbumTableViewCell else {
            preconditionFailure("Programming error, cell should be of type AlbumTableViewCell")
        }
        cell.artistNameLabel.text = viewModel.albums[indexPath.row].artistName
        cell.albumNameLabel.text = viewModel.albums[indexPath.row].name
        return cell
    }
}

extension AlbumsViewController {
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let album = viewModel.album(at: indexPath)
        imageCache.load(url: album.artworkUrl100) { image in
            guard let cell = tableView.cellForRow(at: indexPath) as? AlbumTableViewCell else {
                return
            }
            cell.thumbnailImageView.image = image
        }
    }

    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        imageCache.cancelLoad(for: viewModel.album(at: indexPath).artworkUrl100)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = viewModel.album(at: indexPath)
        let detailViewModel = AlbumsDetailViewModel(album: album)
        let detailVC = AlbumsDetailViewController(viewModel: detailViewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
