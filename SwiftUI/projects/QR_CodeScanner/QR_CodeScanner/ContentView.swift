//
//  ContentView.swift
//  QR_CodeScanner
//
//  Created by Taher on 7/3/23.
//

import CodeScanner
import SwiftUI

struct ContentView: View {

    @State var isPresentingScanner = true
    @State var isScanSucceed = false
    @State var scannedCode = "Scan QR code to get redeem"

    var scannerView: some View {
        CodeScannerView(
            codeTypes: [.qr],
            completion: { result in
                if case let .success(code) = result {
                    scannedCode = code.string
                    isScanSucceed = true
                } else {
                    scannedCode = "No code found"
                }
                isPresentingScanner = false
            }
        )
    }
    var body: some View {
        VStack{
            Text(scannedCode)
                .sheet(isPresented: $isPresentingScanner) {
                    self.scannerView
                }
            Button(
                action: {
                    if !isScanSucceed {
                        isPresentingScanner = true
                    }
                },
                label: {
                    Text(isScanSucceed ? "Use this code?" : "Scan Again")
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
