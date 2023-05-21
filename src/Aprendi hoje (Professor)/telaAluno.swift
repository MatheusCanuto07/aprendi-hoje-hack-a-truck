//
//  telaAluno.swift
//  Aprendi hoje
//
//  Created by Student19 on 11/05/23.
//

import SwiftUI

struct telaAluno: View {
    var alunoAtual: Principal
    var body: some View {
        AsyncImage(url:URL(string: alunoAtual.avatarURL ?? "")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:260, height: 160)
                .clipShape(Circle())
            //Funcao a ser implementada
                .overlay(Circle().stroke(alunoAtual.mediaAluno! >= 80 ?  Color.green : alunoAtual.mediaAluno! >= 60 && alunoAtual.mediaAluno! < 80 ? Color.yellow : Color.red ,lineWidth: 3))
        } placeholder: {
            // Exibe uma imagem de placeholder enquanto a imagem está sendo carregada
            ProgressView()
        }
        Text("\(alunoAtual.nomeAluno ?? "Carregando")")
        Text("Entregou \((alunoAtual.entregasAluno ?? []).count) atividades")
        Text("O aluno participa de \((alunoAtual.turmasAluno ?? [] ).count) turmas")
        Text("Media do aluno: \(alunoAtual.mediaAluno ?? 0)")
        
    }
    
}

struct telaAluno_Previews: PreviewProvider {
    static var previews: some View {
         var fake = Principal(_id: "",_rev: "", idAluno: -1,  nomeAluno: "Carregando", mediaAluno: -1, entregasAluno:  [  ], notificacoesAluno: [])
        telaAluno(alunoAtual: fake)
    }
}
