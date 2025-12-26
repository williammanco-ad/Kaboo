//
//  HowToPlayView.swift
//  Kaboo
//
//  Created by Kaboo Team
//

import SwiftUI

struct HowToPlayView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Regole")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.green)
                        
                        Text("Lo scopo di questo gioco di carte è quello di fare meno punti di qualsiasi avversario.")
                            .font(.body)
                            .padding(.bottom, 10)
                    }
                    
                    Divider()
                    
                    // Setup section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Preparazione")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Vengono distribuite 4 carte a ciascun giocatore, posizionate coperte di fronte a lui. Al segnale del mazziere, i giocatori guardano una sola volta le carte della fila in basso per memorizzarle.")
                            .font(.body)
                    }
                    
                    Divider()
                    
                    // Gameplay section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Come si gioca")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Il mazzo viene posizionato al centro e inizia il giro di pesca. L'obiettivo è sostituire le proprie carte con altre di punteggio inferiore.")
                            .font(.body)
                    }
                    
                    Divider()
                    
                    // Quick discard section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Scarto rapido")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Se un giocatore riconosce di avere una carta uguale a quella appena scartata da un altro, può cercare di scartarla rapidamente senza sostituzione. Solo il più veloce avrà la mossa accettata, fino a poter eliminare tutte le carte.")
                            .font(.body)
                            .padding(.bottom, 5)
                        
                        Text("Se si conosce una carta di un avversario, è possibile scartarla allo stesso modo e sostituirla con una propria, potenzialmente aumentando il suo punteggio.")
                            .font(.body)
                    }
                    
                    Divider()
                    
                    // Kaboo section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Kaboo")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Se si crede di avere il punteggio più basso, si può dire \"Kaboo\". A fine giro, se il punteggio è davvero il più basso si vince; altrimenti si perde e si riceve il punteggio più alto del tavolo fino a quel momento +1.")
                            .font(.body)
                            .foregroundColor(.red)
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.green.opacity(0.1), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
            .navigationTitle("How To Play")
        }
    }
}

#Preview {
    HowToPlayView()
}
