//
//  RepoDetailsViewController.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 10.12.2021.
//

import UIKit

protocol RepoDetailsViewControllerProtocol {
    var onExternalDetailsShowing: StringAction? { get set }
    var onUserOpen: ((String) -> Void)? { get set }
    
    func updateBy(_ model: RepoDetailsViewModel)
}

class RepoDetailsViewController: UIViewController, RepoDetailsViewControllerProtocol {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var goToHubButton: UIButton!
    
    var onExternalDetailsShowing: StringAction?
    var onUserOpen: ((String) -> Void)?
    
    private var model: RepoDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(KeyValueCell.self)
        tableView.register(RepoOwnerCell.self)
        
        goToHubButton.setTitle(
            "Look repository on GitHub".localized(),
            for: .normal)
    }
    
    func updateBy(_ model: RepoDetailsViewModel) {
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

extension RepoDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (model?.info.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return authorCell()
        } else {
            return infoCell(indexPath.row - 1)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let owner = model?.owner.name,
           indexPath.row == 0 {
            onUserOpen?(owner)
        }
        
    }
    
    private func authorCell() -> UITableViewCell {
        guard let model = model else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeue(model: model.owner)
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
