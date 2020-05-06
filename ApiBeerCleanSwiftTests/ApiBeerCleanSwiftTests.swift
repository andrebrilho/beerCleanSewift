//
//  ApiBeerCleanSwiftTests.swift
//  ApiBeerCleanSwiftTests
//
//  Created by André Brilho on 05/05/20.
//  Copyright © 2020 André Brilho. All rights reserved.
//


import XCTest
import UIKit
import PromiseKit

@testable import ApiBeerCleanSwift

class ApiBeerCleanSwiftTests: XCTestCase {

    class DummyHomePresenter: MainBeerPresentationLogic {

            //jogar as funcs do presenter aqui
            var hasToShowData = false
            var hasToReloadTable = false
            var hasToRouteToDetail = false
            var hasMessageError = false
            
            func showData(listBeer: [MainBeer.Beer]) { hasToShowData = true }
            func reloadTable() { hasToReloadTable = true }
            func routeToDetail() { hasToRouteToDetail = true }
            func showError() { hasMessageError = true }

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
        
            //quero testar o sujeito se ele foi chamado, validando a chamada do presenter
            var subject: MainBeerInteractor!
            var dummyHomePresenter: DummyHomePresenter!
            var mockWorker = MockWorker()
    
            override func setUp() {
                
                let interactor = MainBeerInteractor(worker: mockWorker)
                self.dummyHomePresenter = DummyHomePresenter()
                interactor.presenter = self.dummyHomePresenter
                self.subject = interactor
            }

            //testar qnd der sucesso
            func test_load_when_is_success() {
                self.mockWorker.isSucesss = true
                subject.load()
                subject.handleSuccess(model: self.mockWorker.getBers().value!)
                XCTAssertTrue(dummyHomePresenter.hasToReloadTable)
            }
    
    func test_load_when_is_error() {
        self.mockWorker.isSucesss = false
        subject.load()
        subject.handleFailure(error: self.mockWorker.getBers().error!)
        XCTAssertTrue(dummyHomePresenter.hasMessageError)
    }

        //testar qnd der sucesso
        var modelBeer:[MainBeer.Beer] = []
        func test_handle_success(){
            subject.load()
            subject.handleSuccess(model: modelBeer)
            XCTAssertTrue(dummyHomePresenter.hasToShowData)
        }

        func test_handle_error(){
            subject.load()
            subject.handleFailure(error: NSError.init(domain: "OPS", code: 1))
             XCTAssertTrue(dummyHomePresenter.hasMessageError)
        }
    


    func test_did_select_row(){
        let beerList = MainBeer.Beer(id: 1, name: "teste", tagline: "teste", description: "teste", image_url: "teste", attenuation_level: 1.0, abv: 1.0)
        subject.listBeer = [beerList]
        subject.didSelectRow(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertTrue(dummyHomePresenter.hasToRouteToDetail)
    }
}

