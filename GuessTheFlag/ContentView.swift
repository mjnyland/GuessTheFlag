//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Michael Nyland on 10/13/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var userScore = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctCountry = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    
    var body: some View {
        
        ZStack {//A Z Stack to be contain all and be a background
            
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {//A stack to contain the two below
                
                VStack { //Text Content
                    Text("Select the flag for")
                        .foregroundStyle(.white)
                        .font(.subheadline.weight(.semibold))
                    
                    Text(countries[correctCountry])
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                
                VStack (spacing: 16){ //A stack for the flags
                    
                    ForEach(0..<3) { number in
                        Button {
                            checkAnswer(number)
                        } label: {
                            Image(countries[number])
                                .shadow(radius: 5)
                        }
                        
                    }
                }
            }
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(userScore)")
        }
    }
    
    func checkAnswer(_ answer: Int) {
        if (correctCountry == answer) {
            scoreTitle = "You're correct!"
            userScore += 1
            
        } else {
            scoreTitle = "You're incorrect! That's the flag of \(countries[answer])"
            userScore -= 1
        }
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctCountry = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
