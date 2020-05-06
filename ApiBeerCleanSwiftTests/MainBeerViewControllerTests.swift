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
    
    var viewController:MainBeerViewController!
    var interctor: MainBeerInteractor!
    var presenter: MainBeerPresenter!
    

    override func setUp() {
        let interactor = MainBeerInteractor()
        let viewController = MainBeerViewController()
        self.presenter = MainBeerPresenter()
        interactor.presenter = self.presenter
        viewController.interactor = self.interctor
        
    }
        
    func test_istance() throws {
        XCTAssertTrue(viewController.isKind(of: MainBeerViewController.self))
    }


}
