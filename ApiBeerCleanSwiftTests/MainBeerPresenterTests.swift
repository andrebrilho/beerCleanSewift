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
        
        interactor = MainBeerInteractor()
        presenter = MainBeerPresenter()
        viewController = MainBeerViewController()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.loadView()
        
        }
    
    
    
    func test_View_Controller_Instance() {
        XCTAssertTrue(presenter.viewController != nil)
    }
}

