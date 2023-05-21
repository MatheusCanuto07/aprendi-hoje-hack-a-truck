//
//  pagTurma.swift
//  Aprendi hoje
//
//  Created by Student19 on 27/04/23.
//

import SwiftUI

struct pagTurma: View {
    @StateObject var alunos = Alunos()
    @State private var nota = 40
    @State private var exibirSheet = false
    var turmaAtual: Principalturma
    var body: some View {
        //Paleta de cores
        //#332c26 - Preto
        //#db1414 - Vermelho
        //#e8591c - Laranja
        //#7fb8b0 - Azul escola
        //#c5e65c - Verde claro
//        Text(turmaAtual.materiaTurma!)
        VStack{
            HStack {
                Text(turmaAtual.materiaTurma!)
                    .font(.title)
            }
            ScrollView(.horizontal){
                HStack{
                    ForEach(alunos.alunos, id: \._id){
                        alunoAtual in
                        ForEach(alunoAtual.turmasAluno!, id: \.self){
                            turmaA in
                            if(turmaA == turmaAtual._id){
                                NavigationLink(destination: telaAluno(alunoAtual: alunoAtual)){
                                    VStack{
                                        AsyncImage(url:URL(string: alunoAtual.avatarURL ?? "")) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width:160, height: 100)
                                                .clipShape(Circle())
                                            //Funcao a ser implementada
                                                .overlay(Circle().stroke(alunoAtual.mediaAluno! >= 80 ?  Color.green : alunoAtual.mediaAluno! >= 60 && alunoAtual.mediaAluno! < 80 ? Color.yellow : Color.red ,lineWidth: 3))
                                        } placeholder: {
                                            // Exibe uma imagem de placeholder enquanto a imagem está sendo carregada
                                            ProgressView()
                                        }
                                    }.padding(-20)
                                }
                            }
                        }

                    }
                }.frame(width: .infinity, height:115)
            }
            HStack{
                Text("Tarefas")
                    .foregroundColor(.black)
                    .frame(width: 3000, height: 40)
                    .background(Color("cor"))
                //            Text(turmaAtual.materiaTurma!
            }
            ScrollView{
                VStack{
                    ForEach(turmaAtual.tarefas!, id: \.idTarefa){
                        tarefaAtual in
                        
                        HStack{
                            AsyncImage(url: URL(string: "https://www.csvp.com.br/wp-content/uploads/2018/05/icone-prova.png")) { image in
                                image.resizable()
                                    .frame(width: 150, height: 100)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            } placeholder: {
                                //O que acontece enquanto a imagem é carregada
                                ProgressView()
                            }
                            Spacer()
                            VStack{
                                Text("\(tarefaAtual.descricaoTarefa!)")
                                Text("Valor: \(tarefaAtual.notaMax!)")
                                // Text("\(tarefaAtual.descricaoTarefa!)")
                                Text("\(tarefaAtual.dataEntrega!)")
                            }
                        }
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, maxHeight: 150)
                        .background(Color("cor"))
                        Spacer()
                    }
                }
            }
            Spacer()
        }.onAppear(perform: alunos.fetch)
            
//            Text(turmaAtual.materiaTurma!)
            
        }
    }


struct pagTurma_Previews: PreviewProvider {
    static var previews: some View {
        let turmasHolder =
        Principalturma(_id: "",_rev: "", materiaTurma: "Carregando", professorTurma: "1448b1f87e2e927779c26ace18c872b1", tarefas: [], alunosTurma: [] )
        
        pagTurma(turmaAtual: turmasHolder)
    }
}
