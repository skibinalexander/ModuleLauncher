//
//  InitialConfigurator.swift
//  Parcel
//
//  Created by Skibin Alexander on 04/11/2020.
//  Copyright © 2020 ParcelApp. All rights reserved.
//

import ModuleLauncher
import UIKit
import Swinject

final class InitialConfigurator: NSObject, Assembly {

    // MARK: - Public Properties
    
    public var container: Container!

    // MARK: - Assembly

    func assemble(container: Container) {
        self.container = container
        configure(container: container)
    }

    // MARK: - Assembly Configuration
    
    private func configure(container: Container) {

        /// Assembly View Layer
        container
            .register(InitialViewProtocol.self) { _ in
                InitialView.instanceFromStoryboard()
            }
            .initCompleted { r, c in
                guard let view = c as? InitialView else { return }
                view.presenter = r.resolve(InitialPresenterProtocol.self)
            }

        /// Assembly Router Layer
        container
            .register(InitialRouterProtocol.self) { _ in
                InitialRouter()
            }
            .initCompleted { [unowned self] _, c in
                guard let router = c as? InitialRouter else { return }
                router.configurator = self
            }

        /// Assembly Presenter Layer
        container
            .register(InitialPresenterProtocol.self) { _ in
                InitialPresenter()
            }
            .initCompleted { r, c in
                guard let presenter = c as? InitialPresenter else { return }
                presenter.view = r.resolve(InitialViewProtocol.self)
                presenter.router = r.resolve(InitialRouterProtocol.self)
                presenter.interactor = r.resolve(InitialInteractorProtocol.self)
            }

        /// Assembly Interactor Layer
        container
        .register(InitialInteractorProtocol.self) { _ in
            InitialInteractor()
        }
        .initCompleted { r, c in
            guard let interactor = c as? InitialInteractor else { return }
            interactor.presenter = r.resolve(InitialPresenterProtocol.self)
            interactor.service = r.resolve(ExampleServiceProtocol.self)
        }
    }
}

// MARK: - ConfiguratorView

extension InitialConfigurator: ConfiguratorView {
    
    func getView() -> UIViewController {
        container.resolveAsViewController(InitialViewProtocol.self)
    }
    
}
