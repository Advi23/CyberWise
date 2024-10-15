//
//  ContentView.swift
//  Cyber Wise
//
//  Created by Advika Rapolu on 8/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{ //Wrapping in nav view for nav capabilities
            VStack {
                Spacer(minLength: 50) //Adds more space at top
                //Welcome message
                Text("Welcome!")
                    .font(.custom("Galvji", size: 34))
                    .fontWeight(.bold)
                    .padding(.bottom, 2)
                    .multilineTextAlignment(.center)
                
                Text("Pick an activity!")
                    .font(.custom("Galvji", size: 24))
                    .padding(.bottom, 40)
                    .multilineTextAlignment(.center)
                
                //Activity buttons
                VStack(spacing: 25) {
                    
                    /*NavigationLink(destination: CryptographyGameView()) {
                        Text("Cryptography Game")
                            .font(.custom("Galvji", size: 20))
                            .foregroundColor(.black)  // Change text color to black
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }*/
                    
                    NavigationLink(destination: CyberRiskQuizView()) {
                        Text("Cyber Risk Quiz")
                            .font(.custom("Galvji", size: 20))
                            .foregroundColor(.black)  // Change text color to black
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .background(Color.green)
                            .cornerRadius(12)
                    }
                    
                    NavigationLink(destination: PhishingAttacksView()) {
                        Text("Phishing Attacks")
                            .font(.custom("Galvji", size: 20))
                            .foregroundColor(.black)  // Change text color to black
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    
                    NavigationLink(destination: DigitalCitizenView()) {
                        Text("Be a Good Digital Citizen")
                            .font(.custom("Galvji", size: 20))
                            .foregroundColor(.black)  // Change text color to black
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .background(Color.purple)
                            .cornerRadius(12)
                    }
                    
                    NavigationLink(destination: HackADayView()) {
                        Text("Hack a Day")
                            .font(.custom("Galvji", size: 20))
                            .foregroundColor(.black)  // Change text color to black
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .background(Color.red)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                //Contact Information
                Text("contact: cyberwise0@gmail.com")
                    .font(.custom("Galvji", size: 16))
                    .padding(.bottom, 20)
                    .foregroundColor(.black)
            }
            .padding()
            .background(Color(red: 1.0, green: 0.843, blue: 0.364).edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)  // Remove the navigation bar text
        }
    }
}

//Define Placeholder values for each Navigation Destination
struct CryptographyGameView: View {
    var body: some View {
        Text("Cryptography Game")
            .font(.largeTitle)
            .navigationBarTitle("Cryptography Game", displayMode: .inline)
    }
}

/*struct CyberRiskQuizView: View {
    var body: some View {
        Text("Cyber Risk Quiz")
            .font(.largeTitle)
            .navigationBarTitle("Cyber Risk Quiz", displayMode: .inline)
    }
}*/

struct PhishingAttacksView: View {
    var body: some View {
        Text("Phishing Attacks")
            .font(.largeTitle)
            .navigationBarTitle("Phishing Attacks", displayMode: .inline)
    }
}

/*struct DigitalCitizenView: View {
    var body: some View {
        Text("Be a Good Digital Citizen")
            .font(.largeTitle)
            .navigationBarTitle("Good Digital Citizen", displayMode: .inline)
    }
}*/

struct HackADayView: View {
    var body: some View {
        Text("Hack a Day")
            .font(.largeTitle)
            .navigationBarTitle("Hack a Day", displayMode: .inline)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
