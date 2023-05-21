import Foundation

struct PrincipalProfessor : Decodable{
    var _id: String?
    var _rev: String?
    var idProf: Int?
    var nome: String?
    var avatarURL: String?
}

class Professor: ObservableObject{
    @Published var professor : PrincipalProfessor = PrincipalProfessor()
    var idProf: String
    
    public init(idProf: String) {
        self.idProf = idProf
    }

    
    func fetch(){
        guard let url = URL(string: "http://192.168.131.10:1880/aprendihoje/professor?id=\(idProf)") else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
            [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let parsed = try JSONDecoder().decode(PrincipalProfessor.self, from: data)
                
                DispatchQueue.main.async {
                    self?.professor = parsed
                }
            } catch{
                print(error)
            }
        }
        task.resume()
    }
}
