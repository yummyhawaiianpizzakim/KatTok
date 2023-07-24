////
////  FirebaseService.swift
////  KatTok
////
////  Created by 김요한 on 2023/07/23.
////
//
//import Foundation
//import FirebaseAuth
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//import RxSwift
//import RxRelay
//
//
//protocol DTOProtocol: Codable {
//    var id: String { get set }
//}
//
//enum UserCase {
//    case currentUser(_ uid: String)
//    case anotherUser(_ uid: String)
//
//    var path: String {
//        return "users"
//    }
//}
//
//enum Access {
//    case likedImages
//    case collectedImages(_ name: String)
//    case users
//
//    var path: String {
//        switch self {
//        case .likedImages:
//            return "likedImages"
//        case .collectedImages:
//            return "collectedImages"
//        case .users:
//            return "users"
//        }
//    }
//}
//
//public enum FireStoreCollection: String {
//    case users, collectedImages, likedImages
//
//    var name: String {
//        return self.rawValue
//    }
//}
//
//public enum FireStoreError: Error, LocalizedError {
//    case unknown
//    case decodeError
//    case documentReferenceError
//}
//
//protocol FireStoreServiceProtocol {
//    typealias FirebaseData = [String: Any]
//    func signIn(credential: AuthCredential) -> Single<String>
//    func create<T: DTOProtocol>(access: Access, dto: T)  -> Single<T>
////    func read<T: Codable>(type: T.Type, access: Access) -> Single<T>
//    func read<T: Codable>(type: T.Type, access: Access) -> Observable<T>
//    func update<T: DTOProtocol>(access: Access, dto: T) -> Single<T>
//    func delete<T: DTOProtocol>(access: Access, dto: T) -> Single<T>
//
//}
//
//class FireStoreService: FireStoreServiceProtocol {
//    private let db = Firestore.firestore()
////    private let auth: Auth
////    private let storage: Storage
//
//    private(set) var uid: BehaviorRelay<String?> = BehaviorRelay(value: nil)
//
//    func signIn(credential: AuthCredential) -> Single<String> {
//        return Single<String>.create { [weak self] single in
//            guard let self = self else { return Disposables.create() }
//            Auth.auth().signIn(with: credential) { result, error in
//                // 사용자 등록 후에 처리할 코드
//                // At this point, our user is signed in
//                if let error = error {
////                    print(error)
//                    single(.failure(error))
//                    return
//                }
//                if let user = result?.user {
//                    self.uid.accept(user.uid)
//                    single(.success(user.uid))
//                }
//            }
//            return Disposables.create()
//        }
//    }
//
//    func create<T: DTOProtocol>(access: Access, dto: T)  -> Single<T> {
//        return Single<T>.create { [weak self] single in
//            do {
//                let ref = try self?.documentReference()
//                switch access {
//                case .users:
//                    try ref?.setData(from: dto)
//                case .likedImages:
//                    try ref?.collection(access.path).document(dto.id).setData(from: dto, merge: true)
//                case .collectedImages(_):
//                    break
//                }
//                single(.success(dto))
//            } catch let error {
//                single(.failure(error))
//            }
//            return Disposables.create()
//        }
//    }
//    
//    func read<T: Codable>(type: T.Type, access: Access) -> Observable<T> {
//        return Observable<T>.create {[weak self] observer in
//            guard let self = self else { return Disposables.create() }
//            do {
//                let ref = try self.documentReference()
//                switch access {
//                case .users:
//                    ref.getDocument { snapshot, error in
//                        if let error = error {
//                            observer.onError(error)
////                            single(.failure(error))
//                        } else if let snapshot = snapshot,
//                                  let userInfor = snapshot.data(as: type) {
////                            print(userInfor)
//                            observer.onNext(userInfor)
////                            single(.success(userInfor))
//                        } else {
//                            observer.onError(FireStoreError.decodeError)
////                            single(.failure(FireStoreError.decodeError))
//                        }
//                        observer.onCompleted()
//                    }
//                case .likedImages:
//                    ref.collection(access.path).getDocuments { snapshot, error in
//                        if let error = error {
//                            observer.onError(error)
////                            single(.failure(error))
//                        }
//                        guard let snapshot = snapshot else { return }
//                        for document in snapshot.documents {
//                            do {
//                                let likedImage = try document.data(as: type)
//                                observer.onNext(likedImage)
////                                print(likedImage)
////                                single(.success(likedImage))
//                            } catch let error {
//                                observer.onError(error)
//                                print(error)
////                                single(.failure(error))
//                            }
//                        }
//                        observer.onCompleted()
//                    }
//                case .collectedImages(let collectedImages):
//                    ref.collection(collectedImages).getDocuments { snapshot, error in
//                        if let error = error {
//                            observer.onError(error)
////                            single(.failure(error))
//                        }
//                        guard let snapshot = snapshot else { return }
//                        for document in snapshot.documents {
//                            do {
//                                let likedImage = try document.data(as: type)
//                                observer.onNext(likedImage)
//                            } catch let error {
//                                observer.onError(error)
//                            }
//                        }
//                    }
//                    observer.onCompleted()
//                }
//            } catch let error {
//                observer.onError(error)
////                single(.failure(error))
//            }
//
//            return Disposables.create()
//        }
//    }
//
//    func update<T: DTOProtocol>(access: Access, dto: T) -> Single<T> {
//        return Single<T>.create {[weak self] single in
//            do {
//                guard let self = self else { throw FireStoreError.documentReferenceError }
//                let ref = try self.documentReference()
//                switch access {
//                case .users:
//                    try ref.setData(from: dto, merge: true, completion: { error in
//                        if let error = error {
//                            single(.failure(error))
//                        } else {
//                            single(.success(dto))
//                        }
//                    })
//                case .likedImages:
//                    try ref.collection(access.path).document(dto.id).setData(from: dto, merge: true, completion: { error in
//                        if let error = error {
//                            single(.failure(error))
//                        } else {
////                            print(dto)
//                            single(.success(dto))
//                        }
//                    })
//                case .collectedImages(let collectedName):
//                    try ref.collection(collectedName).document(dto.id).setData(from: dto, merge: true, completion: { error in
//                        if let error = error {
//                            single(.failure(error))
//                        } else {
//                            single(.success(dto))
//                        }
//                    })
//                }
//
//            } catch let error {
//                single(.failure(error))
//            }
//            return Disposables.create()
//        }
//    }
//
//    func delete<T: DTOProtocol>(access: Access, dto: T) -> Single<T> {
//            return Single<T>.create { [weak self] single in
//                do {
//                    guard let self = self else { throw FireStoreError.documentReferenceError }
//                    let ref = try self.documentReference()
//                    switch access {
//                    case .likedImages:
//                        ref.collection(access.path).document("\(dto.id)").delete() { error in
//                            if let error = error {
//                                single(.failure(error))
//                            } else {
//                                single(.success(dto))
//                            }
//                        }
//                    case .collectedImages(let collectionName):
//                        ref.collection(collectionName).document("\(dto.id)").delete { error in
//                            if let error = error {
//                                single(.failure(error))
//                            } else {
//                                single(.success(dto))
//                            }
//                        }
//                    case .users:
//                        ref.delete() { error in
//                            if let error = error {
//                                single(.failure(error))
//                            } else {
//                                single(.success(dto))
//                            }
//                        }
//                    }
//                } catch let error {
//                    single(.failure(error))
//                }
//                return Disposables.create()
//            }
//        }
//}
//
//extension FireStoreService {
//    private func documentReference() throws -> DocumentReference {
//        guard let uid = self.uid.value else { throw FireStoreError.documentReferenceError }
//
//        return db.collection(Access.users.path).document(uid)
//
//    }
//}
