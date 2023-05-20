//
//  CreateView.swift
//  IOSTakeHome
//
//  Created by lapshop on 5/13/23.
//

import SwiftUI

struct CreateView: View {
    
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    @StateObject private var vm = CreateViewModel()
    let successfulAction : () -> Void
    
    
    var body: some View {
        NavigationView {
            
            
            Group {
                
                Form {
                    Section {
                        firstName
                        lastName
                        job
                    } footer: {
                        if case .validation(let error) = vm.error ,
                           let errorDesc = error.errorDescription {
                            Text(errorDesc)
                                .foregroundStyle(.red)
                        }
                    }

                    
                    
                    
                    Section {
                        submit
                    }
                    
                    
                    
                }
            }
            .disabled(vm.state == .submitting)
            .navigationTitle("Create")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    done
                }
            }
            .onChange(of: vm.state) { formState in
                if formState == .successful {
                    dismiss()
                    successfulAction()
                }
                
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                
            }
            .overlay {
                if vm.state == .submitting {
                    ProgressView()
                }
            }
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView{
            
        }
    }
}


private extension CreateView {
    
    
    var done : some View {
        Button("Done") {
            dismiss() 
        }
    }
    
    @ViewBuilder
    var firstName : some View {
        TextField("First Name", text: $vm.person.firstName)
            .focused($focusedField, equals: .firstName)
    }
    
    @ViewBuilder
    var lastName : some View {
        TextField("Last Name", text: $vm.person.lastName)
            .focused($focusedField, equals: .lastName)
    }
    
    @ViewBuilder
    var job : some View {
        TextField("Job", text: $vm.person.job)
            .focused($focusedField, equals: .job)
    }
    
    @ViewBuilder
    var submit : some View {
        Button("Submit") {
            focusedField = nil
            Task {
                await vm.create()
            }
        }
    }
    
    
}


extension CreateView {
    enum Field : Hashable {
        case firstName
        case lastName
        case job
    }
}
