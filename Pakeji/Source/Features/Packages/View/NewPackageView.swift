//
//  NewPackageView.swift
//  Pakeji
//
//  Created by Scott Takahashi on 02/05/21.
//

import SwiftUI

struct NewPackageView: View {
    @ObservedObject var viewModel: PackagesViewModel
    @Binding var show: Bool
    
    @State var name = ""
    @State private var notes = ""
    
    var body: some View {
        NavigationView {
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
                .navigationBarTitle(Text("newPackage.title".localized()), displayMode: .inline)
                .navigationBarItems(
                    leading: Button(action: {
                        self.show = false
                    }, label:  {
                        Text("newPackage.navigation.cancel".localized()).bold()
                        
                    }), trailing: Button(action: {
                        self.show = false
                    }, label: {
                        Text("newPackage.navigation.done".localized()).bold()
                    }).disabled(self.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                )
                .padding()
            }
        }
    }
    
}

