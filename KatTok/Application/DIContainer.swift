//
//  DIContainer.swift
//  KatTok
//
//  Created by 김요한 on 2023/07/23.
//

import Foundation
import Swinject

class DIContainer {
    static let shared = DIContainer()
    
    let container = Container()
    
    private init() {
        registerInfraStructure()
        registerService()
        registerRepository()
        registerUseCase()
        registerViewModel()
    }
    
    func registerInfraStructure() {
        registerFireStoreService()
    }
    
    func registerService() {
    }
    
    func registerRepository() {
    }
    
    func registerUseCase() {
    }
    
    func registerViewModel() {
        registerShortsViewModel()
        registerBrowseViewModel()
        registerUploadViewModel()
        registerChatViewModel()
        registerProfileViewModel()
    }
}

extension DIContainer {
    func registerFireStoreService() {
//        self.container.register(FireStoreServiceProtocol.self) { resolver in
//            return FireStoreService()
//        }
//        .inObjectScope(.container)
    }
}

extension DIContainer {
    
}

extension DIContainer {
   
}

extension DIContainer {
    
}

extension DIContainer {
    func registerShortsViewModel() {
        self.container.register(ShortsViewModel.self) { Resolver in
            return ShortsViewModel()
        }
        .inObjectScope(.graph)
    }
    
    func registerBrowseViewModel() {
        self.container.register(BrowseViewModel.self) { Resolver in
            return BrowseViewModel()
        }
        .inObjectScope(.graph)
    }
    
    func registerUploadViewModel() {
        self.container.register(UploadViewModel.self) { Resolver in
            return UploadViewModel()
        }
        .inObjectScope(.graph)
    }
    
    func registerChatViewModel() {
        self.container.register(ChatViewModel.self) { Resolver in
            return ChatViewModel()
        }
        .inObjectScope(.graph)
    }
    
    func registerProfileViewModel() {
        self.container.register(ProfileViewModel.self) { Resolver in
            return ProfileViewModel()
        }
        .inObjectScope(.graph)
    }
}
