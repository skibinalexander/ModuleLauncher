//
//  ExampleServiceProtocol.swift
//  ModuleLauncherExample
//
//  Created by Скибин Александр on 07.03.2021.
//

import ModuleLauncher

/// Интерфейс сервиса
protocol ExampleServiceProtocol {
    
    /// Получегние данных для примера
    func fetchExample() -> [String]
    
}
