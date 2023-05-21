//
//  Aluno.swift
//  StrcutsAprendiHJ
//
//  Created by Student08 on 08/05/23.
//

import Foundation

struct Entregas : Decodable {
    var idEntrega: Int?
    var tarefaEntrega: Int?
    var notaEntrega: Float?
}

struct Notificacoes : Decodable {
    var idNotificacao: Int?
    var descricacaoNotificacao: String?
    var origemNotificacao: Int?  // X - id propriamente dito, Y - numero de turma, Z - turno da turma sendo 0 manhã e 1 tarde
}

struct Principal : Decodable {
    var _id: String?
    var _rev: String?
    var idAluno: Int?
    var nomeAluno: String?
    var mediaAluno: Int?
    var avatarURL: String?
    var entregasAluno   : [Entregas]?
    var notificacoesAluno: [Notificacoes]?
    var turmasAluno: [String]?
}
 
class Aluno: ObservableObject {
    @Published var alunos : Principal = Principal()
    var idAluno: String
    
    public init(idAluno: String) {
        self.idAluno = idAluno
    }
    
    func fetch(){
        guard let url = URL(string: "http://192.168.131.10:1880/aprendihoje/aluno?id=\(idAluno)") else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
            [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let parsed = try JSONDecoder().decode(Principal.self, from: data)
                
                DispatchQueue.main.async {
                    self?.alunos = parsed
                }
            } catch{
                print(error)
            }
        }
        task.resume()
    }
}
class Alunos: ObservableObject {
    @Published var alunos: [Principal] = []
    
    func fetch(){
        guard let url = URL(string: "http://192.168.131.10:1880/aprendihoje/aluno/all") else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
            [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let parsed = try JSONDecoder().decode([Principal].self, from: data)
                
                DispatchQueue.main.async {
                    self?.alunos = parsed
                }
            } catch{
                print(error)
            }
        }
        task.resume()
    }
}
