import SwiftUI

struct ToggleStates: View {
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        ScrollView(.vertical) {
            Text("Opcões")
            .font(.title2)
            .foregroundColor(Color("style"))
            
            Toggle(isOn: $userSettings.isTu, label: {
                Text("Tu e Vocês?")
                    .font(.subheadline)
            })
            .padding(.horizontal, 15.0)
            .tint(Color("style"))
            .foregroundColor(Color("style"))
            
            VStack (spacing: 7.5) {
                Text("Verbos")
                .foregroundColor(Color("style"))
                
                if #available(iOS 17.0, *) {
                    Toggle(isOn: $userSettings.regulares, label: {
                        Text("verbos regulares")
                            .font(.subheadline)
                    })
                    .padding(.horizontal, 15.0)
                    .tint(Color("style"))
                    .foregroundColor(Color("style"))
                    .onChange(of: [self.userSettings.regulares, self.userSettings.irregulares]) { oldvalue, newvalue in atLeastOneVerbGroup()}
                } else {
                    Toggle(isOn: $userSettings.regulares, label: {
                        Text("verbos regulares")
                            .font(.subheadline)
                    })
                    .padding(.horizontal, 15.0)
                    .tint(Color("style"))
                    .foregroundColor(Color("style"))
                    .onChange(of: self.userSettings.regulares) { value in
                        atLeastOneVerbGroup()
                    }
                    .onChange(of: self.userSettings.irregulares) { value in
                        atLeastOneVerbGroup()
                    }
                }
                
                Toggle(isOn: $userSettings.irregulares, label: {
                    Text("verbos irregulares")
                    .font(.subheadline)
                })
                .padding(.horizontal, 15.0)
                .padding([.bottom], 20)
                .tint(Color("style"))
                .foregroundColor(Color("style"))
            }
            
            
            VStack (spacing: 7.5) {
                Text("Conjugações")
                .foregroundColor(Color("style"))
                if #available(iOS 17.0, *) {
                    Toggle(isOn: $userSettings.isPresenteInd, label: {
                        Text("Presente Indicativo")
                            .font(.subheadline)
                    })
                    .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                    .tint(Color("style"))
                    .foregroundColor(Color("style"))
                    .onChange(of: [self.userSettings.isPresenteInd, self.userSettings.isPerfeitoInd, self.userSettings.isImperfeitoInd, self.userSettings.isPerfeitoCompInd, self.userSettings.isPMQPInd, self.userSettings.isFuturoIInd, self.userSettings.isFuturoIIInd, self.userSettings.isPresenteSub, self.userSettings.isPerfeitoSub, self.userSettings.isImperfeitoSub, self.userSettings.isPMQPSub, self.userSettings.isFuturoISub, self.userSettings.isFuturoIISub, self.userSettings.isCondicionalI, self.userSettings.isCondicionalII]) { oldvalue, newvalue in atLeastOneTempus()}
                } else {
                    // Fallback on earlier versions
                    Toggle(isOn: $userSettings.isPresenteInd, label: {
                        Text("Presente Indicativo")
                            .font(.subheadline)
                    })
                    .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                    .tint(Color("style"))
                    .foregroundColor(Color("style"))
                    .onChange(of: self.userSettings.isPresenteInd) { value in atLeastOneTempus()}
                    .onChange(of: self.userSettings.isPerfeitoInd){ value in atLeastOneTempus()}
                    .onChange(of: self.userSettings.isImperfeitoInd) { value in atLeastOneTempus()}
                    .onChange(of: self.userSettings.isPerfeitoCompInd) { value in atLeastOneTempus()}
                    .onChange(of: self.userSettings.isPMQPInd) { value in atLeastOneTempus()}
                    .onChange(of: self.userSettings.isFuturoIInd) { value in atLeastOneTempus()}
                    .onChange(of: self.userSettings.isFuturoIIInd) { value in atLeastOneTempus()}
                    .onChange(of: self.userSettings.isPresenteSub) { value in atLeastOneTempus()}
                    .onChange(of: self.userSettings.isPerfeitoSub) { value in atLeastOneTempus()}
                    .onChange(of: self.userSettings.isImperfeitoSub) { value in atLeastOneTempus()}
                    .onChange(of: self.userSettings.isPMQPSub) { value in atLeastOneTempus()}
                    .onChange(of: self.userSettings.isFuturoISub) { value in atLeastOneTempus()}
                    .onChange(of: self.userSettings.isFuturoIISub) { value in atLeastOneTempus()}
                    .onChange(of: self.userSettings.isCondicionalII) { value in atLeastOneTempus()}
                }

                Toggle(isOn: $userSettings.isPerfeitoInd, label: {
                    Text("Pretérito Perfeito Simples Indicativo")
                    .font(.subheadline)
                })
                .padding(.horizontal, 15.0)
                .tint(Color("style"))
                .foregroundColor(Color("style"))
                
