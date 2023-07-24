//
//  BrowseCoordinator.swift
//  KatTok
//
//  Created by 김요한 on 2023/07/23.
//

import Foundation
import UIKit

class BrowseCoordinator: CoordinatorProtocol {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators: [CoordinatorProtocol] = []
    
    var type: CoordinatorType = .browse
    
    var navigation: UINavigationController
    
    var presenterController: UIViewController?
    
    init(navigation : UINavigationController) {
        self.navigation = navigation
    }
    
    convenience init(presenterController: UIViewController?) {
        self.init(navigation: UINavigationController())
        
        self.presenterController = presenterController
    }
    
    func start() {
        self.showBrowseView()
    }
    
    private func showBrowseView() {
        let container = DIContainer.shared.container
        guard let vm = container.resolve(BrowseViewModel.self) else { return }
        
        let vc = BrowseViewController(viewModel: vm)
        
//        vm.setActions(
//            actions: PhotoListViewModelActions(
//                showPhotoDetail: self.showPhotoDetail
//            )
//        )
        
        self.navigation.pushViewController(vc, animated: true)
    }
    
//    lazy var showPhotoDetail: (_ IndexPath: IndexPath) -> Void = { [weak self] indexPath in
//        let container = DIContainer.shared.container
//        guard let vm = container.resolve(PhotoDetailViewModel.self) else { return }
//        vm.indexpath = indexPath
//        let vc = PhotoDetailViewController(viewModel: vm)
////        self?.navigation.present(vc, animated: true)
//        self?.navigation.pushViewController(vc, animated: true)
//    }
}

extension BrowseCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinished(childCoordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter {
            $0.type != childCoordinator.type
        }
    }
    
    
}
