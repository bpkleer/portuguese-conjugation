//
//  Training.swift
//  conjugation
//
//  Created by Philipp Kleer on 01.06.21.
//

import SwiftUI

@available(iOS 15.0, *)
struct ContentView: View {
    // Properties
    @State var person: Int = 0
    @State var sing: String = ""
    @State var sub = ""
    @State var tempus = ""
    @State var verb = ""
    @State var verbHilfe: Array<String> = [""]
    @State var tipp: String = ""
    @State var ziel:String = ""
    @State private var showingAlert = false
    @State var ergebnis: Bool = false
    @State var message: String = " "
    @State var proveHidden: Bool = true
    @State var obtenhaHidden: Bool = false
    @State var allTempus: Array<String> = ["Presente Indicativo"]
    @EnvironmentObject var userSettings: UserSettings
    @FocusState private var isTextFocused: Bool
    // Person variable
    let personArray = [1, 2, 3]
    
    // Singular oder Plural Variable
    let anzahlArray = ["Singular", "Plural"]
    
    //Verben
    let verbArray = [["comprar", "ar", "kaufen"], ["vender", "er", "verkaufen"], ["dividir", "ir", "teilen, aufteilen"],["ser", "ser", "sein"], ["estar", "estar", "sein"], ["ir", "ira", "gehen"], ["vir", "vir", "kommen"], ["ver", "ver", "sehen, ansehen"], ["ter", "ter", "haben"], ["ler", "ler", "lesen"], ["fazer", "fazer", "machen, tun"], ["dizer", "izer", "sagen, sprechen"], ["trazer", "trazer", "bringen, tragen"], ["saber", "saber", "wissen, können"], ["poder", "poder", "können, dürfen"], ["querer", "querer", "wollen"], ["pôr", "por", "setzen, stellen, legen"], ["levar", "ar", "bringen, mitnehmen"], ["dormir", "oir", "schlafen"], ["conhecer", "er", "kennen, kennenlernen"], ["pagar", "ar", "bezahlen"], ["atravessar", "ar", "überqueren, durchqueren"], ["assistir", "ir", "zuschauen, sehen, helfen"], ["decidir", "ir", "entscheiden, beschließen"], ["sentir", "ir", "fühlen, empfinden"], ["abrir", "ir", "öffnen"], ["arrumar", "ar", "aufräumen, organisieren"], ["lavar", "ar", "waschen"], ["limpar", "ar", "putzen, reinigen"], ["deixar", "ar", "erlauben, lassen, aufgeben"], ["falar", "ar", "sprechen"], ["cumprimentar", "ar", "begrüßen, grüßen"], ["responder", "er", "antworten, beantworten"], ["recomendar", "ar", "empfehlen, raten"], ["precisar", "ar", "benötigen, brauchen (mit de)"], ["procurar", "ar", "suchen"], ["passar", "ar", "(vorbei)gehen", "verbringen"], ["comer", "er", "essen"], ["beber", "er", "trinken"], ["ganhar", "ar", "gewinnen, verdienen"], ["melhorar", "ar", "verbessern"], ["cuidar", "ar", "aufpassen, sorgen (mit de)"], ["confiar", "ar", "vertrauen, hoffen auf (mit em)"], ["pensar", "ar", "denken, glauben (an mit em)"], ["deitar", "ar", "hinlegen, legen"], ["acordar", "ar", "aufwachen"], ["gostar", "ar", "mögen, gefallen"], ["discutir", "ir", "diskutieren"], ["acompanhar", "ar", "begleiten, mitmachen"], ["levantar", "ar", "aufbrechen, aufstehen"], ["acontecer", "er", "passieren, geschehen"], ["desagradecer", "er", "missfallen"], ["detestar", "ar", "hassen, verabschauen"], ["significar", "ar", "bedeuten, meinen"], ["tornar", "ar", "(tornar-se) werden"]]
    
