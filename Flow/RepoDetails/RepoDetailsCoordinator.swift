//
//  RepoDetailsCoordinator.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 10.12.2021.
//

import UIKit
import MBProgressHUD

class RepoDetailsCoordinator: Coordinator {
    var childs = [Coordinator]()
    var navigation: UINavigationController
    
    var onUserOpen: ((String) -> Void)?
    
    var repoName: String
    var ownerName: String
    
    private var hud: MBProgressHUD? = nil
    private var interactor: RepoDetailsInteractorProtocol = RepoDetailsInteractor()
    private var detailsController: RepoDetailsViewControllerProtocol? {
        navigation.topViewController as? RepoDetailsViewControllerProtocol
    }
    
    init(navigation: UINavigationController, repoName: String, ownerName: String) {
        self.navigation = navigation
        self.repoName = repoName
        self.ownerName = ownerName
        interactor.delegate = self
    }
    
    func start() {
        let vc = RepoDetailsViewController.instantiate()
        
        vc.onExternalDetailsShowing = {
            link in
            
            if let url = URL(string: link) {
                UIApplication.shared.open(url)
            }
        }
        
        vc.onUserOpen = onUserOpen
        
        navigation.pushViewController(vc, animated: false)
        hud = MBProgressHUD.showAdded(
            to: self.navigation.view,
            animated: true)
        interactor.requestDetails(repoName: repoName, ownerName: ownerName)
    }
}

extension RepoDetailsCoordinator: RepoDetailsInteractorDelegate {
    
    func interactorFinishWithError(_ message: String) {
        hud?.hide(animated: true)
        showError(message)
    }

    func intercatoFinishSuccessfully(_ model: RepoDetailsViewModel) {
        detailsController?.updateBy(model)
        hud?.hide(animated: true)
    }
}
