//
//  ContentView.swift
//  Aprendi hoje
//
//  Created by Student19 on 27/04/23.
//

import SwiftUI

struct ContentView: View {
    //Opcao que ja vem selecionada
    @State private var turnoPadrao = "Manha"
    @State private var profAtual = "1448b1f87e2e927779c26ace185694cd"
    let opcoesTurno = ["Manha", "Tarde"]
    @StateObject var professor = Professor(idProf: "1448b1f87e2e927779c26ace185694cd")
    @StateObject var turmas = Turmas()
    @State var profHolder = PrincipalProfessor(_id: "",_rev: "",idProf: 0, nome: "Carregando", avatarURL: "")
    @State var turmasHolder = [
    Principalturma(_id: "",_rev: "", materiaTurma: "Carregando", professorTurma: "1448b1f87e2e927779c26ace18c872b1", tarefas: [], alunosTurma: [] )
    ]
    var body: some View {
        NavigationStack{
            VStack{
                VStack {
                    AsyncImage(url:URL(string: professor.professor.avatarURL ??  " ")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:150, height: 85)
                            .clipShape(Circle())
                    } placeholder: {
                        // Exibe uma imagem de placeholder enquanto a imagem está sendo carregada
                        ProgressView()
                    }
                    Text("Bem vindo, professor(a) \(professor.professor.nome ?? profHolder.nome!)")
                }
                HStack{
                    Picker(selection: $turnoPadrao, label: Text("hh")) {
                        ForEach(opcoesTurno, id: \.self){
                            option in Text(option)
                        }
                    }
                    .pickerStyle(.segmented)
                }
//                HStack{
//                    Picker(selection: $escolaPadrao, label: Text("")){
//                        ForEach(opcoesEscola, id: \.self){
//                            option in Text(option)
//                        }
//                    }
//                    .pickerStyle(.segmented)
//                }
                    VStack{
                        Text("Turmas")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .frame(width: 380, height: 40)
                            .foregroundColor(.black)
                            .background(Color("cor"))
                        ForEach(turmas.turmas ?? turmasHolder, id: \._id){ atual in
                            if(atual.professorTurma! == "1448b1f87e2e927779c26ace185694cd"){
                                NavigationLink(destination: pagTurma(turmaAtual: atual)){
                                    HStack{
                                        Text("\(atual.materiaTurma!)")
                                            .foregroundColor(.black)
                                            .font(.title2)
                                            .frame(width: 380, height: 150)
                                            .background(Color("cor"))
                                        //.cornerRadius(30)
                                    }
                                }
                            }
                        }
                    }
                Spacer()
            }
        }.onAppear(perform: professor.fetch)
            .onAppear(perform: turmas.fetch)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
