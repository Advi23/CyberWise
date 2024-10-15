//
//  DigitalCitizenView.swift
//  Cyber Wise
//
//  Created by Advika Rapolu on 10/14/24.
//

import SwiftUI

struct DigitalCitizenView: View {
    
    //Tips data structure
    let tips = [
        "Always think before you post.",
        "Use polite and respectful language in all online interactions.",
        "Avoid using ALL CAPS, as it may seem like shouting.",
        "Respect others' opinions, even if you disagree.",
        "Don’t engage in arguments or 'flame wars' online.",
        "Keep personal details like addresses and phone numbers private.",
        "Give proper credit when sharing content or ideas.",
        "Refrain from sharing rumors or unverified information.",
        "Use emojis and punctuation to clarify your message's tone.",
        "Stand up for someone being bullied online by reporting the behavior.",
        "Don’t forward or share harmful messages or embarrassing content.",
        "If you’re being bullied, save evidence and report it to a trusted adult.",
        "Block or unfollow anyone who engages in bullying behavior.",
        "Be cautious about participating in group chats where bullying might happen.",
        "Avoid responding to aggressive or offensive comments.",
        "Spread positivity by complimenting others and sharing encouraging messages.",
        "Teach others about the harm cyberbullying causes.",
        "Create a safe space by ensuring friends or followers feel respected online.",
        "Use strong, unique passwords for each account.",
        "Enable two-factor authentication whenever possible.",
        "Keep your personal and professional online identities separate.",
        "Log out of accounts when using shared or public devices.",
        "Never meet someone in person that you only know online without proper safety measures.",
        "Be skeptical of 'too good to be true' offers and contests.",
        "Take regular breaks from screens and social media.",
        "Set limits on your social media usage each day.",
        "Be mindful of what kind of content you’re consuming online.",
        "Don’t feel pressured to respond immediately to every message.",
        "Be conscious of the impact your posts may have on others."
    ]
    
    @State private var currentTip: String = ""
    @State private var shownTips = Set<String>()
    @State private var currentColor: Color = .red.opacity(0.2)
    
    let colors: [Color] = [.red.opacity(0.2), .blue.opacity(0.2), .yellow.opacity(0.2)] // Colors to cycle through
    
    var body: some View {
        VStack {
            Spacer()
            
            //Rectangle with tip text
            Text(currentTip)
                .font(.custom("Galvji", size:30))
                .multilineTextAlignment(.center)
                .lineSpacing(15)
                .padding(20)
                .frame(maxWidth: .infinity, minHeight: 500)
                .background(currentColor)
                .cornerRadius(12)
                .padding(.horizontal, 30)
            
            Spacer()
            
            //Button to get another tip
            Button(action: {
                showNextTip()
            }) {
                Text("Another!")
                    .font(.custom("Galvji", size:30))
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 100)
                    .background(Color.green.opacity(0.5))
                    .cornerRadius(12)
                    .padding(.horizontal, 50)
            }
            
            Spacer()
        }
        .onAppear {
            
            //Show the first tip when the view appears
            showNextTip()
        }
        .navigationBarTitle("Be a Good Digital Citizen", displayMode: .inline)
    }
    
    //Function to show the next tip
    func showNextTip() {
        //Check if all tips have been shown, then reset
        if shownTips.count == tips.count {
            shownTips.removeAll()
        }
        
        //Pick a random tip that hasn't been shown
        var newTip: String
        repeat {
            newTip = tips.randomElement() ?? ""
        } while shownTips.contains(newTip)
        
        currentTip = newTip
        shownTips.insert(newTip) //insert the current tip into shownTips so to not repeat again
        
        currentColor = colors.randomElement() ?? .red.opacity(0.2)
    }
}

struct DigitalCitizenView_Previews: PreviewProvider {
    static var previews: some View {
        DigitalCitizenView()
    }
}
