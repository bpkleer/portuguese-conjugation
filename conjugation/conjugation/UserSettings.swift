//
//  UserSettings.swift
//  conjugation
//
//  Created by Philipp Kleer on 04.06.21.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    @Published var irregulares: Bool {
        didSet{
            UserDefaults.standard.set(irregulares, forKey: "irregulares")
        }
    }
    
    @Published var regulares: Bool {
        didSet{
            UserDefaults.standard.set(regulares, forKey: "regulares")
        }
    }
    
    @Published var isPresenteInd: Bool {
        didSet{
            UserDefaults.standard.set(isPresenteInd, forKey: "isPresenteInd")
        }
    }
    
    @Published var isPerfeitoInd: Bool {
        didSet{
            UserDefaults.standard.set(isPerfeitoInd, forKey: "isPerfeitoInd")
        }
    }
    
    @Published var isImperfeitoInd: Bool {
        didSet{
            UserDefaults.standard.set(isImperfeitoInd, forKey: "isImperfeitoInd")
        }
    }
    @Published var isPerfeitoCompInd: Bool {
        didSet{
            UserDefaults.standard.set(isPerfeitoCompInd, forKey: "isPerfeitoCompInd")
        }
    }
    @Published var isPMQPInd: Bool {
        didSet{
            UserDefaults.standard.set(isPMQPInd, forKey: "isPMQPInd")
        }
    }
    @Published var isPMQPCompInd: Bool {
        didSet{
            UserDefaults.standard.set(isPMQPCompInd, forKey: "isPMQPCompInd")
        }
    }
    @Published var isFuturoIInd: Bool {
        didSet{
            UserDefaults.standard.set(isFuturoIInd, forKey: "isFuturoIInd")
        }
    }
    @Published var isFuturoIIInd: Bool {
        didSet{
            UserDefaults.standard.set(isFuturoIIInd, forKey: "isFuturoIIInd")
        }
    }
    @Published var isPresenteSub: Bool {
        didSet{
            UserDefaults.standard.set(isPresenteSub, forKey: "isPresenteSub")
        }
    }
    @Published var isPerfeitoSub: Bool {
        didSet{
            UserDefaults.standard.set(isPerfeitoSub, forKey: "isPerfeitoSub")
        }
    }
    @Published var isImperfeitoSub: Bool {
        didSet{
            UserDefaults.standard.set(isImperfeitoSub, forKey: "isImperfeitoSub")
        }
    }
    @Published var isPMQPSub: Bool {
        didSet{
            UserDefaults.standard.set(isPMQPSub, forKey: "isPMQPSub")
        }
    }
    @Published var isFuturoISub: Bool {
        didSet{
            UserDefaults.standard.set(isFuturoISub, forKey: "isFuturoISub")
        }
    }
    @Published var isFuturoIISub: Bool {
        didSet{
            UserDefaults.standard.set(isFuturoIISub, forKey: "isFuturoIISub")
        }
    }
    @Published var isCondicionalI: Bool {
        didSet{
            UserDefaults.standard.set(isCondicionalI, forKey: "isCondicionalI")
        }
    }
    @Published var isCondicionalII: Bool {
        didSet{
            UserDefaults.standard.set(isCondicionalII, forKey: "isCondicionalII")
        }
    }
    
    
    init() {
        self.isPresenteInd = UserDefaults.standard.object(forKey: "isPresenteInd") as? Bool ?? true
        self.isPerfeitoInd = UserDefaults.standard.object(forKey: "isPerfeitoInd") as? Bool ?? false
        self.isImperfeitoInd = UserDefaults.standard.object(forKey: "isImperfeitoInd") as? Bool ?? false
        self.isPerfeitoCompInd = UserDefaults.standard.object(forKey: "isPerfeitoCompInd") as? Bool ?? false
        self.isPMQPInd = UserDefaults.standard.object(forKey: "isPMQPInd") as? Bool ?? false
        self.isPMQPCompInd = UserDefaults.standard.object(forKey: "isPMQPCompInd") as? Bool ?? false
        self.isFuturoIInd = UserDefaults.standard.object(forKey: "isFuturoIInd") as? Bool ?? false
        self.isFuturoIIInd = UserDefaults.standard.object(forKey: "isFuturoIIInd") as? Bool ?? false
        self.isPresenteSub = UserDefaults.standard.object(forKey: "isPresenteSub") as? Bool ?? false
        self.isPerfeitoSub = UserDefaults.standard.object(forKey: "isPerfeitoSub") as? Bool ?? false
        self.isImperfeitoSub = UserDefaults.standard.object(forKey: "isImperfeitoSub") as? Bool ?? false
        self.isPMQPSub = UserDefaults.standard.object(forKey: "isPMQPSub") as? Bool ?? false
        self.isFuturoISub = UserDefaults.standard.object(forKey: "isFuturoISub") as? Bool ?? false
        self.isFuturoIISub = UserDefaults.standard.object(forKey: "isFuturoIISub") as? Bool ?? false
        self.isCondicionalI = UserDefaults.standard.object(forKey: "isCondicionalI") as? Bool ?? false
        self.isCondicionalII = UserDefaults.standard.object(forKey: "isCondicionalII") as? Bool ?? false
        self.irregulares = UserDefaults.standard.object(forKey: "irregulares") as? Bool ?? true
        self.regulares = UserDefaults.standard.object(forKey: "regulares") as? Bool ?? true

    }
}


