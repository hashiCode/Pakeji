//
//  NewPackageView.swift
//  Pakeji
//
//  Created by Scott Takahashi on 02/05/21.
//

import SwiftUI

struct NewPackageView: View {
    @ObservedObject var viewModel: PackagesViewModel
    
    @State var name = ""
    @State private var notes = ""
    
    var body: some View {
        NavigationView {
            self.content
                .navigationBarTitle(Text("newPackage.title".localized()), displayMode: .inline)
                .navigationBarItems(
                    leading: self.cancelButton,
                    trailing: self.doneButton
                        .disabled(self.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                ).padding()
                .alert(isPresented: Binding<Bool>(get: { self.viewModel.operation == .error }, set: { _ in })) {
                    self.alert
                }
        }
        
    }
    
    private var content: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                GroupBox {
                    TextField("newPackage.placeholder.name".localized(), text: self.$name)
                    Divider()
                    ZStack(alignment: .topLeading) {
                        // Currently, TextEditor doesn't have a placeholder text
                        if self.notes.isEmpty{
                            Text("newPackage.placeholder.notes".localized())
                                .foregroundColor(Color(UIColor.placeholderText))
                                .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 8))
                        }
                        TextEditor(text: self.$notes).padding(.leading, -3)
                    }
                    
                }
                .frame(height: geometry.size.height / 2)
                Spacer()
            }
        }
    }
    
    private var cancelButton: some View {
        Button(action: self.cancel, label:  {
            Text("newPackage.navigation.cancel".localized()).bold()
        })
    }
    
    private var doneButton: some View {
        Button(action: self.save, label: {
            Text("newPackage.navigation.done".localized()).bold()
        })
    }
    
    // TODO analyze strange comportament when this alert dismiss after is presented
    private var alert: Alert {
        Alert(title: Text("newPackage.error.title".localized()), message: Text("newPackage.error.descriton".localized()), dismissButton: .default(Text("newPackage.error.dismiss".localized()), action: {
            self.viewModel.operation = .adding
        }))
    }
    
}

//MARK: button functions
extension NewPackageView {
    func cancel(){
        self.viewModel.operation = .none
    }
    
    func save(){
        self.viewModel.savePackage(name: self.name, notes: self.notes)
    }
}

