//
//  InitialViewProtocol.swift
//  Parcel
//
//  Created by Skibin Alexander on 04/11/2020.
//  Copyright © 2020 ParcelApp. All rights reserved.
//
import Foundation

protocol InitialViewProtocol: AnyObject {
    
    /// Показать строку имён
    /// - Parameter names: Строка с именами
    func set(names: String)
    
}