                Toggle(isOn: $userSettings.isImperfeitoInd, label: {
                    Text("Pretérito Imperfeito Indicativo")
                    .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                .tint(Color("style"))
                .foregroundColor(Color("style"))
                
                Toggle(isOn: $userSettings.isPerfeitoCompInd, label: {
                    Text("Pretérito Perfeito Composto Indicativo")
                    .font(.subheadline)
                })
                .padding(.horizontal, 15.0)
                .tint(Color("style"))
                .foregroundColor(Color("style"))
                
                Toggle(isOn: $userSettings.isPMQPInd, label: {
                    Text("Pretérito Mais-que-Perfeito Indicativo")
                    .font(.subheadline)
                })
                .padding(.horizontal, 15.0)
                .tint(Color("style"))
                .foregroundColor(Color("style"))
                
                Toggle(isOn: $userSettings.isPMQPCompInd, label: {
                    Text("Pretérito Mais-que-perfeito\ncomposto Indicativo")
                    .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                .tint(Color("style"))
                .foregroundColor(Color("style"))
                
                Toggle(isOn: $userSettings.isFuturoIInd, label: {
                    Text("Futuro Simples Indicativo")
                    .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                .tint(Color("style"))
                .foregroundColor(Color("style"))
                
                Toggle(isOn: $userSettings.isFuturoIIInd, label: {
                    Text("Futuro Composto Indicativo")
                    .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                .tint(Color("style"))
                .foregroundColor(Color("style"))
            }.frame(maxWidth: .infinity)
            
            VStack (spacing: 7.5){
                Toggle(isOn: $userSettings.isPresenteSub, label: {
                    Text("Presente Subjuntivo")
                    .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                .tint(Color("style"))
                .foregroundColor(Color("style"))
                
                Toggle(isOn: $userSettings.isPerfeitoSub, label: {
                    Text("Pretérito Perfeito Simples Subjuntivo")
                    .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                .tint(Color("style"))
                .foregroundColor(Color("style"))
                
                Toggle(isOn: $userSettings.isImperfeitoSub, label: {
                    Text("Pretérito Imperfeito Subjuntivo")
                    .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                .tint(Color("style"))
                .foregroundColor(Color("style"))
                
                Toggle(isOn: $userSettings.isPMQPSub, label: {
                    Text("Pretérito Mais-que-Perfeito Subjuntivo")
                    .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                .tint(Color("style"))
                .foregroundColor(Color("style"))
                
                Toggle(isOn: $userSettings.isFuturoISub, label: {
                    Text("Futuro Simples Subjuncitvo")
                    .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                .tint(Color("style"))
                .foregroundColor(Color("style"))
                
                Toggle(isOn: $userSettings.isFuturoIISub, label: {
                    Text("Futuro Composto Subjuntivo")
                    .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                .tint(Color("style"))
                .foregroundColor(Color("style"))
            }.frame(maxWidth: .infinity)
            
            VStack (spacing: 7.5) {
                Toggle(isOn: $userSettings.isCondicionalI, label: {
                    Text("Futuro do Préterito\n(Condicional I)")
                    .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                .tint(Color("style"))
                .foregroundColor(Color("style"))
                
                Toggle(isOn: $userSettings.isCondicionalII, label: {
                    Text("Futuro do Préterito Composto\n(Condicional II)")
                    .font(.subheadline)
                })
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                .tint(Color("style"))
                .foregroundColor(Color("style"))
            }.frame(maxWidth: .infinity)
            
            Spacer()
        }
    }
    
    //methods
    func atLeastOneTempus() {
        if self.userSettings.isPresenteInd == false && self.userSettings.isPerfeitoInd == false && self.userSettings.isImperfeitoInd == false && self.userSettings.isPerfeitoCompInd == false && self.userSettings.isPMQPInd == false && self.userSettings.isPMQPCompInd == false && self.userSettings.isFuturoIInd == false && self.userSettings.isFuturoIIInd == false && self.userSettings.isPresenteSub == false && self.userSettings.isPerfeitoSub == false && self.userSettings.isImperfeitoSub == false && self.userSettings.isPMQPSub == false && self.userSettings.isFuturoISub == false && self.userSettings.isFuturoIISub == false && self.userSettings.isCondicionalI == false && self.userSettings.isCondicionalII == false {
            self.userSettings.isPresenteInd = true
        }
    }
    
    func atLeastOneVerbGroup() {
        if self.userSettings.regulares == false && self.userSettings.irregulares == false {
            self.userSettings.regulares = true
        }
    }
}

struct ToggleStates_Preview: PreviewProvider {
    static var previews: some View {
        ToggleStates()
            .environmentObject(UserSettings())  // assign environment
    }
}


