//
//  toggle.swift
//  conjugation
//
//  Created by Philipp Kleer on 03.06.21.
//

import SwiftUI


struct ToggleStates: View {
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        ScrollView(.vertical) {
            Text("Escolhe as conjugações!")
                .font(.title2)
            
            VStack (spacing: 7.5) {
                Toggle(isOn: $userSettings.isPresenteInd, label: {
                    Text("Presente Indicativo")
                        .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                .onChange(of: self.userSettings.isPresenteInd) { oldvalue, newvalue in
                    atLeastOneTempus()
                }
                .onChange(of: self.userSettings.isPerfeitoInd){oldvalue, newvalue in
                    atLeastOneTempus()
                }
                .onChange(of: self.userSettings.isImperfeitoInd) { oldvalue, newvalue in
                    atLeastOneTempus()
                }
                .onChange(of: self.userSettings.isPerfeitoCompInd) { oldvalue, newvalue in
                    atLeastOneTempus()
                }
                .onChange(of: self.userSettings.isPMQPInd) { oldvalue, newvalue in
                    atLeastOneTempus()
                }
                .onChange(of: self.userSettings.isFuturoIInd) { oldvalue, newvalue in
                    atLeastOneTempus()
                }
                .onChange(of: self.userSettings.isFuturoIIInd) { oldvalue, newvalue in
                    atLeastOneTempus()
                }
                .onChange(of: self.userSettings.isPresenteSub) { oldvalue, newvalue in
                    atLeastOneTempus()
                }
                .onChange(of: self.userSettings.isPerfeitoSub) { oldvalue, newvalue in
                    atLeastOneTempus()
                }
                .onChange(of: self.userSettings.isImperfeitoSub) { oldvalue, newvalue in
                    atLeastOneTempus()
                }
                .onChange(of: self.userSettings.isPMQPSub) { oldvalue, newvalue in
                    atLeastOneTempus()
                }
                .onChange(of: self.userSettings.isFuturoISub) { oldvalue, newvalue in
                    atLeastOneTempus()
                }
                .onChange(of: self.userSettings.isFuturoIISub) { oldvalue, newvalue in
                    atLeastOneTempus()
                }
                .onChange(of: self.userSettings.isCondicionalI) { oldvalue, newvalue in
                    atLeastOneTempus()
                }
                .onChange(of: self.userSettings.isCondicionalII) perform: { value in
                    atLeastOneTempus()
                })
                                
                Toggle(isOn: $userSettings.isPerfeitoInd, label: {
                    Text("Perfeito Simples Indicativo")
                        .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                
                Toggle(isOn: $userSettings.isImperfeitoInd, label: {
                    Text("Imperfeito Indicativo")
                        .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                
                Toggle(isOn: $userSettings.isPerfeitoCompInd, label: {
                    Text("Perfeito Composto Indicativo")
                        .font(.subheadline)
                })
                .padding(.horizontal, 15.0)
                
                Toggle(isOn: $userSettings.isPMQPInd, label: {
                    Text("Pretérito Mais-que-Perfeito Indicativo")
                        .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                
                Toggle(isOn: $userSettings.isFuturoIInd, label: {
                    Text("Futuro Simples Indicativo")
                        .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                
                
                Toggle(isOn: $userSettings.isFuturoIIInd, label: {
                    Text("Futuro Composto Indicativo")
                        .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
            }.frame(maxWidth: .infinity)
            
            VStack (spacing: 7.5){
                Toggle(isOn: $userSettings.isPresenteSub, label: {
                    Text("Presente Subjunctivo")
                        .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                
                Toggle(isOn: $userSettings.isPerfeitoSub, label: {
                    Text("Perfeito Simples Subjunctivo")
                        .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                
                Toggle(isOn: $userSettings.isImperfeitoSub, label: {
                    Text("Imperfeito Subjunctivo")
                        .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                
                Toggle(isOn: $userSettings.isPMQPSub, label: {
                    Text("Pretérito Mais-que-Perfeito Subjunctivo")
                        .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                
                Toggle(isOn: $userSettings.isFuturoISub, label: {
                    Text("Futuro Simples Subjuncitvo")
                        .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                
                Toggle(isOn: $userSettings.isFuturoIISub, label: {
                    Text("Futuro Composto Subjunctivo")
                        .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
            }.frame(maxWidth: .infinity)
            
            VStack (spacing: 7.5) {
                Toggle(isOn: $userSettings.isCondicionalI, label: {
                    Text("Futuro do Préterito (Condicional I)")
                        .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                
                Toggle(isOn: $userSettings.isCondicionalII, label: {
                    Text("Futuro do Préterito Composto (Condicional II)")
                        .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
            }.frame(maxWidth: .infinity)
            
            Spacer()
        }
    }
    
    //methods
    
    
    func atLeastOneTempus() {
        if self.userSettings.isPresenteInd == false && self.userSettings.isPerfeitoInd == false && self.userSettings.isImperfeitoInd == false && self.userSettings.isPerfeitoCompInd == false && self.userSettings.isPMQPInd == false && self.userSettings.isFuturoIInd == false && self.userSettings.isFuturoIIInd == false && self.userSettings.isPresenteSub == false && self.userSettings.isPerfeitoSub == false && self.userSettings.isImperfeitoSub == false && self.userSettings.isPMQPSub == false && self.userSettings.isFuturoISub == false && self.userSettings.isFuturoIISub == false && self.userSettings.isCondicionalI == false && self.userSettings.isCondicionalII == false {
            self.userSettings.isPresenteInd = true
        }
    }
}

struct ToggleStates_Preview: PreviewProvider {
    static var previews: some View {
        ToggleStates()
            .environmentObject(UserSettings())  // assign environment
    }
}


