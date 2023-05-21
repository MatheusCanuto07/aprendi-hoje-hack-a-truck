import Foundation

struct Principalturma: Decodable{
    var _id: String?
    var _rev: String?
    var materiaTurma: String?
    var professorTurma: String? //idProf
    var tarefas: [Tarefas]?
    var alunosTurma: [String]?
}

struct Tarefas :  Decodable{
    var idTarefa: Int?
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
    public init(){
        self.idTurma = ""
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
class Turmas: ObservableObject {
    @Published var turmas : [Principalturma] = []
    
    
    func fetch(){
        guard let url = URL(string: "http://192.168.131.10:1880/aprendihoje/turma/all") else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
            [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let parsed = try JSONDecoder().decode([Principalturma].self, from: data)
                
                DispatchQueue.main.async {
                    self?.turmas = parsed
                }
            } catch{
                print(error)
            }
        }
        task.resume()
    }
}