    //let verbArrayCair = [["agraudar", "ar", "agraud"], ["ajesuitar", "ar", "ajesuit"], ["ajuizar", "ar", "ajuiz"], ["alaudar", "ar", "alaud"], ["altruizar", "ar", "altruiz"], ["amiudar", "ar", "amiud"], ["arcaizar", "ar", "arcaiz"], ["arruinar", "ar", "arruin"], ["ataudar", "ar", "ataud"], ["comboiar", "ar", "combai"], ["desajuizar", "ar", "desajuiz"], ["desataudar", "ar", "desataud"], ["desenraizar", "ar", "desenraiz"], ["desraizar", "ar", "desraiz"], ["embuizar", "ar", "embuiz"], ["enfaiscar", "ar", "enfaisc"], ["enraizar", "ar", "enraiz"], ["ensaudar", "ar", "ensaud"], ["enviuvar", "ar", "enviuv"], ["esfaiscar", "ar", "esfaisc"], ["esmiudar", "ar", "esmiud"], ["faiscar", "ar", "faisc"], ["gaudar", "ar", "gaud"], ["hebraizar", "ar", "hebraiz"], ["heroizar", "ar", "heroiz"], ["judaizar", "ar", "judaiz"], ["maleinar", "ar", "malein"], ["miudar", "ar", "miud"], ["mobilar", "ar", "mobil"], ["plebeizar", "ar", "plebeiz"], ["ressaudar", "ar", "ressaud"], ["saudar", "ar", "saud"]]
    
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center) {
                Text("Treino de conjugação")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.blue)
                    .multilineTextAlignment(.center)
                    .padding(.all, 2.0)
                    .cornerRadius(5)
                
                Spacer()
                
                Spacer()
                
                NavigationLink(destination: ToggleStates()) {
                    Text("Conjugações")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                    Image(systemName: "chevron.forward.circle")
                        .scaleEffect(1.5)
                }
                
                if obtenhaHidden == false {
                    Button(action: {
                        person = setPerson()
                        sing = setAnzahl()
                        tempus = setTempus()
                        verbHilfe = setVerb()
                        verb = verbHilfe[0]
                        proveHidden = false
                        obtenhaHidden = true
                    }){ HStack(spacing: 0) {
                        Text("Comece o treino!").fontWeight(.semibold).padding().font(.title)
                        Image(systemName: "restart")
                            .scaleEffect(/*@START_MENU_TOKEN@*/2.0/*@END_MENU_TOKEN@*/)
                            .rotationEffect(.degrees(180))
                    }
                    .padding(/*@START_MENU_TOKEN@*/.all, 0.0/*@END_MENU_TOKEN@*/)
                    
                    }
                } else {
                    Spacer()
                }
                
                Spacer()
                
                VStack(spacing: 35) {
                    
                    Spacer()
                    
                    HStack() {
                        Text(String(person) + ". " + sing)
                            .multilineTextAlignment(.trailing)
                            .lineLimit(1)
                            .padding(0.0)
                            .font(.title)
                            .foregroundColor(.blue)
                            .frame(width: 200.0)
                        
                    }
                    
                    Text(String(tempus))
                        .font(.title2)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.trailing)
                    
                    Text(String(verb))
                        .font(.title)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    TextField("Digite sua dica!",
                              text: $tipp,
                              onCommit: {
                        showingAlert = true
                        ziel = trainAim(pessoa: person, numero: sing, caso: tempus, verbo: verbHilfe)
                        ergebnis = pruefen(eingabe: tipp, ziel: ziel)
                        message = createAlertMessage(result: ergebnis, ziel: ziel)
                        tipp = ""
                        obtenhaHidden = true
                        if showingAlert == false {
                            person = setPerson()
                            sing = setAnzahl()
                            tempus = setTempus()
                            verbHilfe = setVerb()
                            verb = verbHilfe[0]
                        }
                        isTextFocused = false
                    }
                    )
                        .padding(.all, 5)
                        .disableAutocorrection(true)
                        .multilineTextAlignment(.center)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .focused($isTextFocused)
                                        
                    // }
                    
                    Spacer()
                    
                    //visibility Change versuchen
                    if proveHidden == false {
                        Button("Teste") {
                            showingAlert = true
                            ziel = trainAim(pessoa: person, numero: sing, caso: tempus, verbo: verbHilfe)
                            ergebnis = pruefen(eingabe: tipp, ziel: ziel)
                            message = createAlertMessage(result: ergebnis, ziel: ziel)
                            tipp = ""
                            obtenhaHidden = true
                            if showingAlert == false {
                                person = setPerson()
                                sing = setAnzahl()
                                tempus = setTempus()
                                verbHilfe = setVerb()
                                verb = verbHilfe[0]
                            }
                            isTextFocused = false
                        } .disabled(tipp == "")
                        .alert(isPresented:$showingAlert) {
                            Alert(
                                title: Text(message + "\n") + Text("\nÜbersetzung: " + String(verbHilfe[2])),
                                dismissButton: .default(Text("Okay")) {
                                    person = setPerson()
                                    sing = setAnzahl()
                                    tempus = setTempus()
                                    verbHilfe = setVerb()
                                    verb = verbHilfe[0]
                                }
                            )
                        }
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        
                    }
                }
                Spacer()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    
    
    //Methods
    
    func setPerson() -> (Int) {
        let trainPerson = personArray.randomElement()!
        return trainPerson
    }
    
    func setAnzahl() -> (String) {
        let trainAnzahl = anzahlArray.randomElement()!
        
        return trainAnzahl
    }
    
    // hier anpassen auf allTempus!
    func setTempus() -> (String) {
        if self.userSettings.isPresenteInd == false {
            if allTempus.contains("Presente Indicativo") {
                allTempus.remove(at: allTempus.firstIndex(of: "Presente Indicativo")!)
            }
        }
        if self.userSettings.isPresenteInd == true {
            if !(allTempus.contains("Presente Indicativo")) {
                allTempus.append("Presente Indicativo")
            }
        }
        if self.userSettings.isPerfeitoInd == false {
            if allTempus.contains("Perfeito Simples Indicativo") {
                allTempus.remove(at: allTempus.firstIndex(of: "Perfeito Simples Indicativo")!)
            }
        }
        if self.userSettings.isPerfeitoInd == true {
            if !(allTempus.contains("Perfeito Simples Indicativo")) {
                allTempus.append("Perfeito Simples Indicativo")
            }
        }
        if self.userSettings.isImperfeitoInd == false {
            if allTempus.contains("Imperfeito Indicativo") {
                allTempus.remove(at: allTempus.firstIndex(of: "Imperfeito Indicativo")!)
            }
        }
        if self.userSettings.isImperfeitoInd == true{
            if !(allTempus.contains("Imperfeito Indicativo")) {
                allTempus.append("Imperfeito Indicativo")
            }
        }
        if self.userSettings.isPerfeitoCompInd == false {
            if allTempus.contains("Perfeito Composto Indicativo") {
                allTempus.remove(at: allTempus.firstIndex(of: "Perfeito Composto Indicativo")!)
            }
        }
        if self.userSettings.isPerfeitoCompInd == true {
            if !(allTempus.contains("Perfeito Composto Indicativo")) {            allTempus.append("Perfeito Composto Indicativo")
            }
        }
        if self.userSettings.isPMQPInd == false {
            if allTempus.contains("Pretérito Mais-que-Perfeito Indicativo") {            allTempus.remove(at: allTempus.firstIndex(of: "Pretérito Mais-que-Perfeito Indicativo")!)
            }
        }
        if self.userSettings.isPMQPInd == true {
            if !(allTempus.contains("Pretérito Mais-que-Perfeito Indicativo")) {
                allTempus.append("Pretérito Mais-que-Perfeito Indicativo")
            }
        }
        if self.userSettings.isFuturoIInd == false {
            if allTempus.contains("Futuro Simples Indicativo") {
                allTempus.remove(at: allTempus.firstIndex(of: "Futuro Simples Indicativo")!)
            }
        }
        if self.userSettings.isFuturoIInd == true {
            if !(allTempus.contains("Futuro Simples Indicativo")) {
                allTempus.append("Futuro Simples Indicativo")
            }
        }
        if self.userSettings.isFuturoIIInd == false {
            if allTempus.contains("Futuro Composto Indicativo") {
                allTempus.remove(at: allTempus.firstIndex(of: "Futuro Composto Indicativo")!)
            }
        }
        if userSettings.isFuturoIIInd == true {
            if !(allTempus.contains("Futuro Composto Indicativo")) {
                allTempus.append("Futuro Composto Indicativo")
            }
        }
        if self.userSettings.isPresenteSub == false {
            if allTempus.contains("Presente Subjunctivo") {
                allTempus.remove(at: allTempus.firstIndex(of: "Presente Subjunctivo")!)
            }
        }
        if self.userSettings.isPresenteSub == true {
            if !(allTempus.contains("Presente Subjunctivo")) {
                allTempus.append("Presente Subjunctivo")
            }
        }
        if self.userSettings.isPerfeitoSub == false {
            if allTempus.contains("Perfeito Simples Subjunctivo") {
                allTempus.remove(at: allTempus.firstIndex(of: "Perfeito Simples Subjunctivo")!)
            }
        }
        if self.userSettings.isPerfeitoSub == true {
            if !(allTempus.contains("Perfeito Simples Subjunctivo")) {
                allTempus.append("Perfeito Simples Subjunctivo")
            }
        }
        if self.userSettings.isImperfeitoSub == false {
            if allTempus.contains("Imperfeito Subjunctivo") {
                allTempus.remove(at: allTempus.firstIndex(of: "Imperfeito Subjunctivo")!)
            }
        }
        if self.userSettings.isImperfeitoSub == true {
            if !(allTempus.contains("Imperfeito Subjunctivo")) {
                allTempus.append("Imperfeito Subjunctivo")
            }
        }
        if self.userSettings.isPMQPSub == false {
            if allTempus.contains("Pretérito Mais-que-Perfeito Subjunctivo") {
                allTempus.remove(at: allTempus.firstIndex(of: "Pretérito Mais-que-Perfeito Subjunctivo")!)
            }
        }
        if self.userSettings.isPMQPSub == true {
            if !(allTempus.contains("Pretérito Mais-que-Perfeito Subjunctivo")) {
                allTempus.append("Pretérito Mais-que-Perfeito Subjunctivo")
            }
        }
        if self.userSettings.isFuturoISub == false {
            if allTempus.contains("Futuro Simples Subjuncitvo") {
                allTempus.remove(at: allTempus.firstIndex(of: "Futuro Simples Subjuncitvo")!)
            }
        }
        if self.userSettings.isFuturoISub == true {
            if !(allTempus.contains("Futuro Simples Subjuncitvo")) {
                allTempus.append("Futuro Simples Subjuncitvo")
            }
        }
        if self.userSettings.isFuturoIISub == false {
            if allTempus.contains("Futuro Composto Subjunctivo") {
                allTempus.remove(at: allTempus.firstIndex(of: "Futuro Composto Subjunctivo")!)
            }
        }
        if self.userSettings.isFuturoIISub == true {
            if !(allTempus.contains("Futuro Composto Subjunctivo")) {
                allTempus.append("Futuro Composto Subjunctivo")
            }
        }
        if self.userSettings.isCondicionalI == false {
            if allTempus.contains("Futuro do Préterito (Condicional I)") {
                allTempus.remove(at: allTempus.firstIndex(of: "Futuro do Préterito (Condicional I)")!)
            }
        }
        if self.userSettings.isCondicionalI == true {
            if !(allTempus.contains("Futuro do Préterito (Condicional I)")) {
                allTempus.append("Futuro do Préterito (Condicional I)")
            }
        }
        if self.userSettings.isCondicionalII == false {
            if allTempus.contains("Futuro do Préterito Composto (Condicional II)") {
                allTempus.remove(at: allTempus.firstIndex(of: "Futuro do Préterito Composto (Condicional II)")!)
            }
        }
        if self.userSettings.isCondicionalII == true {
            if !(allTempus.contains("Futuro do Préterito Composto (Condicional II)")) {
                allTempus.append("Futuro do Préterito Composto (Condicional II)")
            }
        }
        let trainTempus = allTempus.randomElement()!
        
        return (trainTempus)
    }
    
    func setVerb() -> (Array<String>) {
        let rndNumber = Int.random(in: 0...verbArray.count - 1)
        let trainVerb = verbArray[rndNumber]
        return (trainVerb)
    }
}


