//
//  CyberRiskQuizView.swift
//  Cyber Wise
//
//  Created by Advika Rapolu on 9/21/24.
//

import SwiftUI

struct CyberRiskQuizView: View {
    // State variable to track selected answers for each question
    @State private var selectedAnswers: [Int?] = Array(repeating: nil, count: 20) //20 questions
    
    //State variable to enable or disable the DONE button
    @State private var isDoneButtonEnabled = false
    
    //Correct answers for each question (corresponding to options' indices)
    let correctAnswers = [
        //Password Security
        [0, 0, 1, 0], //Correct answers' indices
        //Device Security
        [0, 0, 1, 0],
        //Email and Communication Security
        [1, 0, 0, 0],
        //Social Media and Privacy
        [1, 0, 1, 0],
        //Online Shopping and Financial Security
        [0, 0, 1, 0]
    ].flatMap {$0} //Flatten the array to match the 20-question format
    
    //Array of quiz questions and answers
    let questions : [(String, [String])] = [
        //Password Security
        ("Do you use a mix of letters, numbers, and symbols in your password?", ["Yes", "Frequently", "Sometimes", "No"]),
        ("Do you change your important passwords regularly [once every 6 months to year]?", ["Yes", "For some but not all", "No"]),
        ("Do you use the same passwords for multiple accounts?", ["Yes", "No"]),
        ("Do you use 2 factor authentication [2 methods of signing in] for important accounts [ex. Gmail, banks]?", ["Yes", "For some but not all", "No"]),
                
        // Device Security
        ("Do you keep your device's operating system up to date [complete software updates]?", ["Yes", "No"]),
        ("Do you use a screen lock on your devices [PIN, fingerprint, etc.]?", ["Yes", "For some but not all", "No"]),
        ("Do you use public wifi for sensitive activities [banking, shopping, etc.]?", ["Yes", "Sometimes", "No"]),
        ("Do you have antivirus or security software installed on your devices?", ["Yes", "For some but not all", "No"]),
                
        // Email and Communication Security
        ("Do you click on links or download attachments from unknown sources?", ["Yes", "Sometimes", "No"]),
        ("Do you verify the sender's email address before responding?", ["Yes", "Sometimes", "No"]),
        ("Do you use secure messaging apps for important/private conversations?", ["Yes", "Sometimes", "No"]),
        ("Do you report suspicious/spam emails to your email provider/place of work/school district?", ["Yes", "Sometimes", "No"]),
                
        // Social Media and Privacy
        ("Do you share personal information on social media [location, place of work/school, full name]?", ["Yes", "Sometimes", "No"]),
        ("Do you review the privacy settings on your social media accounts?", ["Yes", "No"]),
        ("Do you accept friend requests from strangers?", ["Yes", "No"]),
        ("Do you use private or 'friends-only' settings for your social media profiles?", ["Yes", "No"]),
                
        // Online Shopping and Financial Security
        ("Do you check for HTTPS [lock sign next to URL] and secure payment methods?", ["Yes", "Sometimes", "No"]),
        ("Do you monitor your bank statements/emails for unauthorized transactions?", ["Yes", "Sometimes", "No"]),
        ("Do you save your payment information on shopping websites?", ["Yes", "No"]),
        ("Do you verify the legitimacy of sellers/retailers?", ["Yes", "No"])
    ]
    let colors: [Color] = [.red.opacity(0.8), .yellow.opacity(0.8), .purple.opacity(0.8), .green.opacity(0.8)] // Cycle through these colors
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(0..<questions.count, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 20) {
                        // Question Text
                        Text("\(index + 1). \(questions[index].0)")
                            .font(.custom("Galvji", size: 18))
                            .padding()
                            .lineSpacing(5)
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                            .background(colors[index % colors.count])
                            .cornerRadius(15)
                            
                        // Answer Options
                        ForEach(0..<questions[index].1.count, id: \.self) { answerIndex in
                            HStack {
                                // Circle button logic
                                Button(action: {
                                    selectedAnswers[index] = answerIndex
                                    checkIfAllQuestionsAnswered()
                                }) {
                                    Image(systemName: selectedAnswers[index] == answerIndex ? "circle.fill" : "circle")
                                        .foregroundColor(.black)
                                }
                                Text(questions[index].1[answerIndex])
                                    .font(.custom("Galvji", size: 18))
                                    .foregroundColor(.black)
                            }
                            .padding(.leading)
                        }
                    }
                    .padding(.bottom, 20)
                }
                    
                // Done button
                NavigationLink(destination: QuizCompletionView(selectedAnswers: selectedAnswers, correctAnswers: correctAnswers)) {
                    Text("DONE")
                        .font(.custom("Galvji", size: 24))
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.black)
                        .cornerRadius(15)
                }
                .disabled(!isDoneButtonEnabled)
                .padding(.top, 30)
            }
            .navigationBarTitle("Cyber Risk Quiz", displayMode: .inline)
        }
        .padding()
    }
    
    func checkIfAllQuestionsAnswered () {
        isDoneButtonEnabled = selectedAnswers.allSatisfy {$0 != nil}
    }
}



struct QuizCompletionView: View {
    let selectedAnswers: [Int?]
    let correctAnswers: [Int]
    
