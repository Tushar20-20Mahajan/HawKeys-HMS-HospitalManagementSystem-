//
//  Appointment.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//


import Foundation
import Combine

struct PatientAppointmentData: Codable {
    var _id: String
    var firstName: String
    var lastName: String
    var age: Int
    var gender: String
    
    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        case firstName
        case lastName
        case age
        case gender
    }
}

struct DoctorAppointmentData: Codable {
    var id: String
    var firstName: String
    var lastName: String
    var specialization: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstName
        case lastName
        case specialization
    }
}




struct PatientAppointment: Codable, Identifiable {
    enum TimeSlot: String, Codable {
        case morning = "Morning"
        case afternoon = "Afternoon"
        case evening = "Evening"
    }
    
    var id: String
    var patient: String
    var doctor: DoctorAppointmentData
    var date: Date
    var timeSlot: TimeSlot
    var symptom: String
    var status: String
    var prescription: String?
    var tests: [Test]?
    var createdAt: Date
    var updatedAt: Date
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case patient
        case doctor
        case date
        case timeSlot
        case symptom
        case status
        case prescription
        case tests
        case createdAt
        case updatedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.patient = try container.decode(String.self, forKey: .patient)
        self.doctor = try container.decode(DoctorAppointmentData.self, forKey: .doctor)
        self.date = try container.decode(Date.self, forKey: .date)
        self.timeSlot = try container.decode(PatientAppointment.TimeSlot.self, forKey: .timeSlot)
        self.symptom = try container.decode(String.self, forKey: .symptom)
        self.status = try container.decode(String.self, forKey: .status)
        self.prescription = try container.decodeIfPresent(String.self, forKey: .prescription)
        self.tests = try container.decodeIfPresent([Test].self, forKey: .tests)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
    }
}

struct Test: Codable, Hashable {
    
    var testName: String

    var result: String
    
    
    private enum CodingKeys: String, CodingKey {
        case testName
        case result
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Test.CodingKeys> = try decoder.container(keyedBy: Test.CodingKeys.self)
        self.testName = try container.decodeIfPresent(String.self, forKey: Test.CodingKeys.testName) ?? ""
        self.result = try container.decodeIfPresent(String.self, forKey: Test.CodingKeys.result) ?? ""
    }
    
}

struct DoctorAppointment: Codable, Identifiable {
    enum TimeSlot: String, Codable {
        case morning = "Morning"
        case afternoon = "Afternoon"
        case evening = "Evening"
    }
    
    
    
    var id: String
    var patient: PatientAppointmentData
    var symptom: String?
    var doctor: String
    var date: Date
    var timeSlot: TimeSlot
    var status: String
    var prescription: String
    var tests: [Test]?
    var createdAt: Date
    var updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case patient
        case symptom
        case doctor
        case date
        case timeSlot
        case status
        case tests
        case prescription
        case createdAt
        case updatedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.patient = try container.decode(PatientAppointmentData.self, forKey: .patient)
        self.symptom = try container.decodeIfPresent(String.self, forKey: .symptom)
        self.doctor = try container.decode(String.self, forKey: .doctor)
        self.date = try container.decode(Date.self, forKey: .date)
        self.timeSlot = try container.decode(DoctorAppointment.TimeSlot.self, forKey: .timeSlot)
        self.status = try container.decode(String.self, forKey: .status)
        self.tests = try container.decodeIfPresent([Test].self, forKey: .tests)
        self.prescription = try container.decode(String.self, forKey: .prescription)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
    }
}

//let patientAppointmentsSample = [
//    PatientAppointment(_id: "#12345", patient: "Rajiv", doctor: DoctorAppointmentData(_id: "#123456", firstName: "Rajiv", lastName: "Kumar", specialization: "Cardiology"), date: Date(), timeSlot:PatientAppointment.TimeSlot.morning, createdAt: Date(), updatedAt: Date())]

struct PatientAppointmentResponse: Codable {
    let success: Bool
    let data: [PatientAppointment]
}

struct DoctorAppointmentResponse: Codable {
    var success: Bool
    var data: [DoctorAppointment]
}


//import Foundation

//func fetchPatientAppointments(token: String) {
//    print("Entered Fetch function")
//    let urlString = "http://localhost:4000/patient/appointments"
//    guard let url = URL(string: urlString) else { return }
//
//    var request = URLRequest(url: url)
//    request.httpMethod = "GET"
//    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//
//    print("Entered 2")
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//        if let error = error {
//            print("Error: \(error)")
//            return
//        }
//
//        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//            print("Server error")
//            return
//        }
//
//        guard let data = data else {
//            print("No data received")
//            return
//        }
//
//        do {
//            let decoder = JSONDecoder()
//
//            // Custom Date Decoding Strategy
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//            decoder.dateDecodingStrategy = .formatted(dateFormatter)
//
//            let appointmentResponse = try decoder.decode(PatientAppointmentResponse.self, from: data)
//            print("Success: \(appointmentResponse.success)")
//            for appointment in appointmentResponse.data {
//                print("Appointment ID: \(appointment._id), Patient ID: \(appointment.patient), Doctor: \(appointment.doctor.firstName) \(appointment.doctor.lastName), Date: \(appointment.date), Time Slot: \(appointment.timeSlot.rawValue)")
//            }
//        } catch {
//            print("Error decoding JSON: \(error)")
//        }
//    }
//
//    task.resume()
//}



func fetchDoctorAppointments(token: String) {
    print("Entered Fetch function")
    let urlString = "http://localhost:4000/doctor/appointments"
    guard let url = URL(string: urlString) else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    print("Entered 2")
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error: \(error)")
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            print("Server error")
            return
        }
        
        guard let data = data else {
            print("No data received")
            return
        }
        
        do {
            let decoder = JSONDecoder()
            
            // Custom Date Decoding Strategy
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            let appointmentResponse = try decoder.decode(DoctorAppointmentResponse.self, from: data)
            print("Success: \(appointmentResponse.success)")
            for appointment in appointmentResponse.data {
                print("Appointment ID: \(appointment.id), Patient: \(appointment.patient.firstName) \(appointment.patient.lastName), Doctor ID: \(appointment.doctor), Date: \(appointment.date), Time Slot: \(appointment.timeSlot.rawValue)")
                if let symptom = appointment.symptom {
                    print("Symptom: \(symptom)")
                }
            }
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
    task.resume()
}
