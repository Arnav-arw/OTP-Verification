//
//  Verfication.swift
//  OTP Verification
//
//  Created by Arnav Singhal on 15/06/23.
//

import SwiftUI

struct Verfication: View {
    
    @EnvironmentObject var otpModel: OTPViewModel
    
    @FocusState var activeField: OTPField?
    
    var body: some View {
        VStack {
            OTPField()
                .onAppear {
                    activeField = .field1
                }
            
            Button {
                Task{await otpModel.verifyOTP()}
            } label: {
                Text(otpModel.isLoading ? "" : "Verify")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical,12)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style:.continuous)
                            .fill(.blue)
                    }
                    .overlay {
                        ProgressView()
                            .opacity(otpModel.isLoading ? 1 : 0)
                    }
            }
            .disabled(checkStates())
            .opacity(checkStates() ? 0.4 : 1)
            .padding(.vertical)
            
            HStack(spacing: 12) {
                Text("Didn't get OTP?")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Button("Resend"){}
                    .font(.callout)
            }
            .frame(maxWidth: .infinity, alignment: .top)
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationTitle("Verification")
        .onChange(of: otpModel.otpFields) { newValue in
            OTPCondition(value: newValue)
        }
        .alert(otpModel.errorMsg, isPresented: $otpModel.showAlert) {}
    }
    
    func checkStates()->Bool {
        for index in 0..<6 {
            if otpModel.otpFields[index].isEmpty{return true}
        }
        
        return false
    }
    
    func OTPCondition(value: [String]) {
        
        // Checking if OTP is Pressed
        for index in 0..<6 {
            if value[index].count == 6 {
                DispatchQueue.main.async {
                    otpModel.otpText = value[index]
                    otpModel.otpFields[index] = ""
                    
                    for item in otpModel.otpText.enumerated() {
                        otpModel.otpFields[item.offset] = String(item.element)
                    }
                }
                return
            }
        }
        
        // Moving to the next field if current field type
        for index in 0..<5 {
            if value[index].count == 1 && activeStateIndex(index: index) == activeField {
                activeField = activeStateIndex(index: index + 1)
            }
        }
        
        // Moving Back if Current Field is Empty And Previous Field is not empty
        for index in 0...5 {
            if value[index].isEmpty && !value[index - 1].isEmpty {
                activeField = activeStateIndex(index: index - 1)
            }
        }
        for index in 0..<6 {
            if value[index].count > 1 {
                otpModel.otpFields[index] = String(value[index].last!)
            }
        }
    }
    
    @ViewBuilder
    func OTPField()->some View {
        HStack(spacing: 14) {
            ForEach(0..<6, id: \.self){index in
                VStack(spacing: 8) {
                    TextField("", text: $otpModel.otpFields[index])
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .multilineTextAlignment(.center)
                        .focused($activeField, equals: activeStateIndex(index: index))
                    Rectangle()
                        .fill(activeField == activeStateIndex(index: index) ? .blue: .gray.opacity(0.3))
                        .frame(height: 4)
                }
                .frame(width: 40)
            }
        }
    }
    
    func activeStateIndex(index: Int) -> OTPField {
        switch index {
            
        case 0: return .field1
        case 1: return .field2
        case 2: return .field3
        case 3: return .field4
        case 4: return .field5
        default: return .field6
        }
    }
    
}
    
struct Verfication_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


enum OTPField {
    case field1
    case field2
    case field3
    case field4
    case field5
    case field6
}

