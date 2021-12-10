//
//  HomeViewController.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 08.12.2021.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    var onRepoOpen: ((String, String) -> Void)? { get set }
    var onUserOpen: ((String) -> Void)? { get set }
    var onReloadData: ((String, HomeViewSort, HomeViewOrder) -> Void)? { get set }
    var onShowSortOptions: VoidAction? { get set }
    
    func updateBy(_ model: HomeViewModel)
    func updateSort(_ sort: HomeViewSort)
}

class HomeViewController: UIViewController, HomeViewControllerProtocol {

    @IBOutlet private weak var queryBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var sortButton:  UIButton!
    @IBOutlet private weak var orderSwitcher:  OrderSwitcher!
    @IBOutlet private weak var messageLabel: UILabel!
    
    var onReloadData: ((String, HomeViewSort, HomeViewOrder) -> Void)?
    var onRepoOpen: ((String, String) -> Void)?
    var onUserOpen: ((String) -> Void)?
    var onShowSortOptions: VoidAction?
    
    private var model: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(RepositoriesListCell.self)
        queryBar.backgroundImage = UIImage()
        
        orderSwitcher.onChange = {
            [weak self] state in
            self?.handleOrderSwitch(state)
        }
        
        updateViews()
        messageLabel.text = "Please enter query to view repos".localized()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func updateBy(_ model: HomeViewModel) {
        self.model = model
        
        if isViewLoaded {
            updateViews()
        }
    }
    
    func updateSort(_ sort: HomeViewSort) {
        guard let model = model else { return }
        model.sort = sort
        updateSortTitle()
        
        let query = queryBar.text ?? ""
        if !query.isEmpty {
            onReloadData?(query, model.sort, model.order)
        }
    }
    
    @IBAction func sortTapped() {
        onShowSortOptions?()
    }
    
    private func updateSortTitle() {
        guard let model = model else { return }
        
        let sortTitle = "Sorted by ".localized() + model.sort.title
        sortButton.setTitle(sortTitle, for: .normal)
    }
    
    private func updateViews() {
        guard let model = model else { return }
        
        queryBar.text = model.query
        
        switch model.order {
        case .descending:
            orderSwitcher.state = .descending
        case .ascending:
            orderSwitcher.state = .ascending
        }
        
        updateSortTitle()
        
        tableView.isHidden = model.repos.isEmpty
        tableView.reloadData()
    }
    
    private func handleOrderSwitch(_ state: OrderSwitcherState) {
        
        guard let model = model else { return }
        
        switch state {
        case .descending:
            model.order = .descending
        case .ascending:
            model.order = .ascending
        }
        
        if !model.query.isEmpty {
            onReloadData?(model.query, model.sort, model.order)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.repos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = model else { return UITableViewCell() }
        let repo = model.repos[indexPath.row]
        let cell = tableView.dequeue(model: repo)
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let model = model else { return }
        let repo = model.repos[indexPath.row]
        onRepoOpen?(repo.name, repo.ownerName)
    }
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let model = model else { return }
        
        searchBar.resignFirstResponder()
        
        let query = searchBar.text ?? ""
        onReloadData?(query, model.sort, model.order)
    }
}

extension HomeViewController: RepositoriesListCellDelegate {
    func userAvatarDidTapped(_ name: String) {
        onUserOpen?(name)
    }
}
