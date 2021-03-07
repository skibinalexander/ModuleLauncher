//
//  ExampleService.swift
//  ModuleLauncherExample
//
//  Created by Скибин Александр on 07.03.2021.
//

import Foundation
import Swinject

/// Пример сервиса получения данных
struct ExampleService: ExampleServiceProtocol {
    
    func fetchExample() -> [String] {
        ["Bob", "Rob", "Jon"]
    }
    
}
