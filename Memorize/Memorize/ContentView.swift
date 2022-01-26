//
//  ContentView.swift
//  Memorize
//
//  Created by Daria Zvezdochkina on 19.01.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var emojisStore = EmojiStore()
    @State var emojiCount = 4
    var body: some View {
        VStack {
            ScrollView {
                Text("Memorize")
                    .font(.largeTitle)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(emojisStore.emojis, id: \.self) { emoji in
                        CardView(contentIcon: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
        
            Spacer()
            HStack {
                displayDevices
                Spacer()
                displayHuman
                Spacer()
                displayNature
            }
            .foregroundColor(.blue)
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
        .foregroundColor(.black)
    }
    
    var displayDevices: some View {
        Button (action:{
            emojisStore.addDevices()
            emojisStore.emojis.shuffle()
        }, label:
            {
            Image(systemName: "iphone")
            Text("Device")
                .font(.body)
                .padding(.vertical)
        })
        }
    var displayHuman: some View {
        Button (action:{
            emojisStore.addHuman()
            emojisStore.emojis.shuffle()
        }, label:
            {
            Image(systemName: "person")
            Text("Human")
                .font(.body)
                .padding(.vertical)
        })
        }
    var displayNature: some View {
        Button (action:{
            emojisStore.addNature()
            emojisStore.emojis.shuffle()
        }, label:
            {
            ZStack {
                Image(systemName: "globe.europe.africa")
                Text("Nature")
                    .font(.body)
                    .padding(.vertical)
            }
        })
        }
}

class EmojiStore: ObservableObject {
    @Published var emojis: [String] = ["🚎", "🚔", "🚘", "🚖", "🚍", "🚒", "🚙", "🚕", "🚗", "🏎", "🚓", "🚑", "🚲"]
    @Published var emojiCount = 4
    
    func addDevices(){
        emojis = ["📱", "💻", "🖥️", "🖨️", "⌨️", "🎧", "📷", "📠", "🎙️", "📞"]
    }
    
    func addHuman(){
        emojis = ["😁", "😜", "😝", "🥶", "🤨", "😆", "🤒", "😰", "🥱", "😣"]
    }
    
    func addNature(){
        emojis = ["🌳", "🪴", "🦟", "🐢", "🐞", "☘️", "🍀", "🌱", "🦜", "🐷"]
//        Int.random(in: <#T##Range<Self>#>)
    }
    
    
}
//    var remove: some View {
//        Button(action: {if emojiCount < emojis.count {emojiCount += 1}}, label: {Image(systemName: "plus.circle")})
//    }
//
//    var add: some View {
//        Button(action: {if emojiCount > 1 {emojiCount -= 1} }, label: {Image(systemName: "minus.circle")})
//    }



struct CardView: View {
    var contentIcon: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10)
            if isFaceUp {
                shape.fill().foregroundColor(.gray)
                shape.strokeBorder(lineWidth: 3)
                Text(contentIcon).font(.largeTitle)
            } else {
                shape.fill().foregroundColor(.gray)
            }
        }
        .onTapGesture(perform: {
            isFaceUp = !isFaceUp
        })
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
