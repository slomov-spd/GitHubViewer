//
//  UserDetailsViewController.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 10.12.2021.
//

import UIKit

protocol UserDetailsViewControllerProtocol {
    var onExternalDetailsShowing: StringAction? { get set }
    
    func updateBy(_ model: UserDetailsViewModel)
}

class UserDetailsViewController: UIViewController, UserDetailsViewControllerProtocol {
    
    private enum Layout {
        static let avatarSize: CGFloat = 300
    }
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var goToHubButton: UIButton!
    
    var onExternalDetailsShowing: StringAction?
    private var model: UserDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(KeyValueCell.self)
        tableView.register(ImageCell.self)
        
        goToHubButton.setTitle(
            "Look user on GitHub".localized(),
            for: .normal)
    }
    
    func updateBy(_ model: UserDetailsViewModel) {
        self.model = model
        title = model.name
        
        if isViewLoaded {
            tableView.reloadData()
        }
    }
    
    @IBAction func lookAtHubTapped() {
        guard let model = model else { return }
        onExternalDetailsShowing?(model.externalUrl)
    }
}

extension UserDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (model?.info.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return avatarCell()
        } else {
            return infoCell(indexPath.row - 1)
        }
    }
    
    private func avatarCell() -> UITableViewCell {
        guard let model = model else {
            return UITableViewCell()
        }
        
        let avatarModel = ImageCellViewModel(
            size: Layout.avatarSize,
            imageUrl: model.avatarUrl)
        let cell = tableView.dequeue(model: avatarModel)
        return cell ?? UITableViewCell()
    }
    
    private func infoCell(_ index: Int) -> UITableViewCell {
        guard let model = model?.info[index] else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeue(model: model)
        return cell ?? UITableViewCell()
    }
}

