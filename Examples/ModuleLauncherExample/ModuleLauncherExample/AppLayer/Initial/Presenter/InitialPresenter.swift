//
//  InitialPresenter.swift
//  Parcel
//
//  Created by Skibin Alexander on 04/11/2020.
//  Copyright © 2020 ParcelApp. All rights reserved.
//
import Foundation

// MARK: - InitialPresenterFromViewProtocol Implementation

final class InitialPresenter: InitialPresenterFromViewProtocol {

    // MARK: - Public Properties

    weak var view: InitialViewProtocol!
    var interactor: InitialInteractorProtocol!
    var router: InitialRouterProtocol!

    // MARK: - Protocol Implementation

    func viewDidLoad() {
        interactor.initialization()
    }
    
}

// MARK: - InitialPresenterFromInteractorProtocol Implementation

extension InitialPresenter: InitialPresenterFromInteractorProtocol {
    
}
