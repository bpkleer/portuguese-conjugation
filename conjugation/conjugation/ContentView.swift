import SwiftUI

@available(iOS 16.0, *)

struct ContentView: View {
    // variables for body view
    // for global variables: english
    // function names: english
    // for functions-variables (input): portuguese
    // variables used within functions only: german
    @State var person: Int = 0
    @State var numerus: String = ""
    @State var tense = ""
    @State var allTense: Array<String> = ["Presente Indicativo"]
    @State var verb = ""
    @State var verbHelper: Array<String> = [""]
    @State var hint: String = ""
    @State var aim: String = ""
    @State private var showingAlert = false
    @State var result: Bool = false
    @State var message: String = " "
    @State var proveHidden: Bool = true
    
    // variables to count wrong and false answers
    @State var correct: Int = 0
    @State var wrong: Int = 0
    
    // to check that same tense will not repeated in the last three times (with more than 4 tenses chosen)
    @State var lastCase: Array<String> = ["", "", ""]
    @State var countCase: Int = 0
    @State var trainTense: String = ""
    
    // variables for check on verbs (not yet implemented)
    @State var lastVerb: [[String]] = []
    @State var trainVerb: [String] = []
    @State var countArray: Int = 0
    
    // environment
    @EnvironmentObject var userSettings: UserSettings
    @FocusState private var isTextFocused: Bool
    // Person variable
    // second person excluded, because not important in português do Brasil (default, can be changed by toggle)
    @State private var personArray: Array<Int> = [1, 3]
    
    // Singular or Plural Variable
    let numerusArray = ["Singular", "Plural"]
    
    // verbs
    let verbArray = [
        // ar verbs (15 verbs)
        ["acordar", "ar"],
        ["comprar", "ar"],
        ["cuidar", "ar"],
        ["detestar", "ar"],
        ["deitar", "ar"],
        ["falar", "ar"],
        ["gostar", "ar"],
        ["levar", "ar"],
        ["limpar", "ar"],
        ["melhorar", "ar"],
        ["pagar", "ar"],
        ["pensar", "ar"],
        ["procurar", "ar"],
        ["significar", "ar"],
        ["tornar", "ar"],
        // er verbs (15 verbs)
        ["aprender", "er"],
        ["acontecer", "er"],
        ["bater", "er"],
        ["beber", "er"],
        ["comer", "er"],
        ["conhecer", "er"],
        ["correr", "er"],
        ["encher", "er"],
        ["entender", "er"],
        ["escolher", "er"],
        ["escrever", "er"],
        ["ler", "er"],
        ["receber", "er"],
        ["responder", "er"],
        ["vender", "er"],
        // ir verbs (15 verbs)
        ["abrir", "ir"],
        ["assistir", "ir"],
        ["decidir", "ir"],
        ["desistir", "ir"],
        ["discutir", "ir"],
        ["dividir", "ir"],
        ["dormir", "ir"], 
        ["existir", "ir"],
        ["insistir", "ir"],
        ["mentir", "ir"],
        ["partir", "ir"],
        ["permitir", "ir"],
        ["proibir", "ir"],
        ["sentir", "ir"],
        ["servir", "ir"]
    ]
    
    let verbIrrArray = [
        ["estar", "estar"],
        ["ir", "ira"],
        ["fazer", "fazer"],
        ["perder", "er"],
        ["poder", "poder"],
        ["pôr", "por"],
        ["querer", "querer"],
        ["saber", "saber"],
        ["ser", "ser"],
        ["trazer", "trazer"],
        ["ter", "ter"],
        ["ver", "ver"],
        ["vir", "vir"],
        // only some differences form er
        ["dizer", "er"],
        // ear (only some differences from ar)
        ["passear", "ar"],
        ["sortear", "ar"],
        // air (only some differences from ir)
        ["cair", "ir"],
        ["sair", "ir"]
        
    ]
    
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
                
