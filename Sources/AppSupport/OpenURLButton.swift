//
//  OpenURLButton.swift
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

public struct OpenURLButton<Label>: View where Label: View {

    public let url: URL
    public let label: Label

    public var body: some View {
        Button(action: {
            UIApplication.shared.open(self.url)
        }) {
            label
        }
    }

    public init(url: URL, label: () -> Label) {
        self.url = url
        self.label = label()
    }

}

public extension OpenURLButton where Label == Text {

    init(title: String, url: URL) {
        self.init(url: url) {
            Text(title)
                .foregroundColor(.primary)
        }
    }

}

#if DEBUG
struct OpenURLButton_Previews: PreviewProvider {
    static var previews: some View {
        OpenURLButton(title: "Open a URL", url: URL(string: "https://example.com")!)
    }
}
#endif

#endif
