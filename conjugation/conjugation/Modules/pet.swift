//
//  File.swift
//  conjugation
//
//  Created by Philipp Kleer on 03.06.21.
//
import Foundation
import SwiftUI

struct Pet: Identifiable {
    var id = UUID()
    var name: String
}

extension Pet {
    static func dummyData() -> [Pet] {
        let items = ["Presente Indicativo", "Pretérito Perfeito Indicativo", "Pretérito Imperfeito Indicativo", "Pretérito Perfeito Composto Indicativo", "Pretérito Mais-que-Perfeito Composto Indicativo", "Futuro Simples Indicativo", "Futuro de Presente Composto Indicativo", "Presente Subjunctivo", "Pretérito Perfeito Subjunctivo", "Pretérito Imperfeito Subjunctivo", "Pretérito Mais-que-Perfeito Composto Subjunctivo", "Futuro Subjunctivo", "Futuro Composto Subjunctivo", "Futuro do Pretérito Simples Subjunctivo", "Futuro do Pretérito Composto Subjunctivo"]
        
        var array = [Pet]()
        
        for item in items {
            let pet = Pet(name: item)
            array.append(pet)
        }
        
        return array
    }
    
    // another function to return names!
}

