//
//  ShortsViewController.swift
//  KatTok
//
//  Created by 김요한 on 2023/07/23.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class ShortsViewController: UIViewController {
    var viewModel: ShortsViewModel?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(viewModel: ShortsViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
    }
    
}

private extension ShortsViewController {
    func configureUI() {
        
    }
    
    func bind() {
        
    }
}
