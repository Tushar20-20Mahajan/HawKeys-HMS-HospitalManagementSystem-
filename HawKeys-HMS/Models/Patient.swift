

import Foundation
import SwiftUI
import Foundation

struct Patient: Codable, Identifiable {
    var id: String  // Make sure id is a variable (var), as Identifiable requires a mutable id
    
    let user: User?
    let bloodGroup: String?
    let weight: Int?
    let height: Int?
    let symptom: String?
    let address: String?
    
    // CodingKeys enum for decoding
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case user
        case bloodGroup
        case weight
        case height
        case symptom
        case address
    }
    
    // Initializer for decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.user = try container.decodeIfPresent(User.self, forKey: .user)
        self.bloodGroup = try container.decodeIfPresent(String.self, forKey: .bloodGroup)
        self.weight = try container.decodeIfPresent(Int.self, forKey: .weight)
        self.height = try container.decodeIfPresent(Int.self, forKey: .height)
        self.symptom = try container.decodeIfPresent(String.self, forKey: .symptom)
        self.address = try container.decodeIfPresent(String.self, forKey: .address)
    }
}



// MARK: - PatientResponse Model

struct PatientResponse: Codable {
    let success: Bool
    let data: [User]
}





struct Category: Identifiable{
    let id: UUID
    let name: String
    let imageName: String
}

let categories = [
    Category(id: UUID(), name: "Cardiologist", imageName: "heart.fill"),
    Category(id: UUID(), name: "Dermatologist", imageName: "face.smiling.fill"),
    Category(id: UUID(), name: "Neurologist", imageName: "brain.head.profile"),
    Category(id: UUID(), name: "Pediatrician", imageName: "person.3.fill"),
    Category(id: UUID(), name: "Orthopedic Surgeon", imageName: "figure.walk"),
    Category(id: UUID(), name: "Psychiatrist", imageName: "person.crop.circle.badge.exclamationmark"),
    Category(id: UUID(), name: "Ophthalmologist", imageName: "eye.fill"),
    Category(id: UUID(), name: "Radiologist", imageName: "waveform.path.ecg"),
    Category(id: UUID(), name: "General Practitioner", imageName: "stethoscope"),
    Category(id: UUID(), name: "Endocrinologist", imageName: "drop.fill"),
    Category(id: UUID(), name: "Gastroenterologist", imageName: "bandage.fill"),
    Category(id: UUID(), name: "Oncologist", imageName: "cross.fill"),
    Category(id: UUID(), name: "Pulmonologist", imageName: "lungs.fill")
]




struct DoctorFormView: View {
    @State private var name: String = ""
    @State private var selectedCategoryID: UUID? = nil
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            
            Picker("Category", selection: $selectedCategoryID) {
                ForEach(categories) { category in
                    Text(category.name).tag(category.id as UUID?)
                }
            }
            
            Button(action: {
                
            }) {
                Text("Save Doctor")
            }
        }
    }
   
}
