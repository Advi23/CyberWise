//
//  PhishingAttackView.swift
//  Cyber Wise
//
//  Created by Advika Rapolu on 10/18/24.
//

import SwiftUI

struct PhishingAttackView: View {
    @State private var currentScenario: PhishingScenario = PhishingScenarios.randomElement()!
    @State private var usedScenarios: Set<String> = []
    @State private var showResultScreen = false
    @State private var isUserCorrect = false
    @State private var explanation = ""
    
    var body: some View {
        
            VStack {
                ScrollView {
                    Spacer()
                    
                    // Display the current scenario
                    Text(currentScenario.title)
                        .font(.custom("Galvji", size: 30))
                        .bold()
                        .padding()
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.3))
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .padding(.top, 20)
                    
                    Text(currentScenario.message)
                        .font(.custom("Galvji", size: 24))
                        .padding()
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, minHeight: 400)
                        .background(Color.blue.opacity(0.3))
                        .cornerRadius(15)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    // Buttons for Phishing or Not
                    HStack(spacing: 20) {
                        Button(action: {
                            handleAnswer(isPhishing: true)
                        }) {
                            Text("PHISHING ATTACK")
                                .font(.custom("Galvji", size: 24))
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity, minHeight: 100)
                                .background(Color.red.opacity(0.8))
                                .cornerRadius(15)
                        }
                        
                        Button(action: {
                            handleAnswer(isPhishing: false)
                        }) {
                            Text("NOT A PHISHING ATTACK")
                                .font(.custom("Galvji", size: 24))
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity, minHeight: 100)
                                .background(Color.green.opacity(0.8))
                                .cornerRadius(15)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 50)
                    
                    // Navigation to the result screen
                    NavigationLink(
                        destination: PhishingResultView(isCorrect: isUserCorrect,
                            explanation: explanation,
                            currentScenario: $currentScenario,
                            usedScenarios: $usedScenarios),
                        isActive: $showResultScreen
                    ) {
                        EmptyView()
                    }
                }
            }
            .navigationTitle("Phishing Scenario")
        
    }
    
    // Function to handle navigation to the answer screen
    func handleAnswer(isPhishing: Bool) {
        isUserCorrect = (isPhishing == currentScenario.isPhishing)
        explanation = currentScenario.explanation
        showResultScreen = true
    }
    
    // Function to get the next scenario
}

struct PhishingResultView: View {
    let isCorrect: Bool
    let explanation: String
    @Binding var currentScenario: PhishingScenario
    @Binding var usedScenarios: Set<String>
    
    var body: some View {
        VStack {
            ScrollView {
                Spacer()
                
                // Conditional rendering based on whether the user was correct or not
                Text(isCorrect ? "🎉 Congrats! You're right!" : "😕 Oops, that's not correct.")
                    .font(.custom("Galvji", size: 30))
                    .bold()
                    .padding()
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, minHeight: 100)
                    .background(isCorrect ? Color.green.opacity(0.7) : Color.red.opacity(0.7))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.top, 20)
                
                // Explanation of why the message was or wasn't a phishing attack
                Text(explanation)
                    .font(.custom("Galvji", size: 24))
                    .padding()
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, minHeight: 400)
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(15)
                    .padding(.horizontal)
                
                Spacer()
                
                // Button to move to the next scenario
                Button(action: {
                    getNextScenario()
                }) {
                    Text("Next Scenario")
                        .font(.custom("Galvji", size: 24))
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: 200, height: 100)
                        .background(Color.yellow.opacity(0.8))
                        .cornerRadius(15)
                }
                .padding(.bottom, 50)
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
        .onAppear {
            // Prepare the next scenario on view appearance
            getNextScenario()
        }
    }
    
    func getNextScenario() {
        /*if usedScenarios.count == PhishingScenarios.count {
            usedScenarios.removeAll()
        }
        
        //Pick a random tip that hasn't been shown
        var newScenario: PhishingScenario
        repeat {
            newScenario = PhishingScenarios.randomElement() ?? PhishingScenario(title: "", message: "", isPhishing: false, explanation: "")
        } while usedScenarios.contains(newScenario.title)
        
        currentScenario = newScenario
        usedScenarios.insert(newScenario.title)*/
        
        usedScenarios.insert(currentScenario.title)
        
        // Filter out used scenarios
        let remainingScenarios = PhishingScenarios.filter { !usedScenarios.contains($0.title) }
        
        // If no scenarios are left, reset
        if remainingScenarios.isEmpty {
            usedScenarios.removeAll()
        }
        
        currentScenario = (remainingScenarios.randomElement() ?? PhishingScenarios.randomElement())!
    }
}

