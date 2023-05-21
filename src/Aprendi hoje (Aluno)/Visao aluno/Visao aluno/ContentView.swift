//
//  ContentView.swift
//  TelaAluno
//
//  Created by Student17 on 28/04/23.
//



//exclamationmark.triangle



import SwiftUI


struct ContentView: View {
   
    @State private var showingCredits = false

    @StateObject var objeto = Aluno(idAluno: "384d08de92842b1d5be4d7359f82f3a6")


    @State var teste = Principal(_id: "",_rev: "", idAluno: -1,  nomeAluno: "Carregando", mediaAluno: -1, entregasAluno:  [  ], notificacoesAluno: [])
    
    @State var teste2 = Principalturma(_id: "", _rev:"", materiaTurma: "", professorTurma: 0, tarefas: [ Tarefas(id: 0,notaMax: 0,descricaoTarefa: "", dataEntrega: "")], alunosTurma: [])
    
    
    var body: some View {
        
        VStack {
            Text("\(objeto.alunos.nomeAluno ?? "")")
                .fontWeight(.bold)
                .font(.title)
                .fontWeight(.medium)
            Spacer()
        
            if(objeto.alunos.mediaAluno ?? teste.mediaAluno! >= 80){
            Image("smileysBom")
                Spacer()
            Text("Bom")
                .font(.title)
                .fontWeight(.medium)
            Text("O aluno está se deempenhando bem")
                .font(.headline)
                .fontWeight(.medium)
            }
            else if (objeto.alunos.mediaAluno ?? teste.mediaAluno! >= 60 && objeto.alunos.mediaAluno ?? teste.mediaAluno! < 80)
            {
                Image("smileyIntermed")
                Spacer()
                Text("Intermediário")
                    .font(.title)
                    .fontWeight(.medium)
                Text("O aluno está com desempenho intermediário")
                    .font(.headline)
                    .fontWeight(.medium)
            }
            else{
                Image("smileys")
                Spacer()
                Text("Preocupante")
                    .font(.title)
                    .fontWeight(.medium)
                Text("O aluno está abaixo da média")
                    .font(.headline)
                    .fontWeight(.medium)
            }
            Spacer()
            HStack{
                Text("O aluno entregou")
                    .font(.headline)
                    .fontWeight(.medium)
                Text("\((objeto.alunos.entregasAluno ?? teste.entregasAluno!).count)")
                    .font(.headline)
                
                    .foregroundColor((objeto.alunos.entregasAluno ?? teste.entregasAluno!).count > 6 ? Color.green : Color.red)
                    .fontWeight(.medium)
                Text("/ 10")
                    .font(.headline)
                    .foregroundColor((objeto.alunos.entregasAluno ?? teste.entregasAluno!).count > 6 ? Color.green : Color.red)
                    .fontWeight(.medium)
            }
            Text("trabalhos essa semana")
                .font(.headline)
                .fontWeight(.medium)
            Spacer()
            ZStack{
            Circle().stroke(.black.opacity(0.3),style: StrokeStyle(lineWidth: 20)).frame(height: 100)
            
            Circle()
                    .trim(from: 0,to: CGFloat((Double(objeto.alunos.mediaAluno ?? teste.mediaAluno!)/100.0)))
                .stroke(AngularGradient(gradient:  Gradient(colors: [.red,.yellow,.green,.green]), center: .center, startAngle: .degrees(0), endAngle: .degrees(360)),style: StrokeStyle(lineWidth: 20))
                .rotationEffect(.init(degrees: -90))
                .frame(height: 100)
                
                Text("\(objeto.alunos.mediaAluno ?? teste.mediaAluno!)%")
                
            }
            Spacer()
            Button("Detalhes +") {
                        showingCredits.toggle()
                    }
            
                    .sheet(isPresented: $showingCredits) {
                        VStack{
                        
                            if((objeto.alunos.entregasAluno ?? teste.entregasAluno!).count < 5){
                                Image(systemName: "exclamationmark.triangle")
                                    .font(.system(size: 180, weight: .light))
                                    .foregroundColor(.red)
                                Spacer()
                                Text("Requer atenção do responsável, poucas entreagas de trabalho ou notas preocuopantes")
                                    .font(.title3)
                                    .multilineTextAlignment(.center)
                                
                            }
                            else{
                                Image(systemName: "checkmark.circle")
                                    .font(.system(size: 180, weight: .light))
                                    .foregroundColor(.green)
                                Spacer()
                                Text("As entregas estão em dia")
                                }
                            HStack{
                                Text("Entregas")
                                    .padding(.leading)
                                Spacer()
                                Text("\((objeto.alunos.entregasAluno ?? teste.entregasAluno!).count)")
                                    .padding()
                            }
                            .border(.black)
                            .background(.white)
                           
                            List {
                                ForEach(objeto.alunos.entregasAluno ?? teste.entregasAluno!, id: \.idEntrega) { x in
                                    
                                    if(x.notaEntrega == 0){
                                        VStack(alignment: .trailing){
                                            HStack{
                                                
                                                Image(systemName: "book")
                                                    .padding(.top, -11.0)
                                                    .font(.system(size: 25, weight: .light))
                                                   //.frame(width: 50, height: 40)
                                                    //.foregroundColor(.red)
                                                Spacer()
                                                VStack(alignment: .center){
                                                    Text("Entrega faltante")
                                                    
                                                    
                                                    Text("\(teste2.tarefas![0].descricaoTarefa!)")
                                                    
                                                }.foregroundColor(.red)
                                                Spacer()
                                                Text("0")
                                                    .padding(.top, -11.0)
                                            }.foregroundColor(.red)
                                        }
                                        .padding(.top, 14.0)
                                    }
                                }
                            }
                        Spacer()
                        }
                            
                    }
                
        }
        .onAppear(perform: objeto.fetch)
        
        .padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
