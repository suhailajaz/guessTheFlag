//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by suhail on 27/04/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var limit = false

    @State private var scoreTitle = ""
    @State private var catchTap = 0
    @State private var count = 0
    @State private var correct = 0
    @State private var wrong = 0
   // @State private var wrong = 0
    @State private var check=""
    


    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Monaco","Nigeria","Poland","Russia","Spain","UK","US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var questionsRemaining = 8
    
    var body: some View {
        
        ZStack{
            RadialGradient(stops: [
                .init(color: .green, location: 0.3),
                .init(color: .mint, location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Spacer()
                
                VStack(spacing:20){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            //.foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                        }label:{
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                            
                            
                        }
                        
                    }
                    
                    
                    
                }.frame(maxWidth: .infinity )
                    .padding(.vertical,20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
               
                Spacer()
                Spacer()
                Text("Score: \(count)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Text("(Hits remaining: \(questionsRemaining))")
                    .foregroundColor(.white)
                    .font(.footnote)
                
                /* Text("Wrong: \(wrong)")
                    .foregroundColor(.white)
                    .font(.title.bold())*/
                Spacer()
                
            }.padding()
            
        }.alert(scoreTitle, isPresented: $showingScore){
            
            //Button("Close", role: .cancel){}
            Button("Continue", action: askQuestion)
        }message: {
            Text(check)
           /* if wrong>=1{
            Text("Wrong Answers: \(wrong)")
        }*/
        }
            //second alert
                .alert("The game is over", isPresented: $limit){
                    Button("Play again", action: reset)
                    
                }message: {
                   
                    Text("Total Trials \(catchTap).\nHits: \(correct).\nMisses: \(wrong).\n Final Score: \(count)")
                 
                
            }
        
    }
    
    func flagTapped(_ number:Int){
        catchTap=catchTap+1
        questionsRemaining=questionsRemaining-1
        
        if(number==correctAnswer){
            scoreTitle = "Correct"
            count=count+1
            correct=correct+1
            check = "You are absolutely right. That is the flag of \(countries[correctAnswer])."
        }
        else{
            scoreTitle = "Wrong"
            count=count-1
            wrong=wrong+1
            check = "Uh-oh. That is the flag of \(countries[number])."
        }
        if catchTap>=8{
            limit=true
        }
        else{
            showingScore = true
        }
                
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer=Int.random(in: 0...2)
    }
    
    func reset(){
        
        countries.shuffle()
        correctAnswer=Int.random(in: 0...2)
        count = 0
        catchTap=0
        questionsRemaining=8
        
    }
    
  
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
