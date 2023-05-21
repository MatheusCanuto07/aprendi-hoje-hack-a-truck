//
//  materias.swift
//  Aprendi hoje
//
//  Created by Student19 on 28/04/23.
//

import SwiftUI

struct materias: View {
    var body: some View {
        VStack{
            HStack{
                Text("Materias")
                    .font(.title)
            }
            HStack{
                AsyncImage(url:URL(string: "https://media.istockphoto.com/id/1181232702/pt/vetorial/portuguese.jpg?s=612x612&w=0&k=20&c=-fN-MKLRa1xoTxHaPboWe-CwibCrACSJPif-vPC7ipg=")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:85, height: 85)
                        .clipShape(Circle())
                } placeholder: {
                    // Exibe uma imagem de placeholder enquanto a imagem está sendo carregada
                    ProgressView()
                }
                VStack{
                    Text("Portugues")
                    Text("07/10")
                }
                Image(systemName: "arrowshape.right.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.blue)
            }
            
            .frame(width: 380, height: 100)
            .background(Color(.gray))
            Spacer()
            VStack{
                HStack{
                    Text("Entregas")
                        .padding(.leading)
                    Spacer()
                    Text("2/7")
                        .padding()
                }
                .border(.black)
                .background(.white)
                HStack(){
                    AsyncImage(url: URL(string: "https://cdn-icons-png.flaticon.com/512/5999/5999928.png")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 40)
                    .background(.red)
                    Spacer()
                    VStack(alignment: .leading){
                        Text("Entrega faltante")
                        Text("Seminario")
                    }
                    Spacer()
                    Text("0")
                }
                .frame(width: 320)
            }
            
            .background(.gray)
            .font(.system(size: 20))
        }
    }
}

struct materias_Previews: PreviewProvider {
    static var previews: some View {
        materias()
    }
}
