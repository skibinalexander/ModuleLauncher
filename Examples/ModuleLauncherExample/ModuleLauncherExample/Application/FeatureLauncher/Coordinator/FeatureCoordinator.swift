//
//  FeatureCoordinator.swift
//  ModuleLauncherExample
//
//  Created by Скибин Александр on 07.03.2021.
//

import ModuleLauncher
import Swinject

class FeatureCoordinator {
    
    static let shared: FeatureCoordinator = FeatureCoordinator()
    
    private var window: UIWindow!
    
    func prepareWindow() -> UIWindow {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        return window
    }
    
    func display(view: UIViewController) {
        window.rootViewController = view
        window.makeKeyAndVisible()
    }
    
}