                if proveHidden == true {
                    Button(action: {
                        person = setPerson()
                        numerus = setNumerus()
                        tense = setTense()
                        verbHelper = setVerb()
                        verb = verbHelper[0]
                        proveHidden = false
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
                    Text("Correto: " + String(correct) + " / Falso: " + String(wrong))
                        .foregroundColor(Color("style"))
                        .padding(.top, 20)
                    
                    Button(action: {
                        correct = 0
                        wrong = 0
                    }){ HStack(spacing: 0) {
                        Text("Reiniciar o números").foregroundColor(Color("style"))
                        Image(systemName: "arrow.2.squarepath")
                            .scaleEffect(1.0)
                            .rotationEffect(.degrees(180))
                            .foregroundColor(Color("style"))
                    }}.padding(.all, 0.0)
                    
                    HStack() {
                        Text(String(person) + ". " + numerus)
                            .multilineTextAlignment(.trailing)
                            .lineLimit(1)
                            .padding(0.0)
                            .font(.title)
                            .foregroundColor(Color("style"))
                            .frame(width: 200.0)
                        
                    }
                    
                    Text(String(tense))
                        .font(.title2)
                        .foregroundColor(Color("style"))
                        .frame(width: 350)
                        .multilineTextAlignment(.center)
                    
                    
                    Text(String(verb))
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("style"))
                    
                    TextField("Digite sua dica!",
                              text: $hint,
                              onCommit: {
                        showingAlert = true
                        aim = trainAim(pessoa: person, numero: numerus, caso: tense, verbo: verbHelper)
                        result = proof(entrada: hint, alvo: aim)
                        correct = add(resultado: result, correto: correct)
                        wrong = substract(resultado: result, falso: wrong)
                        message = createAlertMessage(resultado: result, alvo: aim)
                        proveHidden = false
                        if showingAlert == false {
                            person = setPerson()
                            numerus = setNumerus()
                            tense = setTense()
                            verbHelper = setVerb()
                            verb = verbHelper[0]
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
                            aim = trainAim(pessoa: person, numero: numerus, caso: tense, verbo: verbHelper)
                            result = proof(entrada: hint, alvo: aim)
                            message = createAlertMessage(resultado: result, alvo: aim)
                            hint = ""
                            proveHidden = false
                            if showingAlert == false {
                                person = setPerson()
                                numerus = setNumerus()
                                tense = setTense()
                                verbHelper = setVerb()
                                verb = verbHelper[0]
                            }
                            isTextFocused = false
                        } .disabled(hint == "")
                            .alert(isPresented:$showingAlert) {
                                if (result == false) {
                                    Alert(
                                        title: Text(message),
                                        primaryButton:.default(Text("Que pena! ☹️")) {
                                            person = setPerson()
                                            numerus = setNumerus()
                                            tense = setTense()
                                            verbHelper = setVerb()
                                            verb = verbHelper[0]
                                            hint = ""
                                        },
                                        secondaryButton:
                                            .destructive(Text("Erro de digitação! 🤦🏽‍♂️")) {
                                                    correct = correct + 1
                                                    if (wrong > 0 ) {
                                                        wrong = wrong - 1
                                                    }
                                                    person = setPerson()
                                                    numerus = setNumerus()
                                                    tense = setTense()
                                                    verbHelper = setVerb()
                                                    verb = verbHelper[0]
                                                    hint = ""
                                                }
                                    )
                                } else {
                                    Alert(
                                        title: Text(message),
                                        dismissButton: .cancel(Text("Joia! 👍🏾")) {
                                            person = setPerson()
                                            numerus = setNumerus()
                                            tense = setTense()
                                            verbHelper = setVerb()
                                            verb = verbHelper[0]
                                            hint = ""
                                        }
                                    )
                                }
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
        if (self.userSettings.isTu == true) {
            personArray = [1, 2, 3]
        } else {
            personArray = [1, 3]
        }
        let hilfePerson = personArray.randomElement()!
        return(hilfePerson)
    }
    
    // get plural or singular for conjugation
    func setNumerus() -> (String) {
        let hilfeAnzahl = numerusArray.randomElement()!
        
        return(hilfeAnzahl)
    }
    
    // get tempus for conjugation
    func setTense() -> (String) {
        if (self.userSettings.isPresenteInd == false) {
            if (allTense.contains("Presente Indicativo")) {
                allTense.remove(at: allTense.firstIndex(of: "Presente Indicativo")!)
            }
        }
        if (self.userSettings.isPresenteInd == true) {
            if !(allTense.contains("Presente Indicativo")) {
                allTense.append("Presente Indicativo")
            }
        }
        if (self.userSettings.isPerfeitoInd == false) {
            if (allTense.contains("Pretérito Perfeito Simples Indivativo")) {
                allTense.remove(at: allTense.firstIndex(of: "Pretérito Perfeito Simples Indivativo")!)
            }
        }
        if (self.userSettings.isPerfeitoInd == true) {
            if !(allTense.contains("Pretérito Perfeito Simples Indivativo")) {
                allTense.append("Pretérito Perfeito Simples Indivativo")
            }
        }
        if (self.userSettings.isImperfeitoInd == false) {
            if (allTense.contains("Pretérito Imperfeito Indicativo")) {
                allTense.remove(at: allTense.firstIndex(of: "Pretérito Imperfeito Indicativo")!)
            }
        }
        if (self.userSettings.isImperfeitoInd == true) {
            if !(allTense.contains("Pretérito Imperfeito Indicativo")) {
                allTense.append("Pretérito Imperfeito Indicativo")
            }
        }
        if (self.userSettings.isPerfeitoCompInd == false) {
            if (allTense.contains("Pretérito Perfeito Composto Indicativo")) {
                allTense.remove(at: allTense.firstIndex(of: "Pretérito Perfeito Composto Indicativo")!)
            }
        }
        if (self.userSettings.isPerfeitoCompInd == true) {
            if !(allTense.contains("Pretérito Perfeito Composto Indicativo")) {
                allTense.append("Pretérito Perfeito Composto Indicativo")
            }
        }
        if (self.userSettings.isPMQPCompInd == false) {
            if (allTense.contains("Pretérito Mais-que-Perfeito Composto Indicativo")) {
                allTense.remove(at: allTense.firstIndex(of: "Pretérito Mais-que-Perfeito Composto Indicativo")!)
            }
        }
        if (self.userSettings.isPMQPCompInd == true) {
            if !(allTense.contains("Pretérito Mais-que-Perfeito Composto Indicativo")) {
                allTense.append("Pretérito Mais-que-Perfeito Composto Indicativo")
            }
        }
        if (self.userSettings.isPMQPInd == false) {
            if (allTense.contains("Pretérito Mais-que-Perfeito Indicativo")) {
                allTense.remove(at: allTense.firstIndex(of: "Pretérito Mais-que-Perfeito Indicativo")!)
            }
        }
        if (self.userSettings.isPMQPInd == true) {
            if !(allTense.contains("Pretérito Mais-que-Perfeito Indicativo")) {
                allTense.append("Pretérito Mais-que-Perfeito Indicativo")
            }
        }
        if (self.userSettings.isFuturoIInd == false) {
            if (allTense.contains("Futuro Simples Indicativo")) {
                allTense.remove(at: allTense.firstIndex(of: "Futuro Simples Indicativo")!)
            }
        }
        if (self.userSettings.isFuturoIInd == true) {
            if !(allTense.contains("Futuro Simples Indicativo")) {
                allTense.append("Futuro Simples Indicativo")
            }
        }
        if (self.userSettings.isFuturoIIInd == false) {
            if (allTense.contains("Futuro Composto Indicativo")) {
                allTense.remove(at: allTense.firstIndex(of: "Futuro Composto Indicativo")!)
            }
        }
        if (userSettings.isFuturoIIInd == true) {
            if !(allTense.contains("Futuro Composto Indicativo")) {
                allTense.append("Futuro Composto Indicativo")
            }
        }
        if (self.userSettings.isPresenteSub == false) {
            if (allTense.contains("Presente Subjuntivo")) {
                allTense.remove(at: allTense.firstIndex(of: "Presente Subjuntivo")!)
            }
        }
        if (self.userSettings.isPresenteSub == true) {
            if !(allTense.contains("Presente Subjuntivo")) {
                allTense.append("Presente Subjuntivo")
            }
        }
        if (self.userSettings.isPerfeitoSub == false) {
            if (allTense.contains("Pretérito Perfeito Simples Subjuntivo")) {
                allTense.remove(at: allTense.firstIndex(of: "Pretérito Perfeito Simples Subjuntivo")!)
            }
        }
        if (self.userSettings.isPerfeitoSub == true) {
            if !(allTense.contains("Pretérito Perfeito Simples Subjuntivo")) {
                allTense.append("Pretérito Perfeito Simples Subjuntivo")
            }
        }
        if (self.userSettings.isImperfeitoSub == false) {
            if (allTense.contains("Pretérito Imperfeito Subjuntivo")) {
                allTense.remove(at: allTense.firstIndex(of: "Pretérito Imperfeito Subjuntivo")!)
            }
        }
        if (self.userSettings.isImperfeitoSub == true) {
            if !(allTense.contains("Pretérito Imperfeito Subjuntivo")) {
                allTense.append("Pretérito Imperfeito Subjuntivo")
            }
        }
        if (self.userSettings.isPMQPSub == false) {
            if (allTense.contains("Pretérito Mais-que-Perfeito Subjuntivo")) {
                allTense.remove(at: allTense.firstIndex(of: "Pretérito Mais-que-Perfeito Subjuntivo")!)
            }
        }
        if (self.userSettings.isPMQPSub == true) {
            if !(allTense.contains("Pretérito Mais-que-Perfeito Subjuntivo")) {
                allTense.append("Pretérito Mais-que-Perfeito Subjuntivo")
            }
        }
        if (self.userSettings.isFuturoISub == false) {
            if (allTense.contains("Futuro Simples Subjuntivo")) {
                allTense.remove(at: allTense.firstIndex(of: "Futuro Simples Subjuntivo")!)
            }
        }
        if (self.userSettings.isFuturoISub == true) {
            if !(allTense.contains("Futuro Simples Subjuntivo")) {
                allTense.append("Futuro Simples Subjuntivo")
            }
        }
        if (self.userSettings.isFuturoIISub == false) {
            if (allTense.contains("Futuro Composto Subjuntivo")) {
                allTense.remove(at: allTense.firstIndex(of: "Futuro Composto Subjuntivo")!)
            }
        }
        if (self.userSettings.isFuturoIISub == true) {
            if !(allTense.contains("Futuro Composto Subjuntivo")) {
                allTense.append("Futuro Composto Subjuntivo")
            }
        }
        if (self.userSettings.isCondicionalI == false) {
            if (allTense.contains("Futuro do Préterito (Condicional I)")) {
                allTense.remove(at: allTense.firstIndex(of: "Futuro do Préterito (Condicional I)")!)
            }
        }
        if (self.userSettings.isCondicionalI == true) {
            if !(allTense.contains("Futuro do Préterito (Condicional I)")) {
                allTense.append("Futuro do Préterito (Condicional I)")
            }
        }
        if (self.userSettings.isCondicionalII == false) {
            if (allTense.contains("Futuro do Préterito Composto (Condicional II)")) {
                allTense.remove(at: allTense.firstIndex(of: "Futuro do Préterito Composto (Condicional II)")!)
            }
        }
        if (self.userSettings.isCondicionalII == true) {
            if !(allTense.contains("Futuro do Préterito Composto (Condicional II)")) {
                allTense.append("Futuro do Préterito Composto (Condicional II)")
            }
        }
        
        // if more than 3 tenses, it will control that one tense does not get repeated too fast (check of last three)
        if (allTense.count > 3) {
            if (lastCase == ["", "", ""]) {
                trainTense = allTense.randomElement()!
                lastCase[0] = trainTense
                countCase = countCase + 1
            } else {
                repeat {
                    trainTense = allTense.randomElement()!
                } while (lastCase.contains(trainTense))
                
                countCase = countCase + 1
                
                if (countCase > 3) {
                    countCase = 0
                    lastCase[0] = trainTense
                } else if (countCase == 3) {
                    lastCase[2] = trainTense
                } else if (countCase == 2) {
                    lastCase[1] = trainTense
                } else if (countCase == 1) {
                    lastCase[0] = trainTense
                }
                
            }
        } else {
            trainTense = allTense.randomElement()!
        }
        return(trainTense)
    }
    
    // function to set verb array
    func setVerbArray(irregular: [[String]], regular: [[String]]) -> ([[String]]) {
        if (userSettings.irregulares == true && userSettings.regulares == false) {
            let verbHilfeArray = irregular
            return(verbHilfeArray)
        } else if (userSettings.irregulares == false && userSettings.regulares == true) {
            let verbHilfeArray = regular
            return(verbHilfeArray)
        } else {
            let verbHilfeArray = irregular + regular
            return(verbHilfeArray)
        }
    }
    
    // get verb for conjugation
    func setVerb() -> (Array<String>) {
        if (userSettings.irregulares == false && userSettings.regulares == true) {
                let zufallsZahl = Int.random(in: 0...verbArray.count - 1)
                let hilfeVerb = verbArray[zufallsZahl]
                return (hilfeVerb)
        } else if (userSettings.irregulares == true && userSettings.regulares == false) {
                let zufallsZahl = Int.random(in: 0...verbIrrArray.count - 1)
                let hilfeVerb = verbIrrArray[zufallsZahl]
            return (hilfeVerb)
        } else {
            let hilfeArray = verbArray + verbIrrArray
            let zufallsZahl = Int.random(in: 0...hilfeArray.count - 1)
            let hilfeVerb = hilfeArray[zufallsZahl]
            return (hilfeVerb)
        }
    }
}

    // get solution for conjugation
func trainAim(pessoa: Int, numero: String, caso: String, verbo: Array<String>) -> String {
    var ziel: String = ""
    var stamm: String = ""
    var hilfsverb: String = ""
    var hilfsverbPerfeito: String = ""
    var nummerInArray: Int = 0
    
    // verschiedene Zeiten
    // Indikativ Tempus
    // Hilfsverben
    // Perfeito Composto
    let ppcHv = ["tenho", "tens", "tem", "temos", "tendes", "têm"]
    // Pretértio Mais-que-Perfeito Composto
    let pmqpHv = ["tinha", "tinhas", "tinha", "tínhamos", "tínheis", "tinham"]
    // Futuro COmposto
    let futcomHv = ["terei", "teras", "terá", "teremos", "tereis", "terão"]
    // Perfeito Subjuntivo
    let perfeitoSubHv = ["tenha", "tenhas", "tenha", "tenhamos", "tenhais", "tenham"]
    // Pretérito Mais-que-Perfeito Composto Subjuntivo
    let pmqpCompSubHv = ["tivesse", "tivesses", "tivesse", "tivéssemos", "tívesseis", "tivessem"]
    // Futuro Composto Subjuntivo
    let futuroCompSubHv = ["tiver", "tiveres", "tiver", "tivermos", "tiverdes", "tiverem"]
    // Condicional II
    let condIIHv = ["teria", "terias", "teria", "teríamos", "teríeis", "teriam"]
    
    // Declaration of Conjugation per Tense (portuguese names below)
    // Presente Indicativo
    let presenteAr = ["o", "as", "a", "amos", "ais", "am"]
    let presenteEr = ["o", "es", "e", "emos", "eis", "em"]
    let presenteIr = ["o", "es", "e", "imos", "is", "em"]
    // partly irregular
    let presenteEar = ["io", "ias", "ia", "amos", "ais", "iam"]
    // only first person (er)
    let presenteFazer = ["faço", "---", "---", "---", "---", "---"]
    let presenteDizer = ["digo", "---", "---", "---", "---", "---"]
    // only thirs person (er)
    let presenteQuerer = ["---", "---", "quer", "---", "---", "---"]
    // dormir, only first person (ir)
    let presenteDormir = ["durmo", "---", "---", "---", "---", "---"]
    let presenteEntir = ["into", "---", "---", "---", "---", "---"]
    let presenteErvir = ["irvo", "---", "---", "---", "---", "---"]
    let presenteAir = ["aio", "ais", "ai", "aímos", "aís", "aem"]
    // only first person (er)
    let presenteCer = ["ço", "---", "---", "---", "---", "---"]
    let presenteSaber = ["sei", "---", "---", "---", "---", "---"]
    let presentePoder = ["posso", "---", "---", "---", "---", "---"]
    let presentePerder = ["perco", "---", "---", "---", "---", "---"]
    // completely irregular
    let presenteSer = ["sou", "és", "é", "somos", "sois", "são"]
    let presenteEstar = ["estou", "estás", "está", "estamos", "estais", "estão"]
    let presenteIra = ["vou", "vais", "vai", "vamos", "ides", "vão"]
    let presenteVir = ["venho", "vens", "vem", "vimos", "vindes", "vêm"]
    let presenteVer = ["vejo", "vês", "vê", "vemos", "vedes", "vêem"]
    let presenteTer = ["tenho", "tens", "tem", "temos", "tendes", "têm"]
    let presenteLer = ["leio", "lês", "lê", "lemos", "ledes", "leem"]
    let presenteTrazer = ["trago", "trazes", "traz", "trazemos", "trazeis", "trazem"]
    let presentePor = ["ponho", "pões", "põe", "pomos", "pondes", "põem"]
    
    // Pretérito Perfeito Indicativo
    let perfeitoAr = ["ei", "aste", "ou", "amos", "astes", "aram"]
    let perfeitoEr = ["i", "este", "eu", "emos", "estes", "eram"]
    let perfeitoIr = ["i", "iste", "iu", "imos", "istes", "iram"]
    let perfeitoAir = ["aí", "aíste", "aiu", "ímos", "ístes", "íram"]
    let perfeitoSer = ["fui", "foste", "foi", "fomos", "fostes", "foram"]
    let perfeitoEstar = ["estive", "estiveste", "esteve", "estivemos", "estivestes", "estiveram"]
    let perfeitoVir = ["vim", "vieste", "veio", "viemos", "viestes", "vieram"]
    let perfeitoTer = ["tive", "tiveste", "teve", "tivemos", "tivestes", "tiveram"]
    let perfeitoFazer = ["fiz", "fizeste", "fez", "fizemos", "fizestes", "fizeram"]
    let perfeitoDizer = ["sse", "sseste", "sse", "ssemos", "ssestes", "sseram"]
    let perfeitoTrazer = ["trouxe", "trouxeste", "trouxe", "trouxemos", "trouxestes", "trouxeram"]
    let perfeitoSaber = ["soube", "soubeste", "soube", "soubemos", "soubestes", "souberam"]
    let perfeitoPoder = ["pude", "pudeste", "pôde", "pudemos", "pudestes", "puderam"]
    let perfeitoQuerer = ["quis", "quiseste", "quis", "quisemos", "quisestes", "quiseram"]
    let perfeitoPor = ["pus", "puseste", "pôs", "pusemos", "pusestes", "puseram"]
    
    // Pretérito Pretérito Imperfeito Indicativo
    let imperfeitoAr = ["ava", "avas", "ava", "ávamos", "aveis", "avam"]
    let imperfeitoEr = ["ia", "ias", "ia", "íamos", "íeis", "iam"]
    let imperfeitoIr = ["ia", "ias", "ia", "íamos", "íeis", "iam"]
    let imperfeitoAir = ["ía", "ías", "ía", "íamos", "íeis", "íam"]

    let imperfeitoSer = ["era", "eras", "era", "éramos", "éreis", "eram"]
    let imperfeitoVir = ["vinha", "vinhas", "vinha", "vínhamos", "vínheis", "vinham"]
    let imperfeitoTer = ["tinha", "tinhas", "tinha", "tínhamos", "tínheis", "tinham"]
    let imperfeitoPor = ["punha", "punhas", "punha", "púnhamos", "púnheis", "punham"]
    
    // Pretérito Mais-que-perfeito Indicativo
    let pmqp = ["a", "as", "a", "---", "---", "am"]
    let pmqpAr = ["---", "---", "---", "áramos", "áreis", "---"]
    let pmqpEr = ["---", "---", "---", "êramos", "êreis", "---"]
    let pmqpIr = ["---", "---", "---", "íramos", "íreis", "---"]
    // irregulares ending on -er like vir, fazer, ter, estiver, trazer, saber, poder, querer, pôr, dizer
    let pmqpEr2 = ["---", "---", "---", "iéramos", "iéreis", ""]
    let pmqpSer = ["---", "---", "---", "ôramos", "ôreis", "---"]
    
    // Futuro Simples Indicativo
    // regulares
    let futuroSimples = ["ei", "ás", "á", "emos", "eis", "ão"]
    // irregulares: fazer, dizer, trazer, por
    let futuroSimplesFazer = ["rei", "rás", "rá", "remos", "reis", "rão"]
    let futuroSimplesPor = ["porei", "porás", "porá", "poremos", "poreis", "porão"]
    
    // Subjuntivo
    // Presente Subjuntivo
    let presenteSubAr = ["e", "es", "e", "emos", "eis", "em"]
    // er & ir, sentir, vir, ver, ter, dizer, poder, perder, por, -oir
    let presenteSubErIr = ["a", "as", "a", "amos", "ais", "am"]
    let presenteSubEar = ["ie", "ies" , "ie", "emos", "eis", "iem"]
    // ser e estar
    let presenteSubIs = ["eja", "ejas", "eja", "ejamos", "ejaisa", "ejam"]
    // special cases
    let presenteSubIra = ["vá", "vás", "vá", "vamos", "vades", "vão"]
    
    // Pretérito Pretérito Imperfeito Subjuntivo
    let imperfeitoSub = ["sse", "sses", "sse", "---", "---", "ssem"]
    let imperfeitoSubAr = ["---", "---", "---", "ássemos", "ásseis", "---"]
    let imperfeitoSubEr = ["---", "---", "---", "êssemos", "êsseis", "---"]
    // irregulares ending on -er like vir, fazer, ter, estiver, trazer, saber, poder, querer, pôr, dizer
    let imperfeitoSubEr2 = ["---", "---", "---", "éssemos", "ésseis", "---"]
    let imperfeitoSubIr = ["---", "---", "---", "íssemos", "ísseis", "---"]
    let imperfeitoSubSer = ["---", "---", "---", "ôssemos", "ôsseis", "---"]

    // Futuro Subjuntivo
    let futuroSub = ["", "es", "", "mos", "des", "em"]
    let futuroSubAir = ["ir", "íres", "ir", "irmos", "irdes", "írem"]
    
    // Condicional
    // Condicional I  Pretérito Simples
    let condicionalI = ["ia", "ias", "ia", "íamos", "íeis", "iam"]
    let condicionalIIrr = ["ria", "rias", "ria", "ríamos", "ríeis", "riam"]
    let condicionalIPor = ["poria", "poria", "poria", "poríamos", "poríeis", "poriam"]
    
    // Participio
    let participioAr = "ado"
    let participioEr = "ido"
    let participioIr = "ido"
    let participioAir = "ído"
    let participioVir = "indo"
    let participioVer = "visto"
    let participioFazer = "feito"
    let participioDizer = "dito"
    let participioPor = "posto"
    let participioAbrir = "aberto"
    
    // correct numberInArray for Array-enumeration (beginning with 0)
    if numero == "Singular" {
        nummerInArray = pessoa - 1
    } else {
        nummerInArray = pessoa + 2
    }
    
    // Test cases across Tenses
    if caso == "Presente Indicativo" {
        stamm = String(verbo[0].dropLast(2))
        if (verbo[1] == "ar") {
            ziel = stamm + presenteAr[nummerInArray]
        } else if (String(verbo[0].suffix(3)) == "ear") {
            ziel = stamm + presenteEar[nummerInArray]
        } else if (verbo[1] == "er") {
            if (nummerInArray == 1 && (verbo[0] == "conhecer" || verbo[0] == "acontecer")) {
                stamm = String(verbo[0].dropLast(3))
                ziel = stamm + presenteCer[nummerInArray]
            } else if (nummerInArray == 1 && verbo[0] == "saber") {
                ziel = presenteSaber[nummerInArray]
            } else if (nummerInArray == 1 && verbo[0] == "poder") {
                ziel = presentePoder[nummerInArray]
            } else if (nummerInArray == 1 && verbo[0] == "perder") {
                ziel = presentePerder[nummerInArray]
            } else if (nummerInArray == 3 && verbo[0] == "querer") {
                ziel = presenteQuerer[nummerInArray]
            } else if (nummerInArray == 3 && verbo[0] == "fazer") {
                ziel = presenteFazer[nummerInArray]
            } else if (nummerInArray == 3 && verbo[0] == "dizer") {
                ziel = presenteDizer[nummerInArray]
            } else if (verbo[0] == "ler") {
                ziel = presenteLer[nummerInArray]
            } else {
                ziel = stamm + presenteEr[nummerInArray]
            }
        } else if (verbo[1] == "ir") {
            if (String(verbo[0].suffix(3)) == "air") {
                stamm = String(verbo[0].dropLast(3))
                ziel = stamm + presenteAir[nummerInArray]
            }
            else if (nummerInArray == 1 && verbo[0] == "dormir") {
               ziel = presenteDormir[nummerInArray]
            } else if (nummerInArray == 1 && (verbo[0] == "mentir" || verbo[0] == "sentir")) {
                stamm = String(verbo[0].dropLast(5))
                ziel = stamm + presenteEntir[nummerInArray]
            } else if (nummerInArray == 1 && verbo[0] == "servir") {
                stamm = String(verbo[0].dropLast(5))
                ziel = stamm + presenteErvir[nummerInArray]
            } else {
                ziel = stamm + presenteIr[nummerInArray]
            }
        } else if (verbo[1] == "ira") {
            ziel = presenteIra[nummerInArray]
        } else if (verbo[1] == "ser") {
            ziel = presenteSer[nummerInArray]
        } else if (verbo[1] == "estar") {
            ziel = presenteEstar[nummerInArray]
        } else if (verbo[1] == "vir") {
            ziel = presenteVir[nummerInArray]
        } else if (verbo[1] == "ver") {
            ziel = presenteVer[nummerInArray]
        } else if (verbo[1] == "ter") {
            ziel = presenteTer[nummerInArray]
        } else if (verbo[1] == "trazer") {
            ziel = presenteTrazer[nummerInArray]
        } else if (verbo[1] == "por") {
            ziel = presentePor[nummerInArray]
        }
    } else if caso == "Pretérito Perfeito Simples Indivativo" {
        stamm = String(verbo[0].dropLast(2))
        if (verbo[1] == "ar") {
            ziel = stamm + perfeitoAr[nummerInArray]
        } else if (verbo[1] == "er" ) {
            if (verbo[0] == "dizer") {
                stamm = String(verbo[0].dropLast(3))
                ziel = stamm + perfeitoDizer[nummerInArray]
            } else {
                ziel = stamm + perfeitoEr[nummerInArray]
            }
        } else if (verbo[1] == "ir" || verbo[1] == "ver") {
            if (String(verbo[0].suffix(3)) == "air") {
                stamm = String(verbo[0].dropLast(3))
                ziel = stamm + perfeitoAir[nummerInArray]
            } else {
                ziel = stamm + perfeitoIr[nummerInArray]
            }
        } else if (verbo[1] == "ser" || verbo[1] == "ira") {
            ziel = perfeitoSer[nummerInArray]
        } else if (verbo[1] == "estar") {
            ziel = perfeitoEstar[nummerInArray]
        } else if (verbo[1] == "vir") {
            ziel = perfeitoVir[nummerInArray]
        } else if (verbo[1] == "ter") {
            ziel = perfeitoTer[nummerInArray]
        } else if (verbo[1] == "fazer") {
            ziel = perfeitoFazer[nummerInArray]
        } else if (verbo[1] == "trazer") {
            ziel = perfeitoTrazer[nummerInArray]
        } else if (verbo[1] == "saber") {
            ziel = perfeitoSaber[nummerInArray]
        } else if (verbo[1] == "poder") {
            ziel = perfeitoPoder[nummerInArray]
        } else if (verbo[1] == "querer") {
            ziel = perfeitoQuerer[nummerInArray]
        } else if verbo[1] == "por" {
            ziel = perfeitoPor[nummerInArray]
        }
    } else if caso == "Pretérito Imperfeito Indicativo" {
        stamm = String(verbo[0].dropLast(2))
        if (verbo[1] == "ar" || verbo[1] == "estar") {
            ziel = stamm + imperfeitoAr[nummerInArray]
        } else if (verbo[1] == "er" || verbo[1] == "ver"  || verbo[1] == "fazer" || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "querer") {
            ziel = stamm + imperfeitoEr[nummerInArray]
        } else if (verbo[1] == "ir" || verbo[1] == "ira") {
            if (String(verbo[0].suffix(3)) == "air") {
                stamm = String(verbo[0].dropLast(3))
                ziel = stamm + imperfeitoAir[nummerInArray]
            } else {
                ziel = stamm + imperfeitoIr[nummerInArray]
            }
        } else if (verbo[1] == "ser") {
            ziel = imperfeitoSer[nummerInArray]
        } else if (verbo[1] == "vir") {
            ziel = imperfeitoVir[nummerInArray]
        } else if (verbo[1] == "ter") {
            ziel = imperfeitoTer[nummerInArray]
        } else if (verbo[1] == "por") {
            ziel = imperfeitoPor[nummerInArray]
        }
    } else if caso == "Pretérito Perfeito Composto Indicativo" {
        hilfsverb  = ppcHv[nummerInArray]
        stamm = String(verbo[0].dropLast(2))
        if (verbo[1] == "ar" || verbo[1] == "estar") {
            ziel = hilfsverb + " " + stamm + participioAr
        } else if (verbo[1] == "er"  || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "querer") {
            if (verbo[0] == "dizer") {
                ziel = hilfsverb + " " + participioDizer
            } else {
                ziel = hilfsverb + " " + stamm + participioEr
            }
        } else if (verbo[0] == "abrir") {
            ziel = hilfsverb + " " + participioAbrir
        } else if (verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter") {
            if (String(verbo[0].suffix(3)) == "air") {
                stamm = String(verbo[0].dropLast(3))
                ziel = hilfsverb + " " + stamm + participioAir
            } else {
                ziel = hilfsverb + " " + stamm + participioIr
            }
        } else if (verbo[1] == "ser") {
            ziel = hilfsverb + " " + stamm + participioEr
        } else if (verbo[1] == "vir") {
            ziel = hilfsverb + " " + stamm + participioVir
        } else if (verbo[1] == "ver") {
            ziel = hilfsverb + " " + participioVer
        } else if (verbo[1] == "fazer") {
            ziel = hilfsverb + " " + participioFazer
        } else if (verbo[1] == "por") {
            ziel = hilfsverb + " " + participioPor
        }
    } else if caso == "Pretérito Mais-que-Perfeito Composto Indicativo" {
        hilfsverb  = pmqpHv[nummerInArray]
        stamm = String(verbo[0].dropLast(2))
        if (verbo[1] == "ar" || verbo[1] == "estar") {
            ziel = hilfsverb + " " + stamm + participioAr
        } else if (verbo[1] == "er"  || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder" || verbo[1] == "querer") {
            if (verbo[0] == "dizer") {
                ziel = hilfsverb + " " + participioDizer
            } else {
                ziel = hilfsverb + " " + stamm + participioEr
            }
        } else if (verbo[0] == "abrir") {
            ziel = hilfsverb + " " + participioAbrir
        } else if (verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter") {
            if (String(verbo[0].suffix(3)) == "air") {
                stamm = String(verbo[0].dropLast(3))
                ziel = hilfsverb + " " + stamm + participioAir
            } else {
                ziel = hilfsverb + " " + stamm + participioIr
            }
        } else if (verbo[1] == "ser") {
            ziel = hilfsverb + " " + stamm + participioEr
        } else if (verbo[1] == "vir") {
            ziel = hilfsverb + " " + stamm + participioVir
        } else if (verbo[1] == "ver") {
            ziel = hilfsverb + " " + participioVer
        } else if (verbo[1] == "fazer") {
            ziel = hilfsverb + " " + participioFazer
        } else if (verbo[1] == "por") {
            ziel = hilfsverb + " " + participioPor
        }
    } else if caso == "Pretérito Mais-que-Perfeito Indicativo" {
        if (nummerInArray == 3 || nummerInArray == 4) {
            hilfsverbPerfeito = buildPerfeitoHelper(entrada: verbo, cair: 4)
            if (
                verbo[1] == "estar" || verbo[1] == "vir" || verbo[1] == "ter" || verbo[1] == "fazer"
                || verbo[0] == "dizer" || verbo[1] == "trazer" || verbo[1] == "saber"
                || verbo[1] == "poder" || verbo[1] == "querer" || verbo[1] == "por"
            ) {
                // case éssemos
                ziel = hilfsverbPerfeito + pmqpEr2[nummerInArray]
            } else if (verbo[1] == "ar") {
                // case ássemos
                ziel = hilfsverbPerfeito + pmqpAr[nummerInArray]
            } else if (verbo[1] == "er" ) {
                // case êssemos
                ziel = hilfsverbPerfeito + pmqpEr[nummerInArray]
                
            } else if (verbo[1] == "ir" || verbo[1] == "ver") {
                // case íssemos
                ziel = hilfsverbPerfeito + pmqpIr[nummerInArray]
            } else if (verbo[1] == "ser" || verbo[1] == "ira") {
                // case óssemos
                ziel = hilfsverbPerfeito + pmqpSer[nummerInArray]
            }
        } else {
            hilfsverbPerfeito = buildPerfeitoHelper(entrada: verbo, cair: 2)
            ziel = hilfsverbPerfeito + pmqp[nummerInArray]
        }
    } else if caso == "Futuro Simples Indicativo" {
        if (verbo[1] == "fazer" || verbo[1] == "trazer" || verbo[0] == "dizer") {
            stamm = String(verbo[0].dropLast(3))
            ziel = stamm + futuroSimplesFazer[nummerInArray]
        } else if (verbo[1] == "por") {
            ziel = futuroSimplesPor[nummerInArray]
        } else {
            stamm = String(verbo[0])
            ziel = stamm + futuroSimples[nummerInArray
            ]
        }
    } else if caso == "Futuro Composto Indicativo" {
        hilfsverb  = futcomHv[nummerInArray]
        stamm = String(verbo[0].dropLast(2))
        if (verbo[0] == "dizer") {
            ziel = hilfsverb + " " + participioDizer
        } else if (verbo[1] == "ar" ||  verbo[1] == "estar") {
            ziel = hilfsverb + " " + stamm + participioAr
        } else if (verbo[1] == "er"  || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder" || verbo[1] == "querer") {
            ziel = hilfsverb + " " + stamm + participioEr
        } else if (verbo[0] == "abrir") {
            ziel = hilfsverb + " " + participioAbrir
        } else if (verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter") {
            if (String(verbo[0].suffix(3)) == "air") {
                stamm = String(verbo[0].dropLast(3))
                ziel = hilfsverb + " " + stamm + participioAir
            } else {
                ziel = hilfsverb + " " + stamm + participioIr
            }
        } else if (verbo[1] == "ser") {
            ziel = hilfsverb + " " + stamm + participioEr
        } else if (verbo[1] == "vir") {
            ziel = hilfsverb + " " + stamm + participioVir
        } else if (verbo[1] == "ver") {
            ziel = hilfsverb + " " + participioVer
        } else if (verbo[1] == "fazer") {
            ziel = hilfsverb + " " + participioFazer
        } else if (verbo[1] == "por") {
            ziel = hilfsverb + " " + participioPor
        }
    } else if caso == "Presente Subjuntivo" {
        stamm = buildPresenteHelper(entrada: verbo, cair: 1)
        if (verbo[1] == "ar") {
            if (verbo[0] == "pagar") {
                stamm = buildPresenteHelper(entrada: verbo, cair: 1) + "u"
                ziel = stamm + presenteSubAr[nummerInArray]
            } else if (verbo[0] == "significar") {
                stamm = buildPresenteHelper(entrada: verbo, cair: 2) + "qu"
                ziel = stamm + presenteSubAr[nummerInArray]
            } else {
                ziel = stamm + presenteSubAr[nummerInArray]
            }
        } else if (
            verbo[1] == "er" || verbo[1] == "ir" || verbo[0] == "dizer" || verbo[1] == "por"
            || verbo[1] == "vir" || verbo[1] == "ver" || verbo[1] == "ter" || verbo[1] == "poder" 
            || verbo[1] == "saber" || verbo[1] == "querer" || verbo[1] == "fazer"
        ) {
            if (verbo[1] == "saber") {
                stamm = buildPresenteHelper(entrada: verbo, cair: 2) + "aib"
                ziel = stamm + presenteSubErIr[nummerInArray]
            } else if (verbo[1] == "querer") {
                stamm = buildPresenteHelper(entrada: verbo, cair: 2) + "ir"
                ziel = stamm + presenteSubErIr[nummerInArray]
            } else {
                ziel = stamm + presenteSubErIr[nummerInArray]
            }
        } else if (String(verbo[0].suffix(3)) == "ear") {
            ziel = stamm + presenteSubEar[nummerInArray]
        } else if (verbo[1] == "ser" || verbo[1] == "estar") {
            stamm = buildPresenteHelper(entrada: verbo, cair: 2)
            ziel = stamm + presenteSubIs[nummerInArray]
        } else if (verbo[1] == "ira") {
            ziel = presenteSubIra[nummerInArray]
        }
    } else if caso == "Pretérito Perfeito Simples Subjuntivo" {
        hilfsverb  = perfeitoSubHv[nummerInArray]
        stamm = String(verbo[0].dropLast(2))
        if (verbo[0] == "dizer") {
            ziel = hilfsverb + " " + participioDizer
        } else if (verbo[1] == "ar" || verbo[1] == "estar") {
            ziel = hilfsverb + " " + stamm + participioAr
        } else if (verbo[1] == "er"  || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder" || verbo[1] == "querer") {
            ziel = hilfsverb + " " + stamm + participioEr
        } else if (verbo[0] == "abrir") {
            ziel = hilfsverb + " " + participioAbrir
        } else if (verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter") {
            ziel = hilfsverb + " " + stamm + participioIr
        } else if (verbo[1] == "ser") {
            ziel = hilfsverb + " " + stamm + participioEr
        } else if (verbo[1] == "vir") {
            ziel = hilfsverb + " " + stamm + participioVir
        } else if (verbo[1] == "ver") {
            ziel = hilfsverb + " " + stamm + participioVer
        } else if (verbo[1] == "fazer") {
            ziel = hilfsverb + " " + participioFazer
        } else if (verbo[1] == "por") {
            ziel = hilfsverb + " " + participioPor
        }
    } else if caso == "Pretérito Imperfeito Subjuntivo" {
        if (nummerInArray == 3 || nummerInArray == 4) {
            hilfsverbPerfeito = buildPerfeitoHelper(entrada: verbo, cair: 4)
            if (verbo[1] == "ar") {
                // case ássemos
                ziel = hilfsverbPerfeito + imperfeitoSubAr[nummerInArray]
            } else if (verbo[1] == "er" ) {
                // case êssemos
                ziel = hilfsverbPerfeito + imperfeitoSubEr[nummerInArray]
                
            } else if (verbo[1] == "ir" || verbo[1] == "ver") {
                // case íssemos
                ziel = hilfsverbPerfeito + imperfeitoSubIr[nummerInArray]
            } else if (verbo[1] == "ser" || verbo[1] == "ira") {
                // case óssemos
                ziel = hilfsverbPerfeito + imperfeitoSubSer[nummerInArray]
            }  else if (
                verbo[1] == "estar" || verbo[1] == "vir" || verbo[1] == "ter" || verbo[1] == "fazer"
                || verbo[0] == "dizer" || verbo[1] == "trazer" || verbo[1] == "saber"
                || verbo[1] == "poder" || verbo[1] == "querer" || verbo[1] == "por"
            ) {
                // case éssemos
                ziel = hilfsverbPerfeito + imperfeitoSubEr2[nummerInArray]
            }
        } else {
            hilfsverbPerfeito = buildPerfeitoHelper(entrada: verbo, cair: 3)
            ziel = hilfsverbPerfeito + imperfeitoSub[nummerInArray]
        }
    } else if caso == "Pretérito Mais-que-Perfeito Subjuntivo"{
        hilfsverb  = pmqpCompSubHv[nummerInArray]
        stamm = String(verbo[0].dropLast(2))
        if verbo[0] == "dizer" {
            ziel = hilfsverb + " " + participioDizer
        } else if (verbo[1] == "ar" || verbo[1] == "estar") {
            ziel = hilfsverb + " " + stamm + participioAr
        } else if (verbo[1] == "er"  || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  
                   || verbo[1] == "querer" || verbo[1] == "ser") {
            ziel = hilfsverb + " " + stamm + participioEr
        } else if (verbo[0] == "abrir") {
            ziel = hilfsverb + " " + participioAbrir
        } else if (verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter") {
            if (String(verbo[0].suffix(3)) == "air") {
                stamm = String(verbo[0].dropLast(3))
                ziel = hilfsverb + " " + stamm + participioAir
            } else {
                ziel = hilfsverb + " " + stamm + participioIr
            }
        } else if (verbo[1] == "vir") {
            ziel = hilfsverb + " " + stamm + participioVir
        } else if (verbo[1] == "ver") {
            ziel = hilfsverb + " " + participioVer
        } else if (verbo[1] == "fazer") {
            ziel = hilfsverb + " " + participioFazer
        } else if (verbo[1] == "por") {
            ziel = hilfsverb + " " + participioPor
        }
    } else if caso == "Futuro Simples Subjuntivo" {
        if (String(verbo[0].suffix(3)) == "air") {
            hilfsverbPerfeito = buildPerfeitoHelper(entrada: verbo, cair: 4)
            ziel = hilfsverbPerfeito + futuroSubAir[nummerInArray]
        } else {
            hilfsverbPerfeito = buildPerfeitoHelper(entrada: verbo, cair: 2)
            ziel = hilfsverbPerfeito + futuroSub[nummerInArray]
        }
    } else if caso == "Futuro Composto Subjuntivo" {
        hilfsverb  = futuroCompSubHv[nummerInArray]
        stamm = String(verbo[0].dropLast(2))
        if (verbo[0] == "dizer") {
            ziel = hilfsverb + " " + participioDizer
        } else if (verbo[1] == "ar" || verbo[1] == "estar") {
            ziel = hilfsverb + " " + stamm + participioAr
        } else if (
            verbo[1] == "er"  || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  
            || verbo[1] == "querer" || verbo[1] == "ser"
        ) {
            ziel = hilfsverb + " " + stamm + participioEr
        } else if (verbo[0] == "abrir") {
            ziel = hilfsverb + " " + participioAbrir
        } else if (verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter") {
            if (String(verbo[0].suffix(3)) == "air") {
                stamm = String(verbo[0].dropLast(3))
                ziel = hilfsverb + " " + stamm + participioAir
            } else {
                ziel = hilfsverb + " " + stamm + participioIr
            }
        } else if (verbo[1] == "vir") {
            ziel = hilfsverb + " " + stamm + participioVir
        } else if (verbo[1] == "ver") {
            ziel = hilfsverb + " " + participioVer
        } else if (verbo[1] == "fazer") {
            ziel = hilfsverb + " " + participioFazer
        } else if verbo[1] == "por" {
            ziel = hilfsverb + " " + participioPor
        }
    } else if caso == "Futuro do Préterito (Condicional I)" {
        if (verbo[0] == "dizer" || verbo[0] == "trazer" || verbo[0] == "fazer") {
            stamm = String(verbo[0].dropLast(3))
            ziel = stamm + condicionalIIrr[nummerInArray]
        } else if (verbo[1] == "por") {
            ziel = condicionalIPor[nummerInArray]
        } else {
            stamm = String(verbo[0])
            ziel = stamm + condicionalI[nummerInArray]
        }
    } else if caso == "Futuro do Préterito Composto (Condicional II)"{
        hilfsverb  = condIIHv[nummerInArray]
        stamm = String(verbo[0].dropLast(2))
        if (verbo[0] == "dizer") {
            ziel = hilfsverb + " " + participioDizer
        } else if (verbo[1] == "ar" || verbo[1] == "estar") {
            ziel = hilfsverb + " " + stamm + participioAr
        } else if (verbo[1] == "er"  || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "querer") {
            ziel = hilfsverb + " " + stamm + participioEr
        } else if (verbo[0] == "abrir") {
            ziel = hilfsverb + " " + participioAbrir
        } else if (verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter") {
            if (String(verbo[0].suffix(3)) == "air") {
                stamm = String(verbo[0].dropLast(3))
                ziel = hilfsverb + " " + stamm + participioAir
            } else {
                ziel = hilfsverb + " " + stamm + participioIr
            }
        } else if (verbo[1] == "ser") {
            ziel = hilfsverb + " " + stamm + participioEr
        } else if (verbo[1] == "vir") {
            ziel = hilfsverb + " " + stamm + participioVir
        } else if (verbo[1] == "ver") {
            ziel = hilfsverb + " " + participioVer
        } else if (verbo[1] == "fazer") {
            ziel = hilfsverb + " " + participioFazer
        } else if (verbo[1] == "por") {
            ziel = hilfsverb + " " + participioPor
        }
    }

    stamm = "";
    hilfsverb = "";
    nummerInArray = 0;
    
    return(ziel)
}

// function for check hint against correct answer
func proof(entrada: String, alvo: String) -> Bool {
    let ergebnis: Bool
    if entrada == alvo {
        ergebnis = true
    } else {
        ergebnis = false
    }

    return(ergebnis)
}

// set counter for correct results
func add(resultado: Bool, correto: Int) -> Int {
    let summe: Int
    if resultado == true {
        summe = correto + 1
    } else {
        summe = correto
    }
    
    return(summe)
}

// set counter for wrong results
func substract(resultado: Bool, falso: Int) -> Int {
    let summe: Int
    if resultado == false {
        summe = falso + 1
    } else {
        summe = falso
    }
    
    return(summe)
}

// helper function to build cases for different tenses
func buildPerfeitoHelper(entrada: Array<String>, cair: Int) -> String {
    var helfer: String = ""
    helfer = trainAim(pessoa: 3, numero: "Plural", caso: "Pretérito Perfeito Simples Indivativo", verbo: entrada)
    helfer = String(helfer.dropLast(cair))
    return(helfer)
}

// helper function to build cases for presente subjuntivo
func buildPresenteHelper(entrada: Array<String>, cair: Int) -> String {
    var helfer: String = ""
    helfer = trainAim(pessoa: 1, numero: "Singular", caso: "Presente Indicativo", verbo: entrada)
    helfer = String(helfer.dropLast(cair))
    return(helfer)
}

// create alert message for results (correct or wrong)
func createAlertMessage(resultado: Bool, alvo: String) -> String {
    var alarmNachricht: String = ""
    if resultado == true {
        alarmNachricht = "✅ Arrasou! A sua dica foi correta. 🚀"
    } else {
        alarmNachricht = "🙅🏽‍♂️ Esta vez não! ❌ \n" + "\n A forma correta é: " + alvo
    }
    return(alarmNachricht)
}

// provide structure
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserSettings())  // assign environment
    }
}
