//
//  CoordinatorProtocol.swift
//  KatTok
//
//  Created by 김요한 on 2023/07/23.
//

import Foundation

enum CoordinatorType {
    case app
    case tab
    case shorts, browse, upload, uploadShorts, chat, profile
    case detail
    case signIn, signUp
}


protocol CoordinatorProtocol: AnyObject {
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var childCoordinators: [CoordinatorProtocol] { get set }
    var type: CoordinatorType { get }
    
    func start()
    func finish()
}


extension CoordinatorProtocol {
    func finish() {
        self.childCoordinators.removeAll()
        self.finishDelegate?.coordinatorDidFinished(childCoordinator: self)
    }
}

protocol CoordinatorFinishDelegate:AnyObject {
    func coordinatorDidFinished(childCoordinator: CoordinatorProtocol)
}

