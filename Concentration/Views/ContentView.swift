//
//  ContentView.swift
//  Concentration
//
//  Created by abimael espinal on 6/19/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = GameViewModel()

    var body: some View {
        VStack {
            Text("Concentration Game")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding()
            GameOverView(viewModel: viewModel)
            HStack{
                Text("Score:")
                    .font(.title3)

                Text("\(viewModel.getScore())")

            
        }
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .onTapGesture {
                            viewModel.choose(card: card)
                        }
                        .padding(5)
                }
            }
            .padding()
            
            Button("New Game") {
                viewModel.newGame()
            }
            .foregroundColor(.green)
            .font(.largeTitle)
            .padding()
        }
    }
}

struct GameOverView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack{
            if viewModel.getScore() == 100 {
                Text("Congratulations!")
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding()
            } else if viewModel.getIsGameOver() {
                Text("Game Over")
                    .font(.headline)
                    .foregroundColor(.red)
                    .padding()
                } else {
                        Text("Mismatched cards lower the number. Keep it above 0!")
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                        
                    HStack{
                        Text("Total of tries:")
                            .font(.title)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text("\(viewModel.getTotalTries())")
                        .foregroundColor(viewModel.getTotalTries() <= 5 ? .red : .green)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }

                }
        }
    }
}

struct CardView: View {
    let card: Card
    
    var body: some View {
        ZStack{
            if card.isFaceUp || card.isMatched {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 3)
                Text(card.emoji)
                    .font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill()
            }
        }
        .aspectRatio(2/3, contentMode: .fit)
    }
}

#Preview {
    ContentView()
}
