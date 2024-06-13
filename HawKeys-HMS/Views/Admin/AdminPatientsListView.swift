import SwiftUI

struct AdminPatientsListView: View {
    @StateObject private var networkManager = NetworkManagerOfAdmin()

    var body: some View {
        NavigationView {
            VStack {
                List(networkManager.patients) { patient in
                    VStack(alignment: .leading) {
                       // Text("\(patient.user.firstName) \(patient.user.lastName)")
                          //  .font(.headline)
                        Text("ID: \(patient.id)")
                        
                            Text("Blood Group: \(patient.bloodGroup)")
                        
                        
                        Text("Weight: \(patient.weight) kg")
                        
                       
                        Text("Height: \(patient.height) cm")
                        
                        Text("Symptom: \(patient.symptom)")
                        Text("Address: \(patient.address)")
                    }
                    .padding(.vertical, 5)
                }
            }
            .navigationTitle("Patients")
        }
        .onAppear {
            networkManager.getAllPatients()
        }
    }
}

struct AdminPatientsListView_Previews: PreviewProvider {
    static var previews: some View {
        AdminPatientsListView()
    }
}

