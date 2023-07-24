//
//  TabBarViewController.swift
//  KatTok
//
//  Created by 김요한 on 2023/07/23.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

enum TabBarPage: Int, CaseIterable {
    case shorts = 0
    case browse = 1
    case upload = 2
    case chat = 3
    case profile = 4
    
    func pageTitleValue() -> String {
        switch self {
        case .shorts:
            return ""
        case .browse:
            return ""
        case .upload:
            return ""
        case .chat:
            return ""
        case .profile:
            return ""
        }
    }
    
    func pageTabIcon() -> UIImage? {
        switch self {
        case .shorts:
            return UIImage(systemName: "play.tv")
        case .browse:
            return UIImage(systemName: "map")
        case .upload:
            return UIImage(systemName: "plus.rectangle")
//            return nil
        case .chat:
            return UIImage(systemName: "text.bubble")
        case .profile:
            return UIImage(systemName: "person")
        }
    }
    
    func pageTabSelectedIcon() -> UIImage? {
        switch self {
        case .shorts:
            return UIImage(systemName: "play.tv.fill")
        case .browse:
            return UIImage(systemName: "map.fill")
        case .upload:
            return UIImage(systemName: "plus.rectangle.fill")
//            return nil
        case .chat:
            return UIImage(systemName: "text.bubble.fill")
        case .profile:
            return UIImage(systemName: "person.fill")
        }
    }
}


class CustomTabBarController: UITabBarController {
    let disposeBag = DisposeBag()
    weak var coordinator: TabBarCoordinator?
    
    var didSelectUploadTabPage: (() -> Void)?
    
    private let tabBarItems = [
        UITabBarItem(title: nil, image: TabBarPage.shorts.pageTabIcon(),
                     selectedImage: TabBarPage.shorts.pageTabSelectedIcon()),
           UITabBarItem(title: nil, image: TabBarPage.browse.pageTabIcon(),
                        selectedImage: TabBarPage.browse.pageTabSelectedIcon()),
           UITabBarItem(title: nil, image: TabBarPage.upload.pageTabIcon(),
                        selectedImage: nil),
           UITabBarItem(title: nil, image: TabBarPage.chat.pageTabIcon(),
                        selectedImage: TabBarPage.chat.pageTabSelectedIcon()),
           UITabBarItem(title: nil, image: TabBarPage.profile.pageTabIcon(),
                        selectedImage: TabBarPage.profile.pageTabSelectedIcon())
       ]
    
    
    lazy var upLoadButton: UIButton = {
            let button = UIButton()
            button.frame.size = CGSize(
                width: 50,
                height: 50
            )

        button.setImage(UIImage(systemName: "plus.rectangle"), for: .normal)
//            button.backgroundColor = .themeColor200
            button.tintColor = .orange
//            button.layer.cornerRadius = FrameResource.addCapsuleButtonSize / 2

            return button
        }()
    
    lazy var viewButton: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .systemBackground
        self.tabBar.tintColor = .orange
        self.tabBar.unselectedItemTintColor = .black
        self.delegate = self
        self.configureUI()
        self.bind()
        
    }
    
}

extension CustomTabBarController {
    func configureUI() {
//        self.tabBar.addSubview(self.upLoadButton)
//        self.upLoadButton.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview().offset(-25)
//            make.width.equalTo(50)
//            make.height.equalTo(50)
//        }
    }
    
    func bind() {
        
        self.upLoadButton.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                print("tap")
                owner.coordinator?.showUploadView()
            })
            .disposed(by: self.disposeBag)
    }
    
    func appendNavigationController(_ navigation: UINavigationController, page: TabBarPage) {
//            customizeNavigationController(navigationController, item: item)
        navigation.tabBarItem = tabBarItems[page.rawValue]
        self.viewControllers = (self.viewControllers ?? []) + [navigation]
        }
}

extension CustomTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let index = tabBarController.viewControllers?.firstIndex(of: viewController),
              let item = TabBarPage(rawValue: index)
        else {
            return true
        }
        
        if item == .upload {
            self.didSelectUploadTabPage?()
//            self.coordinator?.showUploadView()
            return false
        }
        
        
        return true
    }
}
