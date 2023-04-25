//
//  TextFieldContainer.swift
//  ParkingApp
//
//  Created by vacheslavBook on 23.04.2023.
//

/*import UIKit
import SwiftUI

struct TextFieldContainer: UIViewRepresentable {
    private var placeholder: String
    private var text: Binding<String>
    
    init(placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self.text = text
    }
    
    func makeCoordinator() -> TextFieldContainer.Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<TextFieldContainer>) -> UITextField {
        let innertTextField = UITextField(frame: .zero)
        innertTextField.placeholder = placeholder
        innertTextField.text = text.wrappedValue
        innertTextField.delegate = context.coordinator
        innertTextField.keyboardType = .numberPad
        
        context.coordinator.setup(innertTextField)
        
        return innertTextField
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.text = text.wrappedValue
    }
    
    class Coordinator: NSObject, UITextFieldDelegate{
        
        var parent: TextFieldContainer
        
        init(parent: TextFieldContainer) {
            self.parent = parent
        }
        
        func setup(_ textField: UITextField) -> () {
            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) -> () {
            parent.text.wrappedValue = textField.text ?? ""
        }
        
    }
}
*/
