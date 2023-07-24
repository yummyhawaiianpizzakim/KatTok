//
//  TabBarCoordinator.swift
//  KatTok
//
//  Created by 김요한 on 2023/07/23.
//

import Foundation
import UIKit

class TabBarCoordinator: CoordinatorProtocol {
    var finishDelegate: CoordinatorFinishDelegate?
    var childCoordinators: [CoordinatorProtocol] = []
    var type: CoordinatorType = .tab
    var navigationController: UINavigationController
    private var tabBarController: CustomTabBarController?
    private var currentPage: TabBarPage = .shorts
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
//        self.tabBarController = CustomTabBarController()
    }
    
    func start() {
//        let pages = TabBarPage.allCases
//        let controllers: [UINavigationController] = pages.map { TabBarPage in
//            self.getController(page: TabBarPage)
//        }
//        self.navigationController.setNavigationBarHidden(true, animated: true)
//        self.prepareTabBarController(controllers: controllers)
        self.showTabBarController()
    }
    
}

extension TabBarCoordinator {
    func showTabBarController() {
        let tabBarController = CustomTabBarController()
        let shortsCoordinator = ShortsCoordinator(presenterController: tabBarController)
        shortsCoordinator.finishDelegate = self
        self.childCoordinators.append(shortsCoordinator)
        shortsCoordinator.start()
        let browseCoordinator = BrowseCoordinator(presenterController: tabBarController)
        browseCoordinator.finishDelegate = self
        self.childCoordinators.append(browseCoordinator)
        browseCoordinator.start()
        let chatCoordinator = ChatCoordinator(presenterController: tabBarController)
        chatCoordinator.finishDelegate = self
        self.childCoordinators.append(chatCoordinator)
        chatCoordinator.start()
        let profileCoordinator = ProfileCoordinator(presenterController: tabBarController)
        profileCoordinator.finishDelegate = self
        self.childCoordinators.append(profileCoordinator)
        profileCoordinator.start()
        
        tabBarController.appendNavigationController(shortsCoordinator.navigation, page: .shorts)
        tabBarController.appendNavigationController(browseCoordinator.navigation, page: .browse)
        tabBarController.appendNavigationController(UINavigationController(), page: .upload)
        tabBarController.appendNavigationController(chatCoordinator.navigation, page: .chat)
        tabBarController.appendNavigationController(profileCoordinator.navigation, page: .profile)
        
        tabBarController.didSelectUploadTabPage = { [weak self] in
            let uploadCoordinator = UploadCoordinator(presenterController: tabBarController)
            uploadCoordinator.finishDelegate = self
            self?.childCoordinators.append(uploadCoordinator)
            uploadCoordinator.start()
            if let controller = uploadCoordinator.navigation {
                controller.modalPresentationStyle = .formSheet
                tabBarController.present(controller, animated: true)
            }
        }
        self.tabBarController = tabBarController
        self.navigationController.pushViewController(tabBarController, animated: true)
        }
    
    func showUploadView() {
        let tabBarController = CustomTabBarController()
        let uploadCoordinator = UploadCoordinator(presenterController: tabBarController)
        uploadCoordinator.finishDelegate = self
        self.childCoordinators.append(uploadCoordinator)
        uploadCoordinator.start()
        if let controller = uploadCoordinator.navigation {
            controller.modalPresentationStyle = .formSheet
            tabBarController.present(controller, animated: true)
        }
    }
    
//    private func prepareTabBarController(controllers: [UIViewController]) {
//        self.tabBarController.setViewControllers(controllers, animated: true)
//        self.tabBarController.selectedIndex = TabBarPage.shorts.rawValue
//        tabBarController.tabBar.isTranslucent = false
//        tabBarController.tabBar.backgroundColor = .systemBackground
//
//        navigationController.viewControllers = [tabBarController]
//    }
    
//    private func getController(page: TabBarPage) -> UINavigationController {
//        let navigation = UINavigationController()
//
////        navigation.tabBarItem = UITabBarItem.init(
////            title: page.pageTitleValue(),
////            image: page.pageTabIcon(),
////            tag: page.rawValue
////        )
//
//        switch page {
//        case .shorts:
//            let shortsCoordinator = ShortsCoordinator(navigation: navigation)
//            shortsCoordinator.finishDelegate = self
//            self.childCoordinators.append(shortsCoordinator)
//            shortsCoordinator.start()
//            self.tabBarController.appendNavigationController(UINavigationController(),page: .upload)
//        case .browse:
//            let browseCoordinator = BrowseCoordinator(navigation: navigation)
//            browseCoordinator.finishDelegate = self
//            self.childCoordinators.append(browseCoordinator)
//            browseCoordinator.start()
//        case .upload:
//            self.tabBarController.appendNavigationController(UINavigationController(),page: .upload)
//        case .chat:
//            let chatCoordinator = ChatCoordinator(navigation: navigation)
//            chatCoordinator.finishDelegate = self
//            self.childCoordinators.append(chatCoordinator)
//            chatCoordinator.start()
//        case .profile:
//            let profileCoordinator = ProfileCoordinator(navigation: navigation)
//            profileCoordinator.finishDelegate = self
//            self.childCoordinators.append(profileCoordinator)
//            profileCoordinator.start()
//        }
//        return navigation
//    }
}
extension TabBarCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinished(childCoordinator: CoordinatorProtocol) {
        self.childCoordinators = self.childCoordinators.filter({ Coordinator in
            Coordinator.type != childCoordinator.type
        })
    }
}

