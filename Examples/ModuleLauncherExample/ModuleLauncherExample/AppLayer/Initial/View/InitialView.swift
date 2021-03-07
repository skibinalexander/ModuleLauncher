//
//  InitialView.swift
//  Parcel
//
//  Created by Skibin Alexander on 04/11/2020.
//  Copyright © 2020 ParcelApp. All rights reserved.
//

import UIKit

final class InitialView: UIViewController, InitialViewProtocol {

    // MARK: - Static Initialization

    static func instanceFromStoryboard() -> (InitialViewProtocol & UIViewController) {
        UIStoryboard(
            name: self.className, bundle: nil
        )
        .instantiateViewController(withIdentifier: self.className) as! (InitialViewProtocol & UIViewController)
    }

    // MARK: - Public Properties
    
    static var className: String { return String(describing: self) }

    var presenter: InitialPresenterFromViewProtocol!

    // MARK: - IBOutlets
    
    @IBOutlet weak var label: UILabel!

    // MARK: - Lifecycle

    deinit {
        print("--- deinit InitialView")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        presenter.viewDidLoad()
    }
    
    // MARK: - Protocol Implementation
    
    func set(names: String) {
        label.text = names
    }

    // MARK: - Private Methods

    private func setupInitialState() {
        view.accessibilityIdentifier = "InitialView"
        view.endEditing(true)
    }
    
}
