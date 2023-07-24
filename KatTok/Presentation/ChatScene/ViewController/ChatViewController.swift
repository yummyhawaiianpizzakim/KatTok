//
//  ChatViewController.swift
//  KatTok
//
//  Created by 김요한 on 2023/07/23.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class ChatViewController: UIViewController {
    var viewModel: ChatViewModel?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(viewModel: ChatViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .magenta
    }
}

private extension ChatViewController {
    func configureUI() {
        
    }
    
    func bind() {
        
    }
}
