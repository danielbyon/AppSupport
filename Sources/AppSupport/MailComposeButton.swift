//
//  MailComposeButton.swift
//  AppSupport
//
//  Copyright © 2020 Daniel Byon
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#if os(iOS) || targetEnvironment(macCatalyst)

import SwiftUI
import MessageUI

public struct MailComposeButton<Label>: View where Label: View {

    @State private var isShowingComposeEmail = false
    @State private var isShowingComposeError = false
    @State private var composeResult: Result<MFMailComposeResult, Error>?

    public let emailAddress: String
    public let subject: String
    public let label: Label

    public var body: some View {
        Button(action: {
            if MFMailComposeViewController.canSendMail() {
                self.isShowingComposeEmail.toggle()
            } else {
                self.isShowingComposeError.toggle()
            }
        }) {
            label
        }
        .sheet(isPresented: $isShowingComposeEmail) {
            MailComposeView(toRecipients: [self.emailAddress], subject: self.subject, isShowing: self.$isShowingComposeEmail, result: self.$composeResult)
        }
        .alert(isPresented: $isShowingComposeError) {
            Alert(title: Text("Can't send email"), message: Text("Please check your email settings and try again."), dismissButton: nil)
        }
    }

    public init(emailAddress: String, subject: String, label: () -> Label) {
        self.emailAddress = emailAddress
        self.subject = subject
        self.label = label()
    }

}

public extension MailComposeButton where Label == Text {

    init(title: String, emailAddress: String, subject: String) {
        self.init(emailAddress: emailAddress, subject: subject) {
            Text(title)
                .foregroundColor(.primary)
        }
    }

}

#if DEBUG
struct MailComposeButton_Previews: PreviewProvider {
    static var previews: some View {
        MailComposeButton(title: "Hello World", emailAddress: "test@example.com", subject: "Test")
    }
}
#endif

#endif
