//
//  ContentView.swift
//  Notificacao
//
//  Created by Student06 on 09/05/23.
//

import SwiftUI

struct ContentView: View {
    //@State private var users = ["Matemática", "Português", "Historia"]
    @State private var users = [
        Notificacao(descricaoNotificacao: "Matemática", not: "Teste", origemNotificacao: 02),
        Notificacao(descricaoNotificacao: "Português", not: "teste2", origemNotificacao: 01),
        Notificacao(descricaoNotificacao: "Inglês", not: "Teste", origemNotificacao: 03)
    ]
    
    var body: some View {
        VStack(alignment:.leading) {
            Text("Notificações")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .center)
                .fontWeight(.medium)
                .foregroundColor(Color.black
                )
            NavigationStack {
                        List {
                            ForEach(users, id: \.self) { user in
                                VStack(alignment: .leading){
                                    Text(user.descricaoNotificacao)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.yellow)
                                        .opacity(0.8)
                                    Text(user.not)
                                }
                            }
                            .onDelete(perform: delete)
                        }
                        .toolbar {
                            EditButton()
                        }.foregroundColor(.black)
            }
            
            
            }
        }
        func delete(at offsets: IndexSet) {
            users.remove(atOffsets: offsets)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
