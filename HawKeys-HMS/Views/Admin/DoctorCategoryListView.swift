import SwiftUI

struct DoctorCategoryListView: View {
    @State private var searchTitle: String = ""
    @State private var doctorsBySpecialization: [String: [Doctor]] = [:]
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    // Categories Title
                    HStack {
                        Text("Categories")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    // List of Categories
                    ForEach(doctorsBySpecialization.keys.sorted(), id: \.self) { specialization in
                        Section {
                            NavigationLink(destination: DoctorsListView(doctors: doctorsBySpecialization[specialization] ?? [])) {
                                VStack(spacing: 16) {
                                    CategoryRow(category: Category2(imageName: specialization, name: specialization, description: ""))
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle("Doctors")
            .searchable(text: $searchTitle)
            .onAppear {
                fetchDoctors()
            }
        }
    }
    
    func fetchDoctors() {
            let doctorCategory = DoctorAPI()
            doctorCategory.getDoctors { result in
                switch result {
                case .success(let doctorResponse):
                    let approvedDoctors = doctorResponse.data.filter { $0.approved }
                    let groupedDoctors = Dictionary(grouping: approvedDoctors, by: { $0.specialization })
                    DispatchQueue.main.async {
                        doctorsBySpecialization = groupedDoctors
                    }
                case .failure(let error):
                    print("Error fetching doctors: \(error.localizedDescription)")
                }
            }
        }
}

struct CategoryRow: View {
    var category: Category2
    
    var body: some View {
        HStack {
            Image(category.imageName)
                .resizable()
                .frame(width: 40, height: 40)
                .padding(.trailing, 8)
            
            VStack(alignment: .leading) {
                Text(category.name)
                    .font(.headline)
                Text(category.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

// Data Model
struct Category2: Identifiable {
    var id = UUID()
    var imageName: String
    var name: String
    var description: String
}
let sampleCategories = [
    Category2(imageName: "heart", name: "Cardiologist", description: "Heart and Blood vessels"),
    Category2(imageName: "rash", name: "Dermatology", description: "Skin, hair, and nails."),
    Category2(imageName: "heel", name: "Anesthesiology", description: "Pain relief"),
    Category2(imageName: "stomach", name: "Gastroenterology", description: "Digestive system disorders"),
    Category2(imageName: "brain", name: "Neurology", description: "Brain and neurone"),
    Category2(imageName: "uterus", name: "Gynecology", description: "Female reproductive system"),
    Category2(imageName: "read", name: "Ophthalmology", description: "Eyes")
]




struct DoctorsListView: View {
    var doctors: [Doctor]
    
    var body: some View {
        List(doctors) { doctor in
            VStack(alignment: .leading) {
                Text("\(doctor.firstName) \(doctor.lastName)")
                    .font(.headline)
                Text(doctor.specialization)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("Experience: \(doctor.experience)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("Fees: \(doctor.fees)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.vertical)
        }
        .navigationTitle("Doctors")
    }
}

#Preview {
    DoctorCategoryListView()
}
