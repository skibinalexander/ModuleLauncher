//
//  InitialInteractor.swift
//  Parcel
//
//  Created by Skibin Alexander on 04/11/2020.
//  Copyright © 2020 ParcelApp. All rights reserved.
//
import Foundation

final class InitialInteractor: InitialInteractorProtocol {

	// MARK: - Public Properties

	weak var presenter: InitialPresenterFromInteractorProtocol!
    var service: ExampleServiceProtocol!
    
    // MARK: - Interactor Implementation
    
    func initialization() {
        presenter.didLoad(
            namesString:
                service
                .fetchExample()
                .joined(separator: " ")
        )
    }
    
}
