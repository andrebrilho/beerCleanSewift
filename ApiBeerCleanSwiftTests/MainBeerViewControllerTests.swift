//
//  MainBeerViewControllerTests.swift
//  ApiBeerCleanSwiftTests
//
//  Created by André Brilho on 06/05/20.
//  Copyright © 2020 André Brilho. All rights reserved.
//

import XCTest
import Foundation

@testable import ApiBeerCleanSwift

class MainBeerViewControllerTests: XCTestCase {
    
    var viewController: MainBeerViewController!
    var interactor: MainBeerInteractor!
    var presenter: MainBeerPresenter!
    
    override func setUp() {
        interactor = MainBeerInteractor()
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainBeerViewController") as? MainBeerViewController
        self.presenter = MainBeerPresenter()
        interactor.presenter = self.presenter
        viewController.interactor = self.interactor
        viewController.loadView()
        
    }
        
    func test_istance() throws {
        XCTAssertTrue(viewController.isKind(of: MainBeerViewController.self))
    }
}
