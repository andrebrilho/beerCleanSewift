//
//  MainBeerInteractor.swift
//  ApiBeerCleanSwift
//
//  Created by André Brilho on 05/05/20.
//  Copyright (c) 2020 André Brilho. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MainBeerBusinessLogic {
    var numberOfRows: Int { get }
    func cellForRow(indexPath:IndexPath) -> MainBeer.Beer
    func didSelectRow(indexPath: IndexPath)
}

protocol MainDataStore {
  var selectedCar: MainBeer.Beer? { get set }
}

class MainBeerInteractor: MainBeerBusinessLogic, MainDataStore {
    
    var selectedBeer: MainBeer.Beer?
    var listBeer:[MainBeer.Beer] = []
    
  var presenter: MainBeerPresentationLogic?
    
    var worker: MainBeerWorker
    init(worker:MainBeerWorker = MainBeerWorker()) {
        self.worker = worker
    }
    
    var presenter: MainBeerPresentationLogic? {
        didSet {
            load()
        }
    }
    
    func load(){
        worker.getCarros().done(handleSuccess).catch(handleFailure)
    }
    
    func handleSuccess(model: MainBeer.Beer) {
        listBeer = MainBeer.Beer
        presenter?.reloadTable()
    }
    
    func handleFailure(error:Error) {
        print("OPS deu ruim")
    }
    
    var numberOfRows: Int {
        return listBeer.count
    }
    
    func cellForRow(indexPath: IndexPath) -> MainBeer.Beer {
        return listBeer[indexPath.row]
    }
    
    func didSelectRow(indexPath: IndexPath) {
        selectedBeer = listBeer[indexPath.row]
        presenter?.routeToDetail()
    }
    

}