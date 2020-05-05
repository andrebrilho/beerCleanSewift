//
//  MainBeerRouter.swift
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

@objc protocol MainBeerRoutingLogic{
    
}

protocol MainBeerDataPassing{
  var dataStore: MainBeerDataStore? { get }
}

class MainBeerRouter: NSObject, MainBeerRoutingLogic, MainBeerDataPassing{
  weak var viewController: MainBeerViewController?
  var dataStore: MainBeerDataStore?

}
