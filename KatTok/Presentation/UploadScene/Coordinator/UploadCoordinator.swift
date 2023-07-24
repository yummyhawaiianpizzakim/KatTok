//
//  UploadCoordinator.swift
//  KatTok
//
//  Created by 김요한 on 2023/07/23.
//

import Foundation
import UIKit

class UploadCoordinator: CoordinatorProtocol {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators: [CoordinatorProtocol] = []
    
    var type: CoordinatorType = .upload
    
    var navigation: UINavigationController?
    
    weak var presenterController: UIViewController?
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    init() {
        self.navigation = .init()
    }
    
    convenience init(presenterController: UIViewController?) {
        self.init(navigation: UINavigationController())
        
        self.presenterController = presenterController
    }
    
    
    func start() {
        self.showUploadView()
    }
    
    private func showUploadView() {
//        let uploadShortsCoordinator = UploadShortsCoordinator()
//        uploadShortsCoordinator.start()
//        uploadShortsCoordinator.finishDelegate = self
//        self.childCoordinators.append(uploadShortsCoordinator)
        let container = DIContainer.shared.container
        guard let vm = container.resolve(UploadViewModel.self) else { return }
        let vc = UploadViewController(viewModel: vm)
        self.navigation?.setViewControllers([vc], animated: true)
//        self.navigation?.modalPresentationStyle = .fullScreen
//        self.navigation?.present(vc, animated: true)
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

extension UploadCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinished(childCoordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter {
            $0.type != childCoordinator.type
        }
    }
    
    
}