func trainAim(pessoa: Int, numero: String, caso: String, verbo: Array<String>) -> String {
    var aim: String = ""
    var stamm: String = ""
    var endung: String = ""
    var hilfsverb: String = ""
    var numberInArray: Int = 0
    
    // verschiedene Zeiten
    // Indikativ Tempus
    // Hilfsverb
    // Perfeito Composto
    let ppcHv = ["tenho", "tem", "tem", "temos", "têm", "têm"]
    
    // Pretértio Mais-que-Perfeito Composto
    let pmqpHv = ["tinha", "tinha", "tinha", "tínhamos", "tinham", "tinham"]
    
    // Futuro COmposto
    let futcomHv = ["terei", "terá", "terá", "teremos", "terão", "terão"]
    
    // Perfeito Subjunctivo
    let perfeitoSubHv = ["tenha", "tenha", "tenha", "tenhamos", "tenham", "tenham"]
    
    // Pretérito Mais-que-Perfeito Composto Subjunctivo
    let pmqpCompSubHv = ["tivesse", "tivesse", "tivesse", "tivéssemos", "tivessem", "tivessem"]
    
    // Futuro Composto Subjunctivo
    let futuroCompSubHv = ["tiver", "tiver", "tiver", "tivermos", "tiverem", "tiverem"]
    
    // Condicional II
    let condIIHv = ["teria", "teria", "teria", "teríamos", "teriam", "teriam"]
    
    //Presente
    let presenteAr = ["o", "a", "a", "amos", "am", "am"]
    let presenteEr = ["o", "e", "e", "emos", "em", "em"]
    let presenteIr = ["o", "e", "e", "imos", "em", "em"]
    let presenteSer = ["sou", "é", "é", "somos", "são", "são"]
    let presenteEstar = ["estou", "está", "está", "estamos", "estão", "estão"]
    let presenteIra = ["vou", "vai", "vai", "vamos", "vão", "vão"]
    let presenteVir = ["venho", "vem", "vem", "vimos", "vêm", "vêm"]
    let presenteVer = ["vejo", "vê", "vê", "vemos", "vêem", "vêem"]
    let presenteTer = ["tenho", "tem", "tem", "temos", "têm", "têm"]
    let presenteLer = ["leio", "lê", "lê", "lemos", "leem", "leem"]
    let presenteFazer = ["faço", "faz", "faz", "fazemos", "fazem", "fazem"]
    let presenteIzer = ["go", "z", "z", "zemos", "zem", "zem"]
    let presenteTrazer = ["trago", "traz", "traz", "trazemos", "trazem", "trazem"]
    let presenteSaber = ["sei", "sabe", "sabe", "sabemos", "sabem", "sabem"]
    let presentePoder = ["posso", "pode", "pode", "podemos", "podem", "podem"]
    let presentePerder = ["perco", "perde", "perde", "perdemos", "perdem", "perdem"]
    let presenteQuerer = ["quero", "quer", "quer", "queremos", "querem", "querem"]
    let presentePor = ["ponho", "põe", "põe", "pomos", "pôem", "põem"]
    let presenteOir = ["urmo", "orme", "orme", "ormimos", "ormem", "ormem"]
    
    // Perfeito
    let perfeitoAr = ["ei", "ou", "ou", "ámos", "aram", "aram"]
    let perfeitoEr = ["i", "eu", "eu", "emos", "eram", "eram"]
    let perfeitoIr = ["i", "iu", "iu", "imos", "iram", "iram"]
    let perfeitoSer = ["fui", "foi", "foi", "fomos", "foram", "foram"]
    let perfeitoEstar = ["estive", "esteve", "esteve", "estivemos", "estiveram", "estiveram"]
    let perfeitoVir = ["vim", "veio", "veio", "viemos", "vieram", "vieram"]
    let perfeitoTer = ["tive", "teve", "teve", "tivemos", "tiveram", "tiveram"]
    let perfeitoFazer = ["fiz", "fez", "fez", "fizemos", "fizeram", "fizeram"]
    let perfeitoIzer = ["sse", "sse", "sse", "ssemos", "sseram", "sseram"]
    let perfeitoTrazer = ["trouxe", "trouxe", "trouxe", "trouxemos", "trouxeram", "trouxeram"]
    let perfeitoSaber = ["soube", "soube", "soube", "soubemos", "souberam", "souberam"]
    let perfeitoPoder = ["pude", "pôde", "pôde", "pudemos", "puderam", "puderam"]
    let perfeitoQuerer = ["quis", "quis", "quis", "quisemos", "quiseram", "quiseram"]
    let perfeitoPor = ["pus", "pôs", "pôs", "pusemos", "puseram", "puseram"]
    
    // Imperfeito
    let imperfeitoAr = ["ava", "ava", "ava", "ávamos", "avam", "avam"]
    let imperfeitoEr = ["ia", "ia", "ia", "íamos", "iam", "iam"]
    let imperfeitoIr = ["ia", "ia", "ia", "íamos", "iam", "iam"]
    let imperfeitoSer = ["era", "era", "era", "éramos", "eram", "eram"]
    let imperfeitoVir = ["vinha", "vinha", "vinha", "vinhamos", "vinham", "vinham"]
    let imperfeitoTer = ["tinha", "tinha", "tinha", "tínhamos", "tinham", "tinham"]
    let imperfeitoPor = ["punha", "punha", "punha", "púnhamos", "punham", "punham"]
    
    // Futuro Simples
    let futuroSimplesAr = ["arei", "ará", "ará", "aremos", "arão", "arão"]
    let futuroSimplesEr = ["erei", "erá", "erá", "eremos", "erão", "erão"]
    let futuroSimplesIr = ["irei", "irá", "irá", "iremos", "irão", "irão"]
    let futuroSimplesSer = ["serei", "será", "será", "seremos", "serão", "serão"]
    let futuroSimplesFazer = ["farei", "fará", "fará", "faremos", "farão", "farão"]
    let futuroSimplesIzer = ["rei", "rá", "rá", "remos", "rão", "rão"]
    let futuroSimplesPor = ["porei", "porá", "porá", "poremos", "porão", "porão"]
    
    // Participio
    let participioAr = "ado"
    let participioEr = "ido"
    let participioIr = "ido"
    let participioVir = "indo"
    let participioVer = "visto"
    let participioFazer = "feito"
    let participioDizer = "dito"
    let participioPor = "posto"
    let participioAbrir = "aberto"
    
    // Subjunctivo
    // Presente Subjunctivo
    let presenteSubAr = ["e", "e", "e", "emos", "em", "em"]
    let presenteSubEr = ["a", "a", "a", "amos", "am", "am"]
    let presenteSubIr = ["a", "a", "a", "amos", "am", "am"]
    let presenteSubSer = ["seja", "seja", "seja", "sejamos", "sejam", "sejam"]
    let presenteSubEstar = ["esteja", "esteja", "esteja", "estejamos", "estejam", "estejam"]
    let presenteSubIra = ["vá", "vá", "vá", "vamos", "vão", "vão"]
    let presenteSubVir = ["venha", "venha", "venha", "venhamos", "venham", "venham"]
    let presenteSubVer = ["veja", "veja", "veja", "vejamos", "vejam", "vejam"]
    let presenteSubTer = ["tenha", "tenha", "tenha", "tenhamos", "tenham", "tenham"]
    let presenteSubLer = ["leia", "leia", "leia", "leiamos", "leiam", "leiam"]
    let presenteSubFazer = ["faça", "faças", "faça", "façamos", "façam", "façam"]
    let presenteSubIzer = ["ga", "ga", "ga", "gamos", "gam", "gam"]
    let presenteSubSaber = ["saiba", "saiba", "saiba", "saibamos", "saibam", "saibam"]
    let presenteSubPoder = ["possa", "possa", "possa", "possamos", "possam", "possam"]
    let presenteSubPerder = ["perca", "perca", "perca", "percamos", "percam", "percam"]
    let presenteSubQuerer = ["queira", "queira", "queira", "queiramos", "queiram", "queiram"]
    let presenteSubPor = ["ponha", "ponha", "ponha", "ponhamos", "ponham", "ponham"]
    let presenteSubOir = ["urma", "urma", "urma", "urmamos", "urmam", "urmam"]
    
    // Pretérito Imperfeito Subjunctivo
    let imperfeitoSubAr = ["asse", "asse", "asse", "ássemos", "assem", "assem"]
    let imperfeitoSubEr = ["esse", "esse", "esse", "éssemos", "essem", "essem"]
    let imperfeitoSubIr = ["isse", "isse", "isse", "issemos", "issem", "issem"]
    let imperfeitoSubSer = ["fosse", "fosse", "fosse", "fôssemos", "fossem", "fossem"]
    let imperfeitoSubEstar = ["estivesse", "estivesse", "estivesse", "estivéssemos", "estivessem", "estivessem"]
    let imperfeitoSubIra = ["fosse", "fosse", "fosse", "fôssemos", "fossem", "fossem"]
    let imperfeitoSubVir = ["viesse", "viesse", "viesse", "viessem", "viessem"]
    let imperfeitoSubTer = ["tivesse", "tivesse", "tivesse", "tivéssemos", "tivessem", "tivessem"]
    let imperfeitoSubFazer = ["fizesse", "fizesse", "fizesse", "fizéssemos", "fizéssem", "fizessem"]
    let imperfeitoSubIzer = ["ssesse", "ssesse", "ssesse", "sséssemos", "ssessem", "ssessem"]
    let imperfeitoSubTrazer = ["trouxesse", "trouxesse", "trouxesse", "trouxéssemos", "trouxessem", "trouxessem"]
    let imperfeitoSubSaber = ["soubesse", "soubesse", "soubesse", "soubéssemos", "soubessem", "soubessem"]
    let imperfeitoSubPoder = ["pudesse", "pudesse", "pudesse", "pudéssemos", "pudessem", "pudessem"]
    let imperfeitoSubQuerer = ["quisesse", "quisesse", "quisesse", "quiséssemos", "quisessem", "quisessem"]
    let imperfeitoSubPor = ["pusesse", "pusesse", "pusesse", "puséssemos", "pusessem", "pusessem"]
    
    // Futuro Subjunctivo
    let futuroSubAr = ["ar", "ar", "ar", "armos", "arem", "arem"]
    let futuroSubEr = ["er", "er", "er", "ermos", "erem", "erem"]
    let futuroSubIr = ["ir", "ir", "ir", "irmos", "irem", "irem"]
    let futuroSubSer = ["for", "for", "for", "formos", "forem", "forem"]
    let futuroSubEstar = ["estiver", "estiver", "estiver", "estivermos", "estiverem", "estiverem"]
    let futuroSubIra = ["for", "for", "for", "formos", "forem", "forem"]
    let futuroSubVir = ["vier", "vier", "vier", "viermos", "vierem", "vierem"]
    let futuroSubTer  = ["tiver", "tiver", "tiver", "tivermos", "tiverem", "tiverem"]
    let futuroSubFazer = ["fizer", "fizer", "fizer", "fizermos", "fizerem", "fizerem"]
    let futuroSubIzer = ["sser", "sser", "disser", "ssermos", "sserem", "sserem"]
    let futuroSubTrazer = ["trouxer", "trouxer", "trouxer", "trouxermos", "trouxerem", "trouxerem"]
    let futuroSubSaber = ["souber", "souber", "souber", "soubermos", "souberem", "souberem"]
    let futuroSubPoder = ["puder", "puder", "puder", "pudermos", "puderem", "puderem"]
    let futuroSubQuerer = ["quiser", "quiser", "quiser", "quisermos", "quiserem", "quiserem"]
    let futuroSubPor = ["puser", "puser", "puser", "pusermos", "puserem", "puserem"]
    
    // Condicional
    // Condicional I  érito Simples
    let condicionalIAr = ["aria", "aria", "aria", "aríamos", "ariam", "ariam"]
    let condicionalIEr = ["eria", "eria", "eria", "eríamos", "eriam", "eriam"]
    let condicionalIIr = ["iria", "iria", "iria", "iríamos", "iriam", "iriam"]
    let condicionalIVir = ["viria", "viria", "viria", "viriámos", "viriam", "viriam"]
    let condicionalIFazer = ["faria", "faria", "faria", "faríamos", "fariam", "fariam"]
    let condicionalIIzer = ["ria", "ria", "ria", "ríamos", "riam", "riam"]
    let condicionalIPor = ["poria", "poria", "poria", "poríamos", "poriam", "poriam"]
    
    if numero == "Singular" {
        numberInArray = pessoa - 1
    } else {
        numberInArray = pessoa + 2
    }
    
    if caso == "Presente Indicativo" {
        stamm = String(verbo[0].dropLast(2))
        if verbo[1] == "ar" {
            endung = presenteAr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "er" {
            endung = presenteEr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "ir" {
            endung = presenteIr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "ira" {
            endung = presenteIra[numberInArray]
        } else if verbo[1] == "ser" {
            endung = presenteSer[numberInArray]
            aim = endung
        } else if verbo[1] == "estar" {
            endung = presenteEstar[numberInArray]
            aim = endung
        } else if verbo[1] == "estar" {
            endung = presenteIra[numberInArray]
            aim = endung
        } else if verbo[1] == "vir" {
            endung = presenteVir[numberInArray]
            aim = endung
        } else if verbo[1] == "ver" {
            endung = presenteVer[numberInArray]
            aim = endung
        } else if verbo[1] == "ter" {
            endung = presenteTer[numberInArray]
            aim = endung
        } else if verbo[1] == "ler" {
            endung = presenteLer[numberInArray]
            aim = endung
        } else if verbo[1] == "fazer" {
            endung = presenteFazer[numberInArray]
            aim = endung
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(3))
            endung = presenteIzer[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "trazer" {
            endung = presenteTrazer[numberInArray]
            aim = endung
        } else if verbo[1] == "saber" {
            endung = presenteSaber[numberInArray]
            aim = endung
        } else if verbo[1] == "poder" {
            endung = presentePoder[numberInArray]
            aim = endung
        } else if verbo[1] == "perder" {
            endung = presentePerder[numberInArray]
            aim = endung
        } else if verbo[1] == "querer" {
            endung = presenteQuerer[numberInArray]
            aim = endung
        } else if verbo[1] == "por" {
            endung = presentePor[numberInArray]
            aim = endung
        } else if verbo[1] == "oir" {
            stamm = String(verbo[0].prefix(1))
            endung = presenteOir[numberInArray]
            aim = stamm + endung
        }
    } else if caso == "Perfeito Simples Indicativo" {
        stamm = String(verbo[0].dropLast(2))
        if verbo[1] == "ar" {
            endung = perfeitoAr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "er" || verbo[1] == "ler" || verbo[1] == "perder" {
            endung = perfeitoEr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "ir" || verbo[1] == "ver" || verbo[1] == "oir" {
            endung = perfeitoIr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "ser" || verbo[1] == "ira" {
            endung = perfeitoSer[numberInArray]
            aim = endung
        } else if verbo[1] == "estar" {
            endung = perfeitoEstar[numberInArray]
            aim = endung
        } else if verbo[1] == "vir" {
            endung = perfeitoVir[numberInArray]
            aim = endung
        } else if verbo[1] == "ter" {
            endung = perfeitoTer[numberInArray]
            aim = endung
        } else if verbo[1] == "fazer" {
            endung = perfeitoFazer[numberInArray]
            aim = endung
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(3))
            endung = perfeitoIzer[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "trazer" {
            endung = perfeitoTrazer[numberInArray]
            aim = endung
        } else if verbo[1] == "saber" {
            endung = perfeitoSaber[numberInArray]
            aim = endung
        } else if verbo[1] == "poder" {
            endung = perfeitoPoder[numberInArray]
            aim = endung
        } else if verbo[1] == "querer" {
            endung = perfeitoQuerer[numberInArray]
            aim = endung
        } else if verbo[1] == "por" {
            endung = perfeitoPor[numberInArray]
            aim = endung
        }
    } else if caso == "Imperfeito Indicativo" {
        stamm = String(verbo[0].dropLast(2))
        if verbo[1] == "ar" || verbo[1] == "estar" {
            endung = imperfeitoAr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "er" || verbo[1] == "ver" || verbo[1] == "ler" || verbo[1] == "fazer" || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "perder" || verbo[1] == "querer" {
            endung = imperfeitoEr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "izer" || verbo[1] == "oir" {
            endung = imperfeitoIr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "ser" {
            endung = imperfeitoSer[numberInArray]
            aim = endung
        } else if verbo[1] == "vir" {
            endung = imperfeitoVir[numberInArray]
            aim = endung
        } else if verbo[1] == "ter" {
            endung = imperfeitoTer[numberInArray]
            aim = endung
        } else if verbo[1] == "por" {
            endung = imperfeitoPor[numberInArray]
            aim = endung
        }
    } else if caso == "Perfeito Composto Indicativo" {
        hilfsverb  = ppcHv[numberInArray]
        stamm = String(verbo[0].dropLast(2))
        if verbo[0] == "dizer" {
            endung = participioDizer
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "ar" || verbo[1] == "estar" {
            endung = participioAr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "er" || verbo[1] == "ler" || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "perder" || verbo[1] == "querer" {
            endung = participioEr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter" || verbo[1] == "oir" {
            endung = participioIr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "ser" {
            endung = participioEr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "vir" {
            endung = participioVir
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "ver" {
            endung = participioVer
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "fazer" {
            endung = participioFazer
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(4))
            endung = stamm + participioEr
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "por" {
            endung = participioPor
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "abrir" {
            endung = participioAbrir
            aim = hilfsverb + " " + endung
        }
    } else if caso == "Pretérito Mais-que-Perfeito Indicativo" {
        hilfsverb  = pmqpHv[numberInArray]
        stamm = String(verbo[0].dropLast(2))
        if verbo[0] == "dizer" {
            endung = participioDizer
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "ar" || verbo[1] == "estar" {
            endung = participioAr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "er" || verbo[1] == "ler" || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "perder" || verbo[1] == "querer" {
            endung = participioEr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter" || verbo[1] == "oir" {
            endung = participioIr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "ser" {
            endung = participioEr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "vir" {
            endung = participioVir
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "ver" {
            endung = participioVer
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "fazer" {
            endung = participioFazer
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(4))
            endung = stamm + participioEr
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "por" {
            endung = participioPor
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "abrir" {
            endung = participioAbrir
            aim = hilfsverb + " " + endung
        }
    } else if caso == "Futuro Simples Indicativo" {
        stamm = String(verbo[0].dropLast(2))
        if verbo[1] == "ar" || verbo[1] == "estar" {
            endung = futuroSimplesAr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "er" || verbo[1] == "ver" || verbo[1] == "ter" || verbo[1] == "ler" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "perder" || verbo[1] == "querer" {
            endung = futuroSimplesEr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "vir" || verbo[1] == "oir" {
            endung = futuroSimplesIr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "ser" {
            endung = futuroSimplesSer[numberInArray]
        } else if verbo[1] == "fazer" {
            endung = futuroSimplesFazer[numberInArray]
            aim = endung
        } else if verbo[1] == "izer" || verbo[1] == "trazer" {
            stamm = String(verbo[0].dropLast(3))
            endung = futuroSimplesIzer[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "por" {
            endung = futuroSimplesPor[numberInArray]
            aim = endung
        }
    } else if caso == "Futuro Composto Indicativo" {
        hilfsverb  = futcomHv[numberInArray]
        stamm = String(verbo[0].dropLast(2))
        if verbo[0] == "dizer" {
            endung = participioDizer
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "ar" || verbo[1] == "estar" {
            endung = participioAr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "er" || verbo[1] == "ler" || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "perder" || verbo[1] == "querer" {
            endung = participioEr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter" || verbo[1] == "oir" {
            endung = participioIr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "ser" {
            endung = participioEr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "vir" {
            endung = participioVir
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "ver" {
            endung = participioVer
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "fazer" {
            endung = participioFazer
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(4))
            endung = stamm + participioEr
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "por" {
            endung = participioPor
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "abrir" {
            endung = participioAbrir
            aim = hilfsverb + " " + endung
        }
    } else if caso == "Presente Subjunctivo" {
        stamm = String(verbo[0].dropLast(2))
        if verbo[1] == "ar" {
            endung = presenteSubAr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "er" {
            endung = presenteSubEr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "ir" {
            endung = presenteSubIr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "ser" {
            endung = presenteSubSer[numberInArray]
        } else if verbo[1] == "estar" {
            endung = presenteSubEstar[numberInArray]
            aim = endung
        } else if verbo[1] == "ira" {
            endung = presenteSubIra[numberInArray]
            aim = endung
        } else if verbo[1] == "vir" {
            endung = presenteSubVir[numberInArray]
            aim = endung
        } else if verbo[1] == "ver" {
            endung = presenteSubVer[numberInArray]
            aim = endung
        } else if verbo[1] == "ter" {
            endung = presenteSubTer[numberInArray]
            aim = endung
        } else if verbo[1] == "ler" {
            endung = presenteSubLer[numberInArray]
            aim = endung
        } else if verbo[1] == "fazer" {
            endung = presenteSubFazer[numberInArray]
            aim = endung
        } else if verbo[1] == "izer" || verbo[1] == "trazer" {
            stamm = String(verbo[0].dropLast(3))
            endung = presenteSubIzer[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "saber" {
            endung = presenteSubSaber[numberInArray]
            aim = endung
        } else if verbo[1] == "poder" {
            endung = presenteSubPoder[numberInArray]
            aim = endung
        } else if verbo[1] == "perder" {
            endung = presenteSubPerder[numberInArray]
            aim = endung
        } else if verbo[1] == "querer" {
            endung = presenteSubQuerer[numberInArray]
            aim = endung
        } else if verbo[1] == "por" {
            endung = presenteSubPor[numberInArray]
            aim = endung
        } else if verbo[1] == "oir" {
            stamm = String(verbo[0].prefix(1))
            endung = presenteSubOir[numberInArray]
            aim = stamm + endung
        }
    } else if caso == "Perfeito Simples Subjunctivo" {
        hilfsverb  = perfeitoSubHv[numberInArray]
        stamm = String(verbo[0].dropLast(2))
        if verbo[0] == "dizer" {
            endung = participioDizer
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "ar" || verbo[1] == "estar" {
            endung = participioAr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "er" || verbo[1] == "ler" || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "perder" || verbo[1] == "querer" {
            endung = participioEr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter" || verbo[1] == "oir" {
            endung = participioIr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "ser" {
            endung = participioEr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "vir" {
            endung = participioVir
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "ver" {
            endung = participioVer
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "fazer" {
            endung = participioFazer
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(4))
            endung = stamm + participioEr
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "por" {
            endung = participioPor
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "abrir" {
            endung = participioAbrir
            aim = hilfsverb + " " + endung
        }
    } else if caso == "Imperfeito Subjunctivo" {
        stamm = String(verbo[0].dropLast(2))
        if verbo[1] == "ar" {
            endung = imperfeitoSubAr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "er" || verbo[1] == "ler"  || verbo[1] == "perder" {
            endung = imperfeitoSubEr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "ir" || verbo[1] == "ver" || verbo[1] == "oir" {
            endung = imperfeitoSubIr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "ser" {
            endung = imperfeitoSubSer[numberInArray]
            aim = endung
        } else if verbo[1] == "estar" {
            endung = imperfeitoSubEstar[numberInArray]
            aim = endung
        } else if verbo[1] == "ira" {
            endung = imperfeitoSubIra[numberInArray]
            aim = endung
        } else if verbo[1] == "vir" {
            endung = imperfeitoSubVir[numberInArray]
            aim = endung
        } else if verbo[1] == "ter" {
            endung = imperfeitoSubTer[numberInArray]
            aim = endung
        } else if verbo[1] == "fazer" {
            endung = imperfeitoSubFazer[numberInArray]
            aim = endung
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(3))
            endung = imperfeitoSubIzer[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "trazer" {
            endung = imperfeitoSubTrazer[numberInArray]
            aim = endung
        } else if verbo[1] == "saber" {
            endung = imperfeitoSubSaber[numberInArray]
            aim = endung
        } else if verbo[1] == "poder" {
            endung = imperfeitoSubPoder[numberInArray]
            aim = endung
        } else if verbo[1] == "querer" {
            endung = imperfeitoSubQuerer[numberInArray]
            aim = endung
        } else if verbo[1] == "por" {
            endung = imperfeitoSubPor[numberInArray]
            aim = endung
        }
    } else if caso == "Pretérito Mais-que-Perfeito Subjunctivo"{
        hilfsverb  = pmqpCompSubHv[numberInArray]
        stamm = String(verbo[0].dropLast(2))
        if verbo[0] == "dizer" {
            endung = participioDizer
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "ar" || verbo[1] == "estar" {
            endung = participioAr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "er" || verbo[1] == "ler" || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "perder" || verbo[1] == "querer" {
            endung = participioEr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter" || verbo[1] == "oir" {
            endung = participioIr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "ser" {
            endung = participioEr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "vir" {
            endung = participioVir
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "ver" {
            endung = participioVer
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "fazer" {
            endung = participioFazer
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(4))
            endung = stamm + participioEr
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "por" {
            endung = participioPor
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "abrir" {
            endung = participioAbrir
            aim = hilfsverb + " " + endung
        }
    } else if caso == "Futuro Simples Subjuncitvo" {
        stamm = String(verbo[0].dropLast(2))
        if verbo[1] == "ar" {
            endung = futuroSubAr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "er" || verbo[1] == "ler"  || verbo[1] == "perder" {
            endung = futuroSubEr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "ir" || verbo[1] == "ver" || verbo[1] == "oir" {
            endung = futuroSubIr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "ser" {
            endung = futuroSubSer[numberInArray]
            aim = endung
        } else if verbo[1] == "estar" {
            endung = futuroSubEstar[numberInArray]
            aim = endung
        } else if verbo[1] == "ira" {
            endung = futuroSubIra[numberInArray]
            aim = endung
        }  else if verbo[1] == "vir" {
            endung = futuroSubVir[numberInArray]
            aim = endung
        } else if verbo[1] == "ter" {
            endung = futuroSubTer[numberInArray]
            aim = endung
        } else if verbo[1] == "fazer" {
            endung = futuroSubFazer[numberInArray]
            aim = endung
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(3))
            endung = futuroSubIzer[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "trazer" {
            endung = futuroSubTrazer[numberInArray]
            aim = endung
        } else if verbo[1] == "saber" {
            endung = futuroSubSaber[numberInArray]
            aim = endung
        } else if verbo[1] == "poder" {
            endung = futuroSubPoder[numberInArray]
            aim = endung
        } else if verbo[1] == "querer" {
            endung = futuroSubQuerer[numberInArray]
            aim = endung
        } else if verbo[1] == "por" {
            endung = futuroSubPor[numberInArray]
            aim = endung
        }
    } else if caso == "Futuro Composto Subjunctivo" {
        hilfsverb  = futuroCompSubHv[numberInArray]
        stamm = String(verbo[0].dropLast(2))
        if verbo[0] == "dizer" {
            endung = participioDizer
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "ar" || verbo[1] == "estar" {
            endung = participioAr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "er" || verbo[1] == "ler" || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "perder" || verbo[1] == "querer" {
            endung = participioEr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter" || verbo[1] == "oir" {
            endung = participioIr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "ser" {
            endung = participioEr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "vir" {
            endung = participioVir
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "ver" {
            endung = participioVer
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "fazer" {
            endung = participioFazer
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(4))
            endung = stamm + participioEr
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "por" {
            endung = participioPor
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "abrir" {
            endung = participioAbrir
            aim = hilfsverb + " " + endung
        }
    } else if caso == "Futuro do Préterito (Condicional I)"{
        stamm = String(verbo[0].dropLast(2))
        if verbo[1] == "ar" || verbo[1] == "estar" {
            endung = condicionalIAr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "er" || verbo[1] == "ver"  || verbo[1] == "ter" || verbo[1] == "ler" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "perder" || verbo[1] == "querer" {
            endung = condicionalIEr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "oir" {
            endung = condicionalIIr[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "ser" {
            endung = condicionalIEr[numberInArray]
            aim = endung
        } else if verbo[1] == "vir" {
            endung = condicionalIVir[numberInArray]
            aim = endung
        } else if verbo[1] == "fazer" {
            endung = condicionalIFazer[numberInArray]
            aim = endung
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(3))
            endung = condicionalIIzer[numberInArray]
            aim = stamm + endung
        } else if verbo[1] == "por" {
            endung = condicionalIPor[numberInArray]
            aim = endung
        }
    } else if caso == "Futuro do Préterito Composto (Condicional II)"{
        hilfsverb  = condIIHv[numberInArray]
        stamm = String(verbo[0].dropLast(2))
        if verbo[0] == "dizer" {
            endung = participioDizer
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "ar" || verbo[1] == "estar" {
            endung = participioAr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "er" || verbo[1] == "ler" || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "perder" {
            endung = participioEr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter" || verbo[1] == "oir" {
            endung = participioIr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "ser" {
            endung = participioEr
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "vir" {
            endung = participioVir
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "ver" {
            endung = participioVer
            aim = hilfsverb + " " + stamm + endung
        } else if verbo[1] == "fazer" {
            endung = participioFazer
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(4))
            endung = stamm + participioEr
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "por" {
            endung = participioPor
            aim = hilfsverb + " " + endung
        } else if verbo[1] == "abrir" {
            endung = participioAbrir
            aim = hilfsverb + " " + endung
        }
    }

    stamm = "";
    endung = "";
    hilfsverb = "";
    numberInArray = 0;
    
    return (aim)
}

func pruefen(eingabe: String, ziel: String) -> Bool {
    let ergebnis: Bool
    if eingabe == ziel {
        ergebnis = true
    } else {
        ergebnis = false
    }

    
    return ergebnis
}

func createAlertMessage(result: Bool, ziel: String) -> String {
    var alertMessage: String = ""
    if result == true {
        alertMessage = "Deine Eingabe war korrekt! :)" 
    } else {
        alertMessage = "Deine Eingabe war falsch! :( \n" + "\n Korrekte Form ist: " + ziel
    }
    return alertMessage
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserSettings())  // assign environment
    }
}



// + Text("\nKorrekte Form ist: " + ziel + "\n")
