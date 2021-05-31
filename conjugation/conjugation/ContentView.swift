//
//  ContentView.swift
//  ConjugationPortuguese
//
//  Created by Philipp Kleer on 30.05.21.
//

import SwiftUI

struct ContentView: View {
    // Variable declaration
    @State private var person = ""
    @State private var sing = ""
    @State private var sub = ""
    @State private var tempus = ""
    @State private var verb = ""
    
    var body: some View {
        
        ZStack{
            Image("background")
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Spacer()
            
                Text("Bem-vindo ao treinador de conjugação!")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.all, 2.0)
                    .cornerRadius(5)
                
                Spacer()
                
                VStack() {
                    HStack() {
                        Spacer()
                        Text("Pessoa:")
                            .font(.title2)
                            .foregroundColor(.white)
                        Text(String(person))
                            .font(.title2)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                    
                    HStack() {
                        Text("Singular/Plural:")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                            .font(.title2)
                        Text((sing))
                            .font(.title2)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    }
                    
                    HStack() {
                        Text("Caso:")
                            .foregroundColor(.white)
                            .font(.title2)
                        Text(String(sub))
                            .font(.title2)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    }
                    
                    HStack() {
                        Text("Tempus:")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                            .font(.title2)
                        Text(String(tempus))
                            .font(.title2)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    }
            
                    HStack() {
                        Text("Verb:")
                            .foregroundColor(.white)
                            .font(.title2)
                        Text(String(verb))
                            .font(.title2)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    }
                
                }
                
                Spacer()

               // Input box fehlt hier
                
                Spacer()
                
                Button(action: {
                    // within here Structure aufrufen von neue Runde und dann neu ausgeben lassen (siehe Playground)
                    
                }, label:{
                    Image(systemName: "play.fill")
                        .scaleEffect(4.0)
                        .foregroundColor(.white)
                        
                })
                

            
            Spacer()
            
            Spacer()
        }
        }
        

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
