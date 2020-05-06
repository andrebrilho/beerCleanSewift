//
//  MainBeerViewController.swift
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

protocol MainBeerDisplayLogic: class {
    func reloadTable()
    func routeToDetail()
    func showData(_ listBeer:[MainBeer.Beer])
    func showError(erro: String)
}

class MainBeerViewController: UIViewController, MainBeerDisplayLogic {
    
  @IBOutlet weak var tbl: UITableView!
    var beerTable:[MainBeer.Beer] = []
  var interactor: MainBeerBusinessLogic?
  var router: (NSObjectProtocol & MainBeerRoutingLogic & MainBeerDataPassing)?
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder){
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup(){
    let viewController = self
    let interactor = MainBeerInteractor()
    let presenter = MainBeerPresenter()
    let router = MainBeerRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?){
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.dataSource = self
        tbl.delegate = self
        tbl.register(UINib(nibName: "BeerTableViewCell", bundle: nil), forCellReuseIdentifier: "BeerTableViewCell")
        interactor?.load()
    }
    
    func reloadTable() {
        tbl.reloadData()
    }
    
    func showError(erro: String) {
        Alert.showAlertError(mensagemErro: erro, titleMsgErro: "Alerta", view: self)
    }
    
    func routeToDetail() {
        router?.routeToDetail()
    }
    
    func showData(_ listBeer: [MainBeer.Beer]) {
        beerTable = listBeer
    }

}

extension MainBeerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BeerTableViewCell", for: indexPath) as? BeerTableViewCell{
            cell.beer = beerTable[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.didSelectRow(indexPath: indexPath)
        tbl.deselectRow(at: indexPath, animated:true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
