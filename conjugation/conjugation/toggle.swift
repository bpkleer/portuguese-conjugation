//
//  toggle.swift
//  conjugation
//
//  Created by Philipp Kleer on 03.06.21.
//

import SwiftUI

struct ToggleStates: View {
    @ObservedObject var userSettings = UserSettings()
    
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
                .onChange(of: userSettings.isPresenteInd, perform: { value in
                    atLeastOneTempus()
                })
                .onChange(of: userSettings.isPerfeitoInd, perform: { value in
                    atLeastOneTempus()
                })
                .onChange(of: userSettings.isImperfeitoInd, perform: { value in
                    atLeastOneTempus()
                })
                .onChange(of: userSettings.isPerfeitoCompInd, perform: { value in
                    atLeastOneTempus()
                })
                .onChange(of: userSettings.isPMQPInd, perform: { value in
                    atLeastOneTempus()
                })
                .onChange(of: userSettings.isFuturoIInd, perform: { value in
                    atLeastOneTempus()
                })
                .onChange(of: userSettings.isFuturoIIInd, perform: { value in
                    atLeastOneTempus()
                })
                .onChange(of: userSettings.isPresenteSub, perform: { value in
                    atLeastOneTempus()
                })
                .onChange(of: userSettings.isPerfeitoSub, perform: { value in
                    atLeastOneTempus()
                })
                .onChange(of: userSettings.isImperfeitoSub, perform: { value in
                    atLeastOneTempus()
                })
                .onChange(of: userSettings.isPMQPSub, perform: { value in
                    atLeastOneTempus()
                })
                .onChange(of: userSettings.isFuturoISub, perform: { value in
                    atLeastOneTempus()
                })
                .onChange(of: userSettings.isFuturoIISub, perform: { value in
                    atLeastOneTempus()
                })
                .onChange(of: userSettings.isCondicionalI, perform: { value in
                    atLeastOneTempus()
                })
                .onChange(of: userSettings.isCondicionalII, perform: { value in
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
                    Text("Condicional I")
                        .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                
                Toggle(isOn: $userSettings.isCondicionalII, label: {
                    Text("Condicional II")
                        .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
            }.frame(maxWidth: .infinity)
            
            Spacer()
        }
    }
    
    func atLeastOneTempus() {
        if userSettings.isPresenteInd == false && userSettings.isPerfeitoInd == false && userSettings.isImperfeitoInd == false && userSettings.isPerfeitoCompInd == false && userSettings.isPMQPInd == false && userSettings.isFuturoIInd == false && userSettings.isFuturoIIInd == false && userSettings.isPresenteSub == false && userSettings.isPerfeitoSub == false && userSettings.isImperfeitoSub == false && userSettings.isPMQPSub == false && userSettings.isFuturoIISub == false && userSettings.isFuturoIISub == false && userSettings.isCondicionalI == false && userSettings.isCondicionalII == false {
            userSettings.isPresenteInd = true
        }
    }
}

struct ToggleStates_Preview: PreviewProvider {
    static var previews: some View {
        ToggleStates()
    }
}


