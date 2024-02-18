// Portuguese Conjugation app (not every special verbs)
// Created by Philipp Kleer, last changes 2023-06-08

import SwiftUI

@available(iOS 16.0, *)

struct ContentView: View {
    // variables for body view
    @State var person: Int = 0
    @State var sing: String = ""
    @State var sub = ""
    @State var tempus = ""
    @State var verb = ""
    @State var verbHilfe: Array<String> = [""]
    @State var tipp: String = ""
    @State var ziel: String = ""
    @State private var showingAlert = false
    @State var ergebnis: Bool = false
    @State var message: String = " "
    @State var proveHidden: Bool = true
    @State var obtenhaHidden: Bool = false
    @State var allTempus: Array<String> = ["Presente Indicativo"]
    
    // variables to count wrong and false answers
    @State var correto: Int = 0
    @State var falso: Int = 0
    
    // to check that same tense will not repeated in the last three times (with more than 4 tenses chosen)
    @State var lastverb: [[String]] = []
    @State var trainVerb: [String] = []
    @State var countarray: Int = 0
    
    @State var lastcase: Array<String> = ["", "", ""]
    @State var countcase: Int = 0
    @State var trainTempus: String = ""
    
    // environment
    @EnvironmentObject var userSettings: UserSettings
    @FocusState private var isTextFocused: Bool
    // Person variable
    // second person excluded, because not important in português do Brasil
    let personArray = [1, 3]
    
    // Singular or Plural Variable
    let anzahlArray = ["Singular", "Plural"]
    
    // verbs
    let verbArray = [["comprar", "ar", "kaufen"], ["vender", "er", "verkaufen"], ["dividir", "ir", "teilen, aufteilen"], ["ler", "ler", "lesen"], ["dizer", "izer", "sagen, sprechen"], ["levar", "ar", "bringen, mitnehmen"], ["dormir", "oir", "schlafen"], ["conhecer", "er", "kennen, kennenlernen"], ["pagar", "ar", "bezahlen"], ["atravessar", "ar", "überqueren, durchqueren"], ["assistir", "ir", "zuschauen, sehen, helfen"], ["decidir", "ir", "entscheiden, beschließen"], ["sentir", "ir", "fühlen, empfinden"], ["abrir", "ir", "öffnen"], ["arrumar", "ar", "aufräumen, organisieren"], ["lavar", "ar", "waschen"], ["limpar", "ar", "putzen, reinigen"], ["deixar", "ar", "erlauben, lassen, aufgeben"], ["falar", "ar", "sprechen"], ["cumprimentar", "ar", "begrüßen, grüßen"], ["responder", "er", "antworten, beantworten"], ["recomendar", "ar", "empfehlen, raten"], ["precisar", "ar", "benötigen, brauchen (mit de)"], ["procurar", "ar", "suchen"], ["passar", "ar", "(vorbei)gehen", "verbringen"], ["comer", "er", "essen"], ["beber", "er", "trinken"], ["ganhar", "ar", "gewinnen, verdienen"], ["melhorar", "ar", "verbessern"], ["cuidar", "ar", "aufpassen, sorgen (mit de)"], ["confiar", "ar", "vertrauen, hoffen auf (mit em)"], ["pensar", "ar", "denken, glauben (an mit em)"], ["deitar", "ar", "hinlegen, legen"], ["acordar", "ar", "aufwachen"], ["gostar", "ar", "mögen, gefallen"], ["discutir", "ir", "diskutieren"], ["acompanhar", "ar", "begleiten, mitmachen"], ["levantar", "ar", "aufbrechen, aufstehen"], ["acontecer", "er", "passieren, geschehen"], ["desagradecer", "er", "missfallen"], ["detestar", "ar", "hassen, verabschauen"], ["significar", "ar", "bedeuten, meinen"], ["tornar", "ar", "(tornar-se) werden"], ["sortear", "ear", "auslosen"], ["passear", "ear", "spazieren gehen"]]
    
