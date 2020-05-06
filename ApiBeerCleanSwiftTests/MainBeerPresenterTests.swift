//
//  MainBeerPresenterTests.swift
//  ApiBeerCleanSwiftTests
//
//  Created by André Brilho on 06/05/20.
//  Copyright © 2020 André Brilho. All rights reserved.
//

import XCTest
import Foundation

@testable import ApiBeerCleanSwift

class MainBeerPresenterTests: XCTestCase {
    
    
    var presenter: MainBeerPresenter!
    var viewController: MainBeerViewController!
    var interactor:MainBeerInteractor!
    
    override func setUp() {
        
        let interactor = MainBeerInteractor()
        let presenter = MainBeerPresenter()
        let viewController = MainBeerViewController()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.loadView()
        viewController.viewDidLoad()
        }
    
    
    
    func test_View_Controller_Instance() {
        XCTAssertTrue(presenter.viewController != nil)
    }
}