// Define phishing scenarios
struct PhishingScenario {
    let title: String
    let message: String
    let isPhishing: Bool
    let explanation: String
}

// Sample phishing and non-phishing scenarios (same as before)
let PhishingScenarios: [PhishingScenario] = [
    PhishingScenario(title: "URGENT: Verify Your Account to Avoid Deactivation", message: "Dear user, your account will be deactivated in 24 hours unless you verify your identity. Click the link below to keep your account active: https://cl.gy/XWop.", isPhishing: true, explanation: "This email creates a sense of urgency, pressuring the recipient into thinking their account will be deactivated. The link provided directs them to a fake site designed to steal login credentials or personal information. The attacker can use these details to gain unauthorized access to the account."),
    PhishingScenario(title: "Security Alert: Unusual Activity Detected", message: "We've noticed suspicious activity on your account. To protect your funds, please confirm your identity by logging in here: https://bitly.bankconfirm75903. Failure to do so will result in account suspension.", isPhishing: true, explanation: "This email plays on the fear of losing money or having an account suspended. The fake bank login link leads to a malicious website that mimics a legitimate banking site. When users enter their credentials, attackers steal the information to access their real bank accounts, leading to potential financial loss."),
    PhishingScenario(title: "Immediate Job Opportunity – No Experience Needed!", message: "We have reviewed your profile and are pleased to offer you a work-from-home position with an attractive salary. Please send us your personal details and bank information to process your application.", isPhishing: true, explanation: "This email exploits the job-seeking process by offering a fake job opportunity. It asks for personal details and bank information, which could be used for identity theft or financial fraud. No legitimate employer asks for sensitive information like bank details before officially hiring someone."),
    PhishingScenario(title: "Tax Refund Notification", message: "Congratulations! You are eligible for a tax refund of $1000. To claim your refund, click here: https://bitly.tax34792. Note: Failure to complete the process within 48 hours will result in loss of the refund.", isPhishing: true, explanation: "This email promises a fake tax refund, creating a sense of excitement and urgency. It tricks recipients into clicking a malicious link to claim their refund. The link leads to a fake website where attackers collect sensitive financial information or personal details, leading to identity theft."),
    PhishingScenario(title: "Invoice #12345 is Overdue", message: "Your recent payment has failed. Please settle your outstanding invoice immediately by clicking here: https://bitly.invoice91023. Failure to act will result in additional fees.", isPhishing: true, explanation: "This email mimics an unpaid invoice, scaring the recipient into thinking they owe money. By clicking on the fake payment portal, the user is directed to a malicious site where their payment details (such as credit card information) can be stolen."),
    PhishingScenario(title: "Text Message", message: "Your package is being held due to unpaid shipping fees. Pay now to release your package: https://bitly.package38542.", isPhishing: true, explanation: "This text message preys on the common scenario of package deliveries, claiming that a package is being held due to unpaid fees. The fake payment link leads to a fraudulent site where users are tricked into entering their credit card details, which attackers can steal and use for unauthorized purchases."),
    PhishingScenario(title: "Text Message", message: "Unusual activity detected on your account. Please verify your identity immediately by clicking the link: https://bitly.account21675. Failure to act will result in account suspension.", isPhishing: true, explanation: "This message uses fear and urgency, making the recipient believe there’s unusual activity on their bank account. The link directs the user to a fraudulent site where they are tricked into entering their bank credentials, giving attackers access to their account and funds."),
    PhishingScenario(title: "Text Message", message: "Someone tried logging into your social media account from an unknown device. If this was not you, secure your account here: https://bitly.loginportal.", isPhishing: true, explanation: "This text message pretends to be a security notification from a social media platform. The fake login link redirects to a malicious site that captures the victim’s login credentials, which attackers can then use to take over their social media account and potentially use it for further scams."),
    PhishingScenario(title: "Text Message", message: "Congratulations! You’ve been selected for a free gift. Claim your prize now by clicking here: https://bitly.gift104.", isPhishing: true, explanation: "This message taps into the excitement of winning something for free. The fake gift link leads to a fraudulent site where users are often asked to provide personal information, credit card details, or click on malicious ads, resulting in financial or personal data theft."),
    PhishingScenario(title: "Text Message", message: "Your Netflix account has been suspended. Update your payment information to continue enjoying our services: https://pay-netflex-here.", isPhishing: true, explanation: "This message falsely claims that a Netflix account has been suspended, creating fear that the recipient will lose access to a service they use. The fake payment link directs the user to a fraudulent page where attackers steal payment information or login credentials."),
    PhishingScenario(title: "Welcome! Activate Your Account", message: "Thank you for signing up! Click the link below to activate your account and get started: https://spotify.com/activate. If you didn't sign up, please ignore this email.", isPhishing: false, explanation: "This email is sent after a user has signed up for an account. It contains a legitimate activation link specific to the user's request. The warning to ignore the email if they didn't sign up is a common practice to protect against unauthorized access."),
    PhishingScenario(title: "Your Order #56789 Has Been Confirmed", message: "Thank you for your purchase! Your order has been confirmed and will be shipped shortly. You can track your order here: https://zara/track-order/56789.", isPhishing: false, explanation: "This email confirms a purchase made by the user, providing details about the order number and shipment. The presence of a tracking link is typical for legitimate retailers, allowing customers to monitor their purchases."),
    PhishingScenario(title: "Password Reset Request", message: "You requested to reset your password. Click the link below to proceed: https://amazon.com/reset-password. If you didn’t make this request, please contact our support.", isPhishing: false, explanation: "This email is generated in response to a specific user action (the request to reset their password). It includes a link to securely reset the password. The option to contact support if the request wasn't made is a good security practice."),
    PhishingScenario(title: "Invoice for Your Monthly Subscription", message: "Your payment of $9.99 for this month's subscription has been successfully processed. You can view your invoice here: https://pandora.com/invoice/20593. Thank you for your continued support.", isPhishing: false, explanation: "This email serves as an invoice for a subscription service the user has signed up for. It confirms a legitimate transaction with a link to view the invoice, common for businesses to keep customers informed of payments."),
    PhishingScenario(title: "Your Package Has Shipped!", message: "Good news! Your package is on its way and will be delivered soon. Track your shipment here: https://ups.com/order20195803", isPhishing: false, explanation: "This email notifies the user that their purchase has shipped, including a tracking link for delivery. Such emails are standard communication for online shopping, ensuring customers are updated on their orders."),
    PhishingScenario(title: "Text Message", message: "Reminder: You have an appointment with Dr. Smith on October 18th at 2:00 PM. Reply 'Y' to confirm or 'N' to cancel.", isPhishing: false, explanation: "This message is a reminder for a scheduled appointment the user has made. It provides clear information about the appointment time and allows for confirmation or cancellation, typical of legitimate healthcare practices."),
    PhishingScenario(title: "Text Message", message: "Your available balance is $1,234.56. To view recent transactions, log in to your account through our mobile app or website.", isPhishing: false, explanation: "This message contains information about the user's bank balance and advises them on how to access their account securely. Legitimate financial institutions often send alerts about account activity to keep customers informed."),
    PhishingScenario(title: "Text Message", message: "Your package is out for delivery and will arrive today by 5 PM. Track your delivery here: https://apple.com/990173.", isPhishing: false, explanation: "This text informs the user that their package is out for delivery, providing tracking information. Such updates are standard for delivery services to ensure transparency and customer awareness about their shipments."),
    PhishingScenario(title: "Text Message", message: "Your authentication code is 678123. Enter this code to complete your login. If you did not request this, please contact our support.", isPhishing: false, explanation: "This message contains a unique authentication code sent to the user for verifying their identity during login. It is a security measure implemented by many services to enhance account protection, indicating legitimate usage."),
    PhishingScenario(title: "Text Message", message: "We detected a login from a new device on your account. If this was you, no action is needed. If not, secure your account immediately by logging into your account from our website.", isPhishing: false, explanation: "This message alerts the user to a login from a new device, emphasizing account security. It gives users the option to secure their account if the activity was not authorized. Such alerts are standard security practices for social media platforms.")
]

struct PhishingAttackView_Previews: PreviewProvider {
    static var previews: some View {
            PhishingAttackView()
        }
}
