//=============================================
//Assets turma

import Foundation

struct Principalturma: Decodable{
    var _id: String?
    var _rev: String?
    var materiaTurma: String?
    var professorTurma: Int?
    var tarefas: [Tarefas]?
    var alunosTurma: [String]?
}

struct Tarefas :  Decodable{
    var id: Int?
    var notaMax: Int?
    var descricaoTarefa: String?
    var dataEntrega: String?
}

class Turma: ObservableObject {
    @Published var turma : Principalturma = Principalturma()
    var idTurma: String
    
    public init(idTurma: String) {
        self.idTurma = idTurma
    }
    
    
    func fetch(){
        guard let url = URL(string: "http://192.168.131.10:1880/aprendihoje/turma?id=\(idTurma)") else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
            [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let parsed = try JSONDecoder().decode(Principalturma.self, from: data)
                
                DispatchQueue.main.async {
                    self?.turma = parsed
                }
            } catch{
                print(error)
            }
        }
        task.resume()
    }
}


//==============================================

//Assests alunos



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
    var entregasAluno: [Entregas]?
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
