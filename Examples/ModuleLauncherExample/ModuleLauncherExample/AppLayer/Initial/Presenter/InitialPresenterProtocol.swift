//
//  InitialPresenterProtocol.swift
//  Parcel
//
//  Created by Skibin Alexander on 04/11/2020.
//  Copyright © 2020 ParcelApp. All rights reserved.
//
import Foundation

protocol InitialPresenterFromViewProtocol: AnyObject {
    func viewDidLoad()
}

protocol InitialPresenterFromInteractorProtocol: AnyObject {
    func didLoad(namesString: String)
}

typealias InitialPresenterProtocol = InitialPresenterFromViewProtocol & InitialPresenterFromInteractorProtocol
