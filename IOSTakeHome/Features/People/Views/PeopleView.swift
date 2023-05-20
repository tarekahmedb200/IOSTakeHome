//
//  PeopleView.swift
//  IOSTakeHome
//
//  Created by lapshop on 5/12/23.
//

import SwiftUI

struct PeopleView: View {
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    @StateObject private var vm = PeopleViewModel()
    @State private var users : [User] = []
    @State private var shouldShowCreate = false
    @State private var shouldShowSuccess = false
    @State private var hasAppeared = false
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                background
                
                if vm.isLoading {
                    ProgressView()
                }else {
                    ScrollView {
                        LazyVGrid(columns: columns,spacing: 16) {
                            ForEach(vm.users,id:\.id) { user in
                                
                                NavigationLink {
                                    DetailView(userId: user.id)
                                } label: {
                                    
                                    PersonItemView(user: user)
                                        .task {
                                            if vm.hasReachedEnd(of: user) {
                                                await vm.fetchNextSetofUsers()
                                            }
                                        }
                                }
                                
                                
                            }
                        }
                        .padding()
                    }
                }
                
                
            }
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    create
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        Task {
                            await vm.fetchUsers()
                        }
                    } label: {
                        Symbols.refresh
                    }
                }
                
            }
            .task {
                
                if !hasAppeared {
                    await vm.fetchUsers()
                    hasAppeared = true 
                }
            }
            .sheet(isPresented: $shouldShowCreate) {
                CreateView {
                    withAnimation(.spring().delay(0.25)) {
                        self.shouldShowSuccess.toggle()
                    }
                }
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry") {
                    Task {
                        await vm.fetchUsers()
                    }
                }
            }
            .overlay {
                if shouldShowSuccess {
                    CheckmarkPopoverView()
                        .onAppear {
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                
                                withAnimation(.spring()) {
                                    self.shouldShowSuccess.toggle()
                                }
                            }
                        }
                }
            }
            
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}


private extension PeopleView {
    
    var background : some View {
        Theme.backgorund
            .ignoresSafeArea(edges: .top)
    }
    
    
    
    
    var create : some View {
        Button {
            shouldShowCreate.toggle()
        } label: {
            Symbols.plus
                .font(
                    .system(.headline,design: .rounded)
                    .bold()
                )
        }.disabled(vm.isLoading)
    }
}


