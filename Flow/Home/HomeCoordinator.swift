//
//  HomeCoordinator.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 08.12.2021.
//

import UIKit
import MBProgressHUD

class HomeCoordinator: Coordinator {
    var childs = [Coordinator]()
    var navigation: UINavigationController
    
    var onRepoOpen: ((String, String) -> Void)?
    var onUserOpen: ((String) -> Void)?
    
    private var hud: MBProgressHUD? = nil
    private var interactor: HomeInteractorProtocol = HomeInteractor()
    private var homeController: HomeViewControllerProtocol? {
        navigation.topViewController as? HomeViewControllerProtocol
    }
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
        interactor.delegate = self
    }
    
    func start() {
        let initialModel = HomeViewModel()
        initialModel.order = .descending
        initialModel.sort = .updated
        initialModel.query = ""
        
        let vc = HomeViewController.instantiate()
        vc.updateBy(initialModel)
        
        vc.onReloadData = {
            [weak self] query, sort, order in
            
            guard let self = self else { return }
            
            self.hud = MBProgressHUD.showAdded(
                to: self.navigation.view,
                animated: true)
            self.interactor.getRepositories(
                query: query,
                sort: sort,
                order: order)
        }
        
        vc.onShowSortOptions = {
            [weak self] in
            
            self?.showSortOptions()
        }
        
        vc.onRepoOpen = onRepoOpen
        vc.onUserOpen = onUserOpen
        
        navigation.pushViewController(vc, animated: false)
    }
    
    private func showSortOptions() {
        let message = "Please select sort".localized()
        let alert = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: .actionSheet)
        
        let forks = UIAlertAction(
            title: "By forks count".localized(),
            style: .default) {
                [weak self] _ in
                self?.homeController?.updateSort(.forks)
            }
        
        let stars = UIAlertAction(
            title: "By stars count".localized(),
            style: .default) {
                [weak self] _ in
                self?.homeController?.updateSort(.stars)
            }
        
        let update = UIAlertAction(
            title: "By last update".localized(),
            style: .default) {
                [weak self] _ in
                self?.homeController?.updateSort(.updated)
            }
        
        let cancel = UIAlertAction(
            title: "Cancel".localized(),
            style: .cancel)
        
        alert.addAction(stars)
        alert.addAction(forks)
        alert.addAction(update)
        alert.addAction(cancel)
        
        navigation.present(alert, animated: true)
    }
}

extension HomeCoordinator: HomeInteractorDelegate {
    
    func interactorFinishWithError(_ message: String) {
        hud?.hide(animated: true)
        showError(message)
    }

    func intercatoFinishSuccessfully(_ model: HomeViewModel) {
        homeController?.updateBy(model)
        hud?.hide(animated: true)
    }
}
