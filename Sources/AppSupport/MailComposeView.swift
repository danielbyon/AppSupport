//
//  MailComposeView.swift
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

public struct MailComposeView: UIViewControllerRepresentable {

    public let toRecipients: [String]?
    public let subject: String

    @Binding public var isShowing: Bool
    @Binding public var result: Result<MFMailComposeResult, Error>?

    public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding var isShowing: Bool
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(
            isShowing: Binding<Bool>,
            result: Binding<Result<MFMailComposeResult, Error>?>) {
            _isShowing = isShowing
            _result = result
        }

        public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            defer { isShowing = false }
            if let error = error {
                self.result = .failure(error)
            } else {
                self.result = .success(result)
            }
        }

    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(isShowing: $isShowing, result: $result)
    }

    public func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let controller = MFMailComposeViewController()
        controller.setToRecipients(toRecipients)
        controller.setSubject(subject)
        controller.mailComposeDelegate = context.coordinator
        return controller
    }

    public func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {

    }

}

#endif
