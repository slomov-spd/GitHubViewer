//
//  UserDetailsCoordinator.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 10.12.2021.
//

import UIKit
import MBProgressHUD

class UserDetailsCoordinator: Coordinator {
    var childs = [Coordinator]()
    var navigation: UINavigationController
    
    var login: String
    
    private var hud: MBProgressHUD? = nil
    private var interactor: UserDetailsInteractorProtocol = UserDetailsInteractor()
    private var detailsController: UserDetailsViewControllerProtocol? {
        navigation.topViewController as? UserDetailsViewControllerProtocol
    }
    
    init(navigation: UINavigationController, login: String) {
        self.navigation = navigation
        self.login = login
        interactor.delegate = self
    }
    
    func start() {
        let vc = UserDetailsViewController.instantiate()
        
        vc.onExternalDetailsShowing = {
            link in
            
            if let url = URL(string: link) {
                UIApplication.shared.open(url)
            }
        }
        
        navigation.pushViewController(vc, animated: false)
        hud = MBProgressHUD.showAdded(
            to: self.navigation.view,
            animated: true)
        interactor.requestDetails(login: login)
    }
}

extension UserDetailsCoordinator: UserDetailsInteractorDelegate {
    
    func interactorFinishWithError(_ message: String) {
        hud?.hide(animated: true)
        showError(message)
    }

    func intercatoFinishSuccessfully(_ model: UserDetailsViewModel) {
        detailsController?.updateBy(model)
        hud?.hide(animated: true)
    }
}

