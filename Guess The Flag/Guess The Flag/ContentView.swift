//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Alex Diaz on 11/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = " "
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var scoreValue = 0
    @State private var endGame = true
    @State private var questionsAsked = 0
    @State private var finalScore = 0
    
    
    var body: some View {
        
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(scoreValue)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                }
                .padding()
                }
        
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            if scoreTitle == "Correct"{
                Text("Your score is \(scoreValue)")
            }
        }
        
        .alert("Final Score", isPresented: $endGame) {
            Button("Restart Game", action: askQuestion)
        } message: {
            Text("\(finalScore)")
        }
    }
    
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreValue += 1
            finalScore += 1
        } else {
            scoreTitle = "Wrong, Thats the flag of \(countries[number])!"
        }
            showingScore = true
        }
    
    
    func askQuestion() {
        if questionsAsked == 8 {
            print ("\(finalScore)")
            reset()
        } else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            questionsAsked += 1
        }
    }
    
    
    func reset() {
        endGame = true
        questionsAsked = 0
        scoreValue = 0
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