    let verbIrrArray = [["ser", "ser", "sein"], ["estar", "estar", "sein"], ["ir", "ira", "gehen"], ["vir", "vir", "kommen"], ["ver", "ver", "sehen, ansehen"], ["ter", "ter", "haben"], ["fazer", "fazer", "machen, tun"], ["dizer", "izer", "sagen, sprechen"], ["trazer", "trazer", "bringen, tragen"], ["saber", "saber", "wissen, können"], ["poder", "poder", "können, dürfen"], ["querer", "querer", "wollen"], ["pôr", "por", "setzen, stellen, legen"]]
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center) {
                
                // choosing tenses
                NavigationLink(destination: ToggleStates()) {
                    Text("Conjugações")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color("style"))
                    Image(systemName: "chevron.forward.circle")
                        .scaleEffect(1.5)
                        .foregroundColor(Color("style"))
                }.padding(.top, 40)
                
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
                        Text("Comece o treino!").fontWeight(.semibold).padding().font(.title).foregroundColor(Color("style"))
                        Image(systemName: "restart")
                            .scaleEffect(2.0)
                            .rotationEffect(.degrees(180))
                            .foregroundColor(Color("style"))
                    }
                    .padding(/*@START_MENU_TOKEN@*/.all, 0.0/*@END_MENU_TOKEN@*/)
                        
                    }
                }
                
                VStack(spacing: 35) {
                    Text("Correto: " + String(correto) + " / Falso: " + String(falso))
                        .foregroundColor(Color("style"))
                        .padding(.top, 20)
                    
                    Button(action: {
                        correto = 0
                        falso = 0
                    }){ HStack(spacing: 0) {
                        Text("Reiniciar o números").foregroundColor(Color("style"))
                        Image(systemName: "arrow.2.squarepath")
                            .scaleEffect(1.0)
                            .rotationEffect(.degrees(180))
                            .foregroundColor(Color("style"))
                    }}.padding(.all, 0.0)
                    
                    HStack() {
                        Text(String(person) + ". " + sing)
                            .multilineTextAlignment(.trailing)
                            .lineLimit(1)
                            .padding(0.0)
                            .font(.title)
                            .foregroundColor(Color("style"))
                            .frame(width: 200.0)
                        
                    }
                    
                    Text(String(tempus))
                        .font(.title2)
                        .foregroundColor(Color("style"))
                        .frame(width: 350)
                        .multilineTextAlignment(.center)
                    
                    
                    Text(String(verb))
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("style"))
                    
                    TextField("Digite sua dica!",
                              text: $tipp,
                              onCommit: {
                        showingAlert = true
                        ziel = trainAim(pessoa: person, numero: sing, caso: tempus, verbo: verbHilfe)
                        ergebnis = pruefen(eingabe: tipp, ziel: ziel)
                        correto = add(result: ergebnis, richtig: correto)
                        falso = substract(result: ergebnis, falsch: falso)
                        message = createAlertMessage(result: ergebnis, ziel: ziel)
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
                    .autocapitalization(.none)
                    .font(.title)
                    .focused($isTextFocused)
                    
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
                                    title: Text(message),
                                    dismissButton: .default(Text("Okay")) {
                                        person = setPerson()
                                        sing = setAnzahl()
                                        tempus = setTempus()
                                        verbHilfe = setVerb()
                                        verb = verbHilfe[0]
                                        tipp = ""
                                    }
                                )
                            }
                            .font(.title)
                            .foregroundColor(Color("style"))
                        
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    //Methods
    // get the person for conjugation
    func setPerson() -> (Int) {
        let trainPerson = personArray.randomElement()!
        return(trainPerson)
    }
    
    // get plural or singular for conjugation
    func setAnzahl() -> (String) {
        let trainAnzahl = anzahlArray.randomElement()!
        
        return(trainAnzahl)
    }
    
    // get tempus for conjugation
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
        if self.userSettings.isPMQPCompInd == false {
            if allTempus.contains("Pretérito Mais-que-Perfeito Composto Indicativo") {            allTempus.remove(at: allTempus.firstIndex(of: "Pretérito Mais-que-Perfeito Composto Indicativo")!)
            }
        }
        if self.userSettings.isPMQPCompInd == true {
            if !(allTempus.contains("Pretérito Mais-que-Perfeito Composto Indicativo")) {            allTempus.append("Pretérito Mais-que-Perfeito Composto Indicativo")
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
            if allTempus.contains("Presente Subjuntivo") {
                allTempus.remove(at: allTempus.firstIndex(of: "Presente Subjuntivo")!)
            }
        }
        if self.userSettings.isPresenteSub == true {
            if !(allTempus.contains("Presente Subjuntivo")) {
                allTempus.append("Presente Subjuntivo")
            }
        }
        if self.userSettings.isPerfeitoSub == false {
            if allTempus.contains("Perfeito Simples Subjuntivo") {
                allTempus.remove(at: allTempus.firstIndex(of: "Perfeito Simples Subjuntivo")!)
            }
        }
        if self.userSettings.isPerfeitoSub == true {
            if !(allTempus.contains("Perfeito Simples Subjuntivo")) {
                allTempus.append("Perfeito Simples Subjuntivo")
            }
        }
        if self.userSettings.isImperfeitoSub == false {
            if allTempus.contains("Imperfeito Subjuntivo") {
                allTempus.remove(at: allTempus.firstIndex(of: "Imperfeito Subjuntivo")!)
            }
        }
        if self.userSettings.isImperfeitoSub == true {
            if !(allTempus.contains("Imperfeito Subjuntivo")) {
                allTempus.append("Imperfeito Subjuntivo")
            }
        }
        if self.userSettings.isPMQPSub == false {
            if allTempus.contains("Pretérito Mais-que-Perfeito Subjuntivo") {
                allTempus.remove(at: allTempus.firstIndex(of: "Pretérito Mais-que-Perfeito Subjuntivo")!)
            }
        }
        if self.userSettings.isPMQPSub == true {
            if !(allTempus.contains("Pretérito Mais-que-Perfeito Subjuntivo")) {
                allTempus.append("Pretérito Mais-que-Perfeito Subjuntivo")
            }
        }
        if self.userSettings.isFuturoISub == false {
            if allTempus.contains("Futuro Simples Subjuntivo") {
                allTempus.remove(at: allTempus.firstIndex(of: "Futuro Simples Subjuntivo")!)
            }
        }
        if self.userSettings.isFuturoISub == true {
            if !(allTempus.contains("Futuro Simples Subjuntivo")) {
                allTempus.append("Futuro Simples Subjuntivo")
            }
        }
        if self.userSettings.isFuturoIISub == false {
            if allTempus.contains("Futuro Composto Subjuntivo") {
                allTempus.remove(at: allTempus.firstIndex(of: "Futuro Composto Subjuntivo")!)
            }
        }
        if self.userSettings.isFuturoIISub == true {
            if !(allTempus.contains("Futuro Composto Subjuntivo")) {
                allTempus.append("Futuro Composto Subjuntivo")
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
        
        // if more than 3 tenses, it will control that one tense does not get repeated too fast (check of last three)
        if allTempus.count > 3 {
            if lastcase == ["", "", ""] {
                trainTempus = allTempus.randomElement()!
                lastcase[0] = trainTempus
                countcase = countcase + 1
            } else {
                repeat {
                    trainTempus = allTempus.randomElement()!
                } while (lastcase.contains(trainTempus))
                
                countcase = countcase + 1
                
                if countcase > 3 {
                    countcase = 0
                    lastcase[0] = trainTempus
                } else if countcase == 3 {
                    lastcase[2] = trainTempus
                } else if countcase == 2 {
                    lastcase[1] = trainTempus
                } else if countcase == 1 {
                    lastcase[0] = trainTempus
                }
                
            }
        } else {
            trainTempus = allTempus.randomElement()!
        }
        return(trainTempus)
    }
    
    // function to set verb arry
    func setVerbArray(irregular: [[String]], regular: [[String]]) -> ([[String]]) {
        if userSettings.irregulares == true && userSettings.regulares == false {
            let testArray = irregular
            return(testArray)
        } else if userSettings.irregulares == false && userSettings.regulares == true {
            let testArray = regular
            return(testArray)
        } else {
            let testArray = irregular + regular
            return(testArray)
        }
    }
    
    // get verb for conjugation
    func setVerb() -> (Array<String>) {
    
        if userSettings.irregulares == false && userSettings.regulares == true {
                let rndNumber = Int.random(in: 0...verbArray.count - 1)
                let trainVerb = verbArray[rndNumber]
                return (trainVerb)
        } else if userSettings.irregulares == true && userSettings.regulares == false {
                let rndNumber = Int.random(in: 0...verbIrrArray.count - 1)
                let trainVerb = verbIrrArray[rndNumber]
            return (trainVerb)
        } else {
            let testArray = verbArray + verbIrrArray
            let rndNumber = Int.random(in: 0...testArray.count - 1)
            let trainVerb = testArray[rndNumber]
            return (trainVerb)
        }
        
            
      // below does not work
  //      let testArray = setVerbArray(irregular: verbIrrArray, regular: verbArray)
        
   //     if lastverb == [] {
   //         let rndNumber = Int.random(in: 0...testArray.count - 1)
//            trainVerb = testArray[rndNumber]
 //           lastverb[0] = trainVerb
 //           countarray = countarray + 1
 //           return(trainVerb)
 //       } else {
 //           repeat {
 //               trainVerb = testArray.randomElement()!
 //           } while (lastverb.contains(trainVerb))
            
  //          countcase = countcase + 1
            
  //          if countcase > 10 {
   //             countcase = 0
    //            lastverb[0] = trainVerb
   //         } else if countcase == 10 {
   //             lastverb[9] = trainVerb
   //         } else if countcase == 9 {
   //             lastverb[8] = trainVerb
   //         } else if countcase == 8 {
   //             lastverb[7] = trainVerb
  //          } else if countcase == 7 {
   //             lastverb[6] = trainVerb
   //         } else if countcase == 5 {
   //            lastverb[4] = trainVerb
   //         } else if countcase == 4 {
   //             lastverb[3] = trainVerb
   //         } else if countcase == 3 {
   //             lastverb[2] = trainVerb
   //         } else if countcase == 2 {
   //             lastverb[1] = trainVerb
   //        } else if countcase == 1 {
   //             lastverb[0] = trainVerb
   //         }
            
   //     }
        
   //     return(trainVerb)
    }
}

    // get solution for conjugation
func trainAim(pessoa: Int, numero: String, caso: String, verbo: Array<String>) -> String {
    var aim: String = ""
    var stamm: String = ""
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
    
    // Perfeito Subjuntivo
    let perfeitoSubHv = ["tenha", "tenha", "tenha", "tenhamos", "tenham", "tenham"]
    
    // Pretérito Mais-que-Perfeito Composto Subjuntivo
    let pmqpCompSubHv = ["tivesse", "tivesse", "tivesse", "tivéssemos", "tivessem", "tivessem"]
    
    // Futuro Composto Subjuntivo
    let futuroCompSubHv = ["tiver", "tiver", "tiver", "tivermos", "tiverem", "tiverem"]
    
    // Condicional II
    let condIIHv = ["teria", "teria", "teria", "teríamos", "teriam", "teriam"]
    
    //Presente Indicativo
    let presenteAr = ["o", "a", "a", "amos", "am", "am"]
    let presenteEr = ["o", "e", "e", "emos", "em", "em"]
    let presenteIr = ["o", "e", "e", "imos", "em", "em"]
    let presenteSer = ["sou", "é", "é", "somos", "são", "são"]
    let presenteEar = ["io", "ia", "ia", "amos", "iam", "iam"]
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
    let presenteConhecer = ["ço", "ce", "ce", "cemos", "cem", "cem"]
    
    // Perfeito INdicativo
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
    
    // Imperfeito Indicativo
    let imperfeitoAr = ["ava", "ava", "ava", "ávamos", "avam", "avam"]
    let imperfeitoEr = ["ia", "ia", "ia", "íamos", "iam", "iam"]
    let imperfeitoIr = ["ia", "ia", "ia", "íamos", "iam", "iam"]
    let imperfeitoSer = ["era", "era", "era", "éramos", "eram", "eram"]
    let imperfeitoVir = ["vinha", "vinha", "vinha", "vinhamos", "vinham", "vinham"]
    let imperfeitoTer = ["tinha", "tinha", "tinha", "tínhamos", "tinham", "tinham"]
    let imperfeitoPor = ["punha", "punha", "punha", "púnhamos", "punham", "punham"]
    
    // Mais-que-perfeito Indicativo
    let pmqpAr = ["a", "a", "a", "áramos", "am", "am"]
    let pmqpEr = ["a", "a", "a", "êramos", "am", "am"]
    let pmqpIr = ["a", "a", "a", "íramos", "am", "am"]
    let pmqpSer = ["foraa", "fora", "fora", "fôramos", "foram", "foram"]
    let pmqpEstar = ["estivera", "estivera", "estivera", "estivéramos", "estiveram", "estiveram"]
    let pmqpVir = ["viera", "viera", "viera", "viéramos", "vieram", "vieram"]
    let pmqpVer = ["vira", "vira", "vira", "víramos", "viram", "viram"]
    let pmqpTer = ["tivera", "tivera", "tivera", "tivéramos", "tiveram", "tiveram"]
    let pmqpFazer = ["fizera", "fizera", "fizera", "fizéramos", "fizeram", "fizeram"]
    let pmqpIzer = ["ssera", "ssera", "ssera", "sséramos", "sseram", "sseram"]
    let pmqpTrazer = ["trouxera", "trouxera", "trouxera", "trouxéramos", "trouxeram", "trouxeram"]
    let pmqpSaber = ["soubera", "soubera", "soubera", "soubéramos", "souberam", "souberam"]
    let pmqpPoder = ["pudera", "pudera", "pudera", "pudéramos", "puderam", "puderam"]
    let pmqpQuerer = ["quisera", "quisera", "quisera", "quiséramos", "quiseram", "quiseram"]
    let pmqpPor = ["pusera", "pusera", "pusera", "puséramos", "puseram", "puseram"]

    // Futuro Simples Indicativo
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
    
    // Subjuntivo
    // Presente Subjuntivo
    let presenteSubAr = ["e", "e", "e", "emos", "em", "em"]
    let presenteSubEr = ["a", "a", "a", "amos", "am", "am"]
    let presenteSubIr = ["a", "a", "a", "amos", "am", "am"]
    let presenteSubEar = ["ie", "ie" , "ie", "emos", "iem", "iem"]
    let presenteSubSer = ["seja", "seja", "seja", "sejamos", "sejam", "sejam"]
    let presenteSubEstar = ["esteja", "esteja", "esteja", "estejamos", "estejam", "estejam"]
    let presenteSubIra = ["vá", "vá", "vá", "vamos", "vão", "vão"]
    let presenteSubVir = ["venha", "venha", "venha", "venhamos", "venham", "venham"]
    let presenteSubVer = ["veja", "veja", "veja", "vejamos", "vejam", "vejam"]
    let presenteSubTer = ["tenha", "tenha", "tenha", "tenhamos", "tenham", "tenham"]
    let presenteSubLer = ["leia", "leia", "leia", "leiamos", "leiam", "leiam"]
    let presenteSubConhecer = ["ça", "ças", "ça", "çamos", "çais", "çam"]
    let presenteSubPagar = ["pague", "pague", "pague", "paguemos", "paguem", "paguem"]
    let presenteSubFazer = ["faça", "faças", "faça", "façamos", "façam", "façam"]
    let presenteSubIzer = ["ga", "ga", "ga", "gamos", "gam", "gam"]
    let presenteSubSaber = ["saiba", "saiba", "saiba", "saibamos", "saibam", "saibam"]
    let presenteSubPoder = ["possa", "possa", "possa", "possamos", "possam", "possam"]
    let presenteSubPerder = ["perca", "perca", "perca", "percamos", "percam", "percam"]
    let presenteSubQuerer = ["queira", "queira", "queira", "queiramos", "queiram", "queiram"]
    let presenteSubSignificar = ["signifique", "signifique", "signifique", "signifiquemos", "urmam", "signifiquem"]
    let presenteSubPor = ["ponha", "ponha", "ponha", "ponhamos", "ponham", "ponham"]
    let presenteSubOir = ["urma", "urma", "urma", "urmamos", "urmam", "urmam"]
    let presenteSubDesagradecer = ["desagradeça", "desagradeça", "desagradeça", "desagradeçamos", "desagradeçam", "desagradeçam"]
    
    // Pretérito Imperfeito Subjuntivo
    let imperfeitoSubAr = ["asse", "asse", "asse", "ássemos", "assem", "assem"]
    let imperfeitoSubEr = ["esse", "esse", "esse", "éssemos", "essem", "essem"]
    let imperfeitoSubIr = ["isse", "isse", "isse", "íssemos", "issem", "issem"]
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
    
    // Futuro Subjuntivo
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
    // Condicional I  Pretérito Simples
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
        if verbo[0] == "conhecer" || verbo[0] == "acontecer" {
            stamm = String(verbo[0].dropLast(3))
            aim = stamm + presenteConhecer[numberInArray]
        } else if verbo[1] == "ar" {
            aim = stamm + presenteAr[numberInArray]
        } else if verbo[1] == "ear" {
            aim = stamm + presenteEar[numberInArray]
        } else if verbo[1] == "er" {
            aim = stamm + presenteEr[numberInArray]
        } else if verbo[1] == "ir" {
            aim = stamm + presenteIr[numberInArray]
        } else if verbo[1] == "ira" {
            aim = presenteIra[numberInArray]
        } else if verbo[1] == "ser" {
            aim = presenteSer[numberInArray]
        } else if verbo[1] == "estar" {
            aim = presenteEstar[numberInArray]
        } else if verbo[1] == "vir" {
            aim = presenteVir[numberInArray]
        } else if verbo[1] == "ver" {
            aim = presenteVer[numberInArray]
        } else if verbo[1] == "ter" {
            aim = presenteTer[numberInArray]
        } else if verbo[1] == "ler" {
            aim = presenteLer[numberInArray]
        } else if verbo[1] == "fazer" {
            aim = presenteFazer[numberInArray]
        } else if verbo[1] == "trazer" {
            aim = presenteTrazer[numberInArray]
        } else if verbo[1] == "saber" {
            aim = presenteSaber[numberInArray]
        } else if verbo[1] == "poder" {
            aim = presentePoder[numberInArray]
        } else if verbo[1] == "perder" {
            aim = presentePerder[numberInArray]
        } else if verbo[1] == "querer" {
            aim = presenteQuerer[numberInArray]
        } else if verbo[1] == "por" {
            aim = presentePor[numberInArray]
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(3))
            aim = stamm + presenteIzer[numberInArray]
        } else if verbo[1] == "oir" {
            stamm = String(verbo[0].prefix(1))
            aim = stamm + presenteOir[numberInArray]
        }
        
        //stamm = String(verbo[0].dropLast(2))
    } else if caso == "Perfeito Simples Indicativo" {
        stamm = String(verbo[0].dropLast(2))
        if verbo[1] == "ar" || verbo[1] == "ear" {
            aim = stamm + perfeitoAr[numberInArray]
        } else if verbo[1] == "er" || verbo[1] == "ler" || verbo[1] == "perder" {
            aim = stamm + perfeitoEr[numberInArray]
        } else if verbo[1] == "ir" || verbo[1] == "ver" || verbo[1] == "oir" {
            aim = stamm + perfeitoIr[numberInArray]
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(3))
            aim = stamm + perfeitoIzer[numberInArray]
        } else if verbo[1] == "ser" || verbo[1] == "ira" {
            aim = perfeitoSer[numberInArray]
        } else if verbo[1] == "estar" {
            aim = perfeitoEstar[numberInArray]
        } else if verbo[1] == "vir" {
            aim = perfeitoVir[numberInArray]
        } else if verbo[1] == "ter" {
            aim = perfeitoTer[numberInArray]
        } else if verbo[1] == "fazer" {
            aim = perfeitoFazer[numberInArray]
        } else if verbo[1] == "trazer" {
            aim = perfeitoTrazer[numberInArray]
        } else if verbo[1] == "saber" {
            aim = perfeitoSaber[numberInArray]
        } else if verbo[1] == "poder" {
            aim = perfeitoPoder[numberInArray]
        } else if verbo[1] == "querer" {
            aim = perfeitoQuerer[numberInArray]
        } else if verbo[1] == "por" {
            aim = perfeitoPor[numberInArray]
        }
    } else if caso == "Imperfeito Indicativo" {
        stamm = String(verbo[0].dropLast(2))
        if verbo[1] == "ar" || verbo[1] == "estar" || verbo[1] == "ear" {
            aim = stamm + imperfeitoAr[numberInArray]
        } else if verbo[1] == "er" || verbo[1] == "ver" || verbo[1] == "ler" || verbo[1] == "fazer" || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "perder" || verbo[1] == "querer" {
            aim = stamm + imperfeitoEr[numberInArray]
        } else if verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "izer" || verbo[1] == "oir" {
            aim = stamm + imperfeitoIr[numberInArray]
        } else if verbo[1] == "ser" {
            aim = imperfeitoSer[numberInArray]
        } else if verbo[1] == "vir" {
            aim = imperfeitoVir[numberInArray]
        } else if verbo[1] == "ter" {
            aim = imperfeitoTer[numberInArray]
        } else if verbo[1] == "por" {
            aim = imperfeitoPor[numberInArray]
        }
    } else if caso == "Perfeito Composto Indicativo" {
        hilfsverb  = ppcHv[numberInArray]
        stamm = String(verbo[0].dropLast(2))
        if verbo[0] == "dizer" {
            aim = hilfsverb + " " + participioDizer
        } else if verbo[1] == "ar" || verbo[1] == "ear" || verbo[1] == "estar" {
            aim = hilfsverb + " " + stamm + participioAr
        } else if verbo[1] == "er" || verbo[1] == "ler" || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "perder" || verbo[1] == "querer" {
            aim = hilfsverb + " " + stamm + participioEr
        } else if verbo[0] == "abrir" {
            aim = hilfsverb + " " + participioAbrir
        } else if verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter" || verbo[1] == "oir" {
            aim = hilfsverb + " " + stamm + participioIr
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(4))
            aim = hilfsverb + " " + stamm + participioEr
        } else if verbo[1] == "ser" {
            aim = hilfsverb + " " + stamm + participioEr
        } else if verbo[1] == "vir" {
            aim = hilfsverb + " " + stamm + participioVir
        } else if verbo[1] == "ver" {
            aim = hilfsverb + " " + participioVer
        } else if verbo[1] == "fazer" {
            aim = hilfsverb + " " + participioFazer
        } else if verbo[1] == "por" {
            aim = hilfsverb + " " + participioPor
        }
    } else if caso == "Pretérito Mais-que-Perfeito Composto Indicativo" {
        hilfsverb  = pmqpHv[numberInArray]
        stamm = String(verbo[0].dropLast(2))
        if verbo[0] == "dizer" {
            aim = hilfsverb + " " + participioDizer
        } else if verbo[1] == "ar" || verbo[1] == "ear" || verbo[1] == "estar" {
            aim = hilfsverb + " " + stamm + participioAr
        } else if verbo[1] == "er" || verbo[1] == "ler" || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "perder" || verbo[1] == "querer" {
            aim = hilfsverb + " " + stamm + participioEr
        } else if verbo[0] == "abrir" {
            aim = hilfsverb + " " + participioAbrir
        } else if verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter" || verbo[1] == "oir" {
            aim = hilfsverb + " " + stamm + participioIr
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(4))
            aim = hilfsverb + " " + stamm + participioEr
        } else if verbo[1] == "ser" {
            aim = hilfsverb + " " + stamm + participioEr
        } else if verbo[1] == "vir" {
            aim = hilfsverb + " " + stamm + participioVir
        } else if verbo[1] == "ver" {
            aim = hilfsverb + " " + participioVer
        } else if verbo[1] == "fazer" {
            aim = hilfsverb + " " + participioFazer
        } else if verbo[1] == "por" {
            aim = hilfsverb + " " + participioPor
        }
    } else if caso == "Pretérito Mais-que-Perfeito Indicativo" {
        // Hier brauche ich die 3. Person Plural Perfeito
        // dann konjugation
        // mit hilfsverb eventuell arbeiten und dann die sonderstellungen machen.
        stamm = String(verbo[0])
        if verbo[1] == "ar" || verbo[1] == "ear" {
            if pessoa == 1 && numero == "Plural" {
                stamm = String(verbo[0].dropLast(2))
            }
            aim = stamm + pmqpAr[numberInArray]
        } else if verbo[1] == "er" || verbo[1] == "ler" || verbo[1] == "perder" {
            if pessoa == 1 && numero == "Plural" {
                stamm = String(verbo[0].dropLast(2))
            }
            aim = stamm + pmqpEr[numberInArray]
        } else if verbo[1] == "ir" || verbo[1] == "ver" || verbo[1] == "oir" {
            if pessoa == 1 && numero == "Plural" {
                stamm = String(verbo[0].dropLast(2))
            }
            aim = stamm + pmqpIr[numberInArray]
        } else if verbo[1] == "ser" || verbo[1] == "ira" {
            aim = pmqpSer[numberInArray]
        } else if verbo[1] == "estar" {
            aim = pmqpEstar[numberInArray]
        } else if verbo[1] == "vir" {
            aim = pmqpVir[numberInArray]
        } else if verbo[1] == "ver" {
            aim = pmqpVer[numberInArray]
        } else if verbo[1] == "ter" {
            aim = pmqpTer[numberInArray]
        } else if verbo[1] == "fazer" {
            aim = pmqpFazer[numberInArray]
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(3))
            aim = stamm + pmqpIzer[numberInArray]
        } else if verbo[1] == "trazer" {
            aim = pmqpTrazer[numberInArray]
        } else if verbo[1] == "saber" {
            aim = pmqpSaber[numberInArray]
        } else if verbo[1] == "poder" {
            aim = pmqpPoder[numberInArray]
        } else if verbo[1] == "querer" {
            aim = pmqpQuerer[numberInArray]
        } else if verbo[1] == "por" {
            aim = pmqpPor[numberInArray]
        }
    } else if caso == "Futuro Simples Indicativo" {
        stamm = String(verbo[0].dropLast(2))
        if verbo[1] == "ar" || verbo[1] == "ear" ||  verbo[1] == "estar" {
            aim = stamm + futuroSimplesAr[numberInArray]
        } else if verbo[1] == "er" || verbo[1] == "ver" || verbo[1] == "ter" || verbo[1] == "ler" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "perder" || verbo[1] == "querer" {
            aim = stamm + futuroSimplesEr[numberInArray]
        } else if verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "vir" || verbo[1] == "oir" {
            aim = stamm + futuroSimplesIr[numberInArray]
        } else if verbo[1] == "ser" {
            aim = futuroSimplesSer[numberInArray]
        } else if verbo[1] == "fazer" {
            aim = futuroSimplesFazer[numberInArray]
        } else if verbo[1] == "izer" || verbo[1] == "trazer" {
            stamm = String(verbo[0].dropLast(3))
            aim = stamm + futuroSimplesIzer[numberInArray]
        } else if verbo[1] == "por" {
            aim = futuroSimplesPor[numberInArray]
        }
    } else if caso == "Futuro Composto Indicativo" {
        hilfsverb  = futcomHv[numberInArray]
        stamm = String(verbo[0].dropLast(2))
        if verbo[0] == "dizer" {
            aim = hilfsverb + " " + participioDizer
        } else if verbo[1] == "ar" || verbo[1] == "ear" ||  verbo[1] == "estar" {
            aim = hilfsverb + " " + stamm + participioAr
        } else if verbo[1] == "er" || verbo[1] == "ler" || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "perder" || verbo[1] == "querer" {
            aim = hilfsverb + " " + stamm + participioEr
        } else if verbo[0] == "abrir" {
            aim = hilfsverb + " " + participioAbrir
        } else if verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter" || verbo[1] == "oir" {
            aim = hilfsverb + " " + stamm + participioIr
        } else if verbo[1] == "ser" {
            aim = hilfsverb + " " + stamm + participioEr
        } else if verbo[1] == "vir" {
            aim = hilfsverb + " " + stamm + participioVir
        } else if verbo[1] == "ver" {
            aim = hilfsverb + " " + participioVer
        } else if verbo[1] == "fazer" {
            aim = hilfsverb + " " + participioFazer
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(4))
            aim = hilfsverb + " " + stamm + participioEr
        } else if verbo[1] == "por" {
            aim = hilfsverb + " " + participioPor
        }
    } else if caso == "Presente Subjuntivo" {
        stamm = String(verbo[0].dropLast(2))
        if verbo[0] == "conhecer" || verbo[0]=="acontecer" {
            stamm = String(verbo[0].dropLast(3))
            aim = stamm + presenteSubConhecer[numberInArray]
        } else if verbo[0] == "desagradecer" {
            aim = presenteSubDesagradecer[numberInArray]
        } else if verbo[0] == "pagar" {
            aim = presenteSubPagar[numberInArray]
        } else if verbo[0] == "significar" {
            aim = presenteSubSignificar[numberInArray]
        } else if verbo[1] == "ar" {
            aim = stamm + presenteSubAr[numberInArray]
        }  else if verbo[1] == "ear" {
            aim = stamm + presenteSubEar[numberInArray]
        } else if verbo[1] == "er" {
            aim = stamm + presenteSubEr[numberInArray]
        } else if verbo[1] == "ir" {
            aim = stamm + presenteSubIr[numberInArray]
        } else if verbo[1] == "ser" {
            aim = presenteSubSer[numberInArray]
        } else if verbo[1] == "estar" {
            aim = presenteSubEstar[numberInArray]
        } else if verbo[1] == "ira" {
            aim = presenteSubIra[numberInArray]
        } else if verbo[1] == "vir" {
            aim = presenteSubVir[numberInArray]
        } else if verbo[1] == "ver" {
            aim = presenteSubVer[numberInArray]
        } else if verbo[1] == "ter" {
            aim = presenteSubTer[numberInArray]
        } else if verbo[1] == "ler" {
            aim = presenteSubLer[numberInArray]
        } else if verbo[1] == "fazer" {
            aim = presenteSubFazer[numberInArray]
        } else if verbo[1] == "izer" || verbo[1] == "trazer" {
            stamm = String(verbo[0].dropLast(3))
            aim = stamm + presenteSubIzer[numberInArray]
        } else if verbo[1] == "saber" {
            aim = presenteSubSaber[numberInArray]
        } else if verbo[1] == "poder" {
            aim = presenteSubPoder[numberInArray]
        } else if verbo[1] == "perder" {
            aim = presenteSubPerder[numberInArray]
        } else if verbo[1] == "querer" {
            aim = presenteSubQuerer[numberInArray]
        } else if verbo[1] == "por" {
            aim = presenteSubPor[numberInArray]
        } else if verbo[1] == "oir" {
            stamm = String(verbo[0].prefix(1))
            aim = stamm + presenteSubOir[numberInArray]
        }
    } else if caso == "Perfeito Simples Subjuntivo" {
        hilfsverb  = perfeitoSubHv[numberInArray]
        stamm = String(verbo[0].dropLast(2))
        if verbo[0] == "dizer" {
            aim = hilfsverb + " " + participioDizer
        } else if verbo[1] == "ar" || verbo[1] == "ear" || verbo[1] == "estar" {
            aim = hilfsverb + " " + stamm + participioAr
        } else if verbo[1] == "er" || verbo[1] == "ler" || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "perder" || verbo[1] == "querer" {
            aim = hilfsverb + " " + stamm + participioEr
        } else if verbo[0] == "abrir" {
            aim = hilfsverb + " " + participioAbrir
        } else if verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter" || verbo[1] == "oir" {
            aim = hilfsverb + " " + stamm + participioIr
        } else if verbo[1] == "ser" {
            aim = hilfsverb + " " + stamm + participioEr
        } else if verbo[1] == "vir" {
            aim = hilfsverb + " " + stamm + participioVir
        } else if verbo[1] == "ver" {
            aim = hilfsverb + " " + stamm + participioVer
        } else if verbo[1] == "fazer" {
            aim = hilfsverb + " " + participioFazer
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(4))
            aim = hilfsverb + " " + stamm + participioEr
        } else if verbo[1] == "por" {
            aim = hilfsverb + " " + participioPor
        }
    } else if caso == "Imperfeito Subjuntivo" {
        stamm = String(verbo[0].dropLast(2))
        if verbo[1] == "ar" || verbo[1] == "ear" {
            aim = stamm + imperfeitoSubAr[numberInArray]
        } else if verbo[1] == "er" || verbo[1] == "ler"  || verbo[1] == "perder" {
            aim = stamm + imperfeitoSubEr[numberInArray]
        } else if verbo[1] == "ir" || verbo[1] == "ver" || verbo[1] == "oir" {
            aim = stamm + imperfeitoSubIr[numberInArray]
        } else if verbo[1] == "ser" {
            aim = imperfeitoSubSer[numberInArray]
        } else if verbo[1] == "estar" {
            aim = imperfeitoSubEstar[numberInArray]
        } else if verbo[1] == "ira" {
            aim = imperfeitoSubIra[numberInArray]
        } else if verbo[1] == "vir" {
            aim = imperfeitoSubVir[numberInArray]
        } else if verbo[1] == "ter" {
            aim = imperfeitoSubTer[numberInArray]
        } else if verbo[1] == "fazer" {
            aim = imperfeitoSubFazer[numberInArray]
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(3))
            aim = stamm + imperfeitoSubIzer[numberInArray]
        } else if verbo[1] == "trazer" {
            aim = imperfeitoSubTrazer[numberInArray]
        } else if verbo[1] == "saber" {
            aim = imperfeitoSubSaber[numberInArray]
        } else if verbo[1] == "poder" {
            aim = imperfeitoSubPoder[numberInArray]
        } else if verbo[1] == "querer" {
            aim = imperfeitoSubQuerer[numberInArray]
        } else if verbo[1] == "por" {
            aim = imperfeitoSubPor[numberInArray]
        }
    } else if caso == "Pretérito Mais-que-Perfeito Subjuntivo"{
        hilfsverb  = pmqpCompSubHv[numberInArray]
        stamm = String(verbo[0].dropLast(2))
        if verbo[0] == "dizer" {
            aim = hilfsverb + " " + participioDizer
        } else if verbo[1] == "ar" || verbo[1] == "ear" || verbo[1] == "estar" {
            aim = hilfsverb + " " + stamm + participioAr
        } else if verbo[1] == "er" || verbo[1] == "ler" || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "perder" || verbo[1] == "querer" {
            aim = hilfsverb + " " + stamm + participioEr
        } else if verbo[0] == "abrir" {
            aim = hilfsverb + " " + participioAbrir
        } else if verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter" || verbo[1] == "oir" {
            aim = hilfsverb + " " + stamm + participioIr
        } else if verbo[1] == "ser" {
            aim = hilfsverb + " " + stamm + participioEr
        } else if verbo[1] == "vir" {
            aim = hilfsverb + " " + stamm + participioVir
        } else if verbo[1] == "ver" {
            aim = hilfsverb + " " + participioVer
        } else if verbo[1] == "fazer" {
            aim = hilfsverb + " " + participioFazer
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(4))
            aim = hilfsverb + " " + stamm + participioEr
        } else if verbo[1] == "por" {
            aim = hilfsverb + " " + participioPor
        }
    } else if caso == "Futuro Simples Subjuntivo" {
        stamm = String(verbo[0].dropLast(2))
        if verbo[1] == "ar" || verbo[1] == "ear" {
            aim = stamm + futuroSubAr[numberInArray]
        } else if verbo[1] == "er" || verbo[1] == "ler"  || verbo[1] == "perder" {
            aim = stamm + futuroSubEr[numberInArray]
        } else if verbo[1] == "ir" || verbo[1] == "ver" || verbo[1] == "oir" {
            aim = stamm + futuroSubIr[numberInArray]
        } else if verbo[1] == "ser" {
            aim = futuroSubSer[numberInArray]
        } else if verbo[1] == "estar" {
            aim = futuroSubEstar[numberInArray]
        } else if verbo[1] == "ira" {
            aim = futuroSubIra[numberInArray]
        }  else if verbo[1] == "vir" {
            aim = futuroSubVir[numberInArray]
        } else if verbo[1] == "ter" {
            aim = futuroSubTer[numberInArray]
        } else if verbo[1] == "fazer" {
            aim = futuroSubFazer[numberInArray]
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(3))
            aim = stamm + futuroSubIzer[numberInArray]
        } else if verbo[1] == "trazer" {
            aim = futuroSubTrazer[numberInArray]
        } else if verbo[1] == "saber" {
            aim = futuroSubSaber[numberInArray]
        } else if verbo[1] == "poder" {
            aim = futuroSubPoder[numberInArray]
        } else if verbo[1] == "querer" {
            aim = futuroSubQuerer[numberInArray]
        } else if verbo[1] == "por" {
            aim = futuroSubPor[numberInArray]
        }
    } else if caso == "Futuro Composto Subjuntivo" {
        hilfsverb  = futuroCompSubHv[numberInArray]
        stamm = String(verbo[0].dropLast(2))
        if verbo[0] == "dizer" {
            aim = hilfsverb + " " + participioDizer
        } else if verbo[1] == "ar" || verbo[1] == "ear" || verbo[1] == "estar" {
            aim = hilfsverb + " " + stamm + participioAr
        } else if verbo[1] == "er" || verbo[1] == "ler" || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "perder" || verbo[1] == "querer" {
            aim = hilfsverb + " " + stamm + participioEr
        } else if verbo[0] == "abrir" {
            aim = hilfsverb + " " + participioAbrir
        } else if verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter" || verbo[1] == "oir" {
            aim = hilfsverb + " " + stamm + participioIr
        } else if verbo[1] == "ser" {
            aim = hilfsverb + " " + stamm + participioEr
        } else if verbo[1] == "vir" {
            aim = hilfsverb + " " + stamm + participioVir
        } else if verbo[1] == "ver" {
            aim = hilfsverb + " " + participioVer
        } else if verbo[1] == "fazer" {
            aim = hilfsverb + " " + participioFazer
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(4))
            aim = hilfsverb + " " + stamm + participioEr
        } else if verbo[1] == "por" {
            aim = hilfsverb + " " + participioPor
        }
    } else if caso == "Futuro do Préterito (Condicional I)"{
        stamm = String(verbo[0].dropLast(2))
        if verbo[1] == "ar" || verbo[1] == "ear" || verbo[1] == "estar" {
            aim = stamm + condicionalIAr[numberInArray]
        } else if verbo[1] == "er" || verbo[1] == "ver"  || verbo[1] == "ter" || verbo[1] == "ler" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "perder" || verbo[1] == "querer" {
            aim = stamm + condicionalIEr[numberInArray]
        } else if verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "oir" {
            aim = stamm + condicionalIIr[numberInArray]
        } else if verbo[1] == "ser" {
            aim = condicionalIEr[numberInArray]
        } else if verbo[1] == "vir" {
            aim = condicionalIVir[numberInArray]
        } else if verbo[1] == "fazer" {
            aim = condicionalIFazer[numberInArray]
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(3))
            aim = stamm + condicionalIIzer[numberInArray]
        } else if verbo[1] == "por" {
            aim = condicionalIPor[numberInArray]
        }
    } else if caso == "Futuro do Préterito Composto (Condicional II)"{
        hilfsverb  = condIIHv[numberInArray]
        stamm = String(verbo[0].dropLast(2))
        if verbo[0] == "dizer" {
            aim = hilfsverb + " " + participioDizer
        } else if verbo[1] == "ar" || verbo[1] == "ear" || verbo[1] == "estar" {
            aim = hilfsverb + " " + stamm + participioAr
        } else if verbo[1] == "er" || verbo[1] == "ler" || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "perder" || verbo[1] == "querer" {
            aim = hilfsverb + " " + stamm + participioEr
        } else if verbo[0] == "abrir" {
            aim = hilfsverb + " " + participioAbrir
        } else if verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter" || verbo[1] == "oir" {
            aim = hilfsverb + " " + stamm + participioIr
        } else if verbo[1] == "ser" {
            aim = hilfsverb + " " + stamm + participioEr
        } else if verbo[1] == "vir" {
            aim = hilfsverb + " " + stamm + participioVir
        } else if verbo[1] == "ver" {
            aim = hilfsverb + " " + participioVer
        } else if verbo[1] == "fazer" {
            aim = hilfsverb + " " + participioFazer
        } else if verbo[1] == "izer" {
            stamm = String(verbo[0].dropLast(4))
            aim = hilfsverb + " " + stamm + participioEr
        } else if verbo[1] == "por" {
            aim = hilfsverb + " " + participioPor
        }
    }

    stamm = "";
    hilfsverb = "";
    numberInArray = 0;
    
    return(aim)
}

// check user result against solution
func pruefen(eingabe: String, ziel: String) -> Bool {
    let ergebnis: Bool
    if eingabe == ziel {
        ergebnis = true
    } else {
        ergebnis = false
    }

    return(ergebnis)
}

// set counter for correct results
func add(result: Bool, richtig: Int) -> Int {
    let summe: Int
    if result == true {
        summe = richtig + 1
    } else {
        summe = richtig
    }
    
    return(summe)
}

// set counter for wrong results
func substract(result: Bool, falsch: Int) -> Int {
    let summe: Int
    if result == false {
        summe = falsch + 1
    } else {
        summe = falsch
    }
    
    return(summe)
}

// create alert message for results (correct or wrong)
func createAlertMessage(result: Bool, ziel: String) -> String {
    var alertMessage: String = ""
    if result == true {
        alertMessage = "✅ Arrasou! A sua dica foi correta. 🚀"
    } else {
        alertMessage = "🙅🏽‍♂️ Esta vez não! ❌ \n" + "\n A forma correta é: " + ziel
    }
    return(alertMessage)
}

// provide structure
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserSettings())  // assign environment
    }
}