    var body: some View {
        let results = evaluateQuizResults(selectedAnswers: selectedAnswers, correctAnswers: correctAnswers)
        
        ScrollView {
            VStack {
                Text(" 🎉 Congrats! You completed the quiz!")
                    .font(.custom("Galvji", size: 24))
                    .fontWeight(.bold)
                    .padding()
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("Here are your results:")
                    .font(.custom("Galvji", size: 24))
                    .fontWeight(.bold)
                    .padding()
                    .fixedSize(horizontal: false, vertical: true)
                
                VStack(alignment: .leading) {
                    Text("Strengths:")
                        .font(.custom("Galvji", size: 20))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 5)
                    ForEach(results.strengths, id: \.self) { sector in
                        HStack {
                            Image(systemName: "checkmark.circle")
                            Text(sector)
                                .font(.custom("Galvji", size: 16))
                        }
                    }
                }
                .padding()
                .background(Color.green.opacity(0.2))
                .cornerRadius(15)
                .fixedSize(horizontal: false, vertical: true)
                
                VStack(alignment: .leading) {
                    Text("Weaknesses:")
                        .font(.custom("Galvji", size: 20))
                        .padding(.bottom, 5)
                        .multilineTextAlignment(.center)
                    ForEach(results.weaknesses, id: \.self) { sector in
                        HStack {
                            Image(systemName: "xmark.circle")
                            Text(sector)
                                .font(.custom("Galvji", size: 16))
                        }
                    }
                }
                .padding()
                .background(Color.red.opacity(0.2))
                .cornerRadius(15)
                .fixedSize(horizontal: false, vertical: true)
                
                Text("Recommendations")
                    .font(.custom("Galvji", size: 20))
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .fixedSize(horizontal: false, vertical: true)
                
                ForEach(results.recommendations, id: \.self) { recommendation in
                    Text(recommendation)
                        .font(.custom("Galvji", size: 20))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(15)
                }
                
                Text("⏰ Don't forget to retake this quiz in 3 months to check your security!")
                    .font(.custom("Galvji", size: 24))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding()
            .navigationBarBackButtonHidden(true) // Hide the default back button
                    .navigationBarItems(leading: Button(action: {
                        // Navigate back to the home screen
                        // Customize to match your actual ContentView or home screen
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            windowScene.windows.first?.rootViewController = UIHostingController(rootView: ContentView())
                        }
                    }) {
                        HStack {
                            Image(systemName: "arrow.left")
                            Text("Home")
                        }
                    })
        }
    }
    
    func evaluateQuizResults(selectedAnswers: [Int?], correctAnswers: [Int]) -> (strengths: [String], weaknesses: [String], recommendations: [String]) {
            let sectors = ["Password Security", "Device Security", "Email and Communication Security", "Social Media and Privacy", "Online Shopping and Financial Security"]
            
            let recommendationsDict: [Int: String] = [
                0: "Use a mix of letters, numbers, and symbols in your password",
                1: "Change your important passwords every 6 months",
                2: "Use a different password for each account (use password managers to keep track of them!)",
                3: "Use 2 methods [ex: a password and face ID] for signing into important accounts",
                4: "Check your software updates weekly or turn on notifications for them",
                5: "Set up a screen lock on your devices",
                6: "Avoid using public wifi [at airports, restaurants, etc.] for important activities",
                7: "Install antivirus or security software",
                8: "Never click on links or download attachments from unknown sources!",
                9: "Always verify the sender's email address before responding",
                10: "Always use secure messaging apps [ex: iMessage, Telegram, Whatsapp] for conversations",
                11: "Always report suspicious/spam emails to your email provider or work/school tech center if they manage the account",
                12: "Never share personal information [current location, place of work/school, full name] on social media",
                13: "Always review the privacy settings on your social media accounts",
                14: "Never accept friend requests or respond to messages from strangers",
                15: "Use private or 'friends-only' settings for your social media profiles",
                16: "Check for the lock symbol next to the URL [a secure site] before entering payment info",
                17: "Regularly monitor your bank statements/emails for unauthorized transactions",
                18: "Avoid saving payment information on shopping websites",
                19: "Verify the legitimacy of the sellers/website before making a purchase"
            ]
            
            var strengths = [String]()
            var weaknesses = [String]()
            var recommendations = [String]()
        
        for i in 0..<sectors.count {
            let sectorAnswers = Array(selectedAnswers[i*4..<(i*4+4)])
            let sectorCorrectAnswers = Array(correctAnswers[i*4..<(i*4+4)])
            let correctCount = zip(sectorAnswers, sectorCorrectAnswers).filter { $0 == $1 }.count
            
            if correctCount >= 3 {
                strengths.append(sectors[i])
            } else if correctCount <= 2 {
                weaknesses.append(sectors[i])
            }
                // Add recommendations for incorrect answers in this sector
            for j in 0..<4 {
                if sectorAnswers[j] != sectorCorrectAnswers[j] {
                let questionIndex = i * 4 + j
                if let recommendation = recommendationsDict[questionIndex] {
                    recommendations.append(recommendation)
                    }
                }
            }
                
        }
                    
        return (strengths: strengths, weaknesses: weaknesses, recommendations: recommendations)
        }
}
                    

struct CyberRiskQuizView_Previews: PreviewProvider {
    static var previews: some View {
        CyberRiskQuizView()
    }
}

