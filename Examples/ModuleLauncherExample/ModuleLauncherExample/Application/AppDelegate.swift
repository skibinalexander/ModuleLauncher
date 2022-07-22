//
//  AppDelegate.swift
//  ModuleLauncherExample
//
//  Created by Скибин Александр on 07.03.2021.
//

import UIKit
import ModuleLauncher
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = FeatureCoordinator.shared.prepareWindow()
        
        installRootView()
        
        return true
    }
    
    // MARK: - For example
    
    private func installRootView() {
        
        let launcher = DependencyModuleFactory()
            .launch(
                configurator: InitialConfigurator.self,
                with: InitialFeatureLauncher.new(),
                in: Container(),
                preAssembly: nil,
                postAssembly: nil
            )
        
        FeatureCoordinator.shared.display(view: launcher.view)
        
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        } else { }
        
    }


}

