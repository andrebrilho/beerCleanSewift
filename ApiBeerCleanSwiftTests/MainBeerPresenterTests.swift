//
//  MainBeerPresenterTests.swift
//  ApiBeerCleanSwiftTests
//
//  Created by André Brilho on 06/05/20.
//  Copyright © 2020 André Brilho. All rights reserved.
//

import XCTest
import Foundation
import PromiseKit

@testable import ApiBeerCleanSwift

class MainBeerPresenterTests: XCTestCase {
    
    var presenter: MainBeerPresenter!
    var viewController: MainBeerViewController!
    var interactor:MainBeerInteractor!
    
    override func setUp() {
        
        interactor = MainBeerInteractor()
        presenter = MainBeerPresenter()
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainBeerViewController") as? MainBeerViewController
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    func test_View_Controller_Instance() {
        XCTAssertTrue(presenter.viewController != nil)
    }
    
    //mockWorker
    class MockWorker: MainBeerWorker {
        var isSucesss = true
        
        override func getBers() -> Promise<[MainBeer.Beer]> {
            
            if isSucesss {
                let beer1 = MainBeer.Beer(id: 1, name: "Skol", tagline: "teste tagLine", description: "description Beer", image_url: "https//www.google.com", attenuation_level: 9.6, abv: 2.2)
                let beer2 = MainBeer.Beer(id: 12, name: "Itaipava", tagline: "teste tagLine cervaja puro malte", description: "description Beer numero 2", image_url: "https//www.google.com", attenuation_level: 12.8, abv: 6.2)
                
                let beers:[MainBeer.Beer] = [beer1, beer2]
                let response = beers
                return Promise {seal in
                    seal.fulfill(response)
                }
            } else {
                let error: Error = NSError(domain: "", code: 404, userInfo: nil)
                return Promise {seal in
                    seal.reject(error)
                }
            }
        }
    }
    
    func test_showData() {
        var listBeer = MockWorker().getBers()
        presenter.showData(listBeer: listBeer.value!)
        XCTAssert(viewController.beerTable != nil)
    }
}

