import Foundation

struct ScheduleSlot: Codable {
    var timeSlot: String
    var startTime: String
    var endTime: String
    var id: String
    
    enum CodingKeys: String, CodingKey {
        case timeSlot
        case startTime
        case endTime
        case id = "_id"
    }
}

let sampleScheduleSlot = ScheduleSlot(
    timeSlot: "Morning",
    startTime: "09:00",
    endTime: "11:00",
    id: "slot1"
)

struct Schedule: Codable {
    var date: Date
    var slots: [ScheduleSlot]
    var id: String
    
    enum CodingKeys: String, CodingKey {
        case date
        case slots
        case id = "_id"
    }
}

let sampleSchedule = Schedule(
    date: Date(),
    slots: [sampleScheduleSlot],
    id: "schedule1"
)

struct Doctor: Identifiable, Codable {
    var id: String
    var accountType: String
    var firstName: String
    var lastName: String
    var age: Int
    var gender: String
    var phoneNumber: Int
    var approved: Bool
    var email: String
    var password: String
    var fees: String
    var about: String
    var specialization: String
    var experience: String
    var qualification: String
    let labTestAppointments: [TestDetails]?
    var createdAt: Date
    var updatedAt: Date
    var schedule: [Schedule]?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case accountType
        case firstName
        case lastName
        case age
        case gender
        case phoneNumber
        case approved
        case email
        case password
        case labTestAppointments
        case fees
        case about
        case specialization
        case experience
        case qualification
        case createdAt
        case updatedAt
        case schedule
    }
}

struct DoctorResponse: Codable {
    var success: Bool
    var data: [Doctor]
}

class DoctorAPI {
    static let shared = DoctorAPI()
    
    private let token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkbWluQGhvc3BpdGFsLmNvbSIsImlkIjoiNjY2NDIxZmU1ZmRmOTg2OTZiMjBkNTA2IiwiaWF0IjoxNzE3OTU5NDg5fQ.y_NH-WBnxFDfZLNJvxnI8zTxouAltKZa_JPAYvF7284"
    private let baseURL = "https://hms-backend-1-1aof.onrender.com/admin"
    
    func getDoctors(completion: @escaping (Result<DoctorResponse, Error>) -> Void) {
        let urlString = "\(baseURL)/doctors"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
                return
            }
            
            print("Status Code: \(httpResponse.statusCode)")
            
            if !(200...299).contains(httpResponse.statusCode) {
                if let data = data, let responseBody = String(data: data, encoding: .utf8) {
                    print("Response Body: \(responseBody)")
                }
                completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Server error"])))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let doctorResponse = try decoder.decode(DoctorResponse.self, from: data)
                completion(.success(doctorResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

    func approveDoctor(doctorID: String, completion: @escaping (Result<Doctor, Error>) -> Void) {
        let urlString = "\(baseURL)/doctors/\(doctorID)/approve"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
                return
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Server error"])))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let doctor = try decoder.decode(Doctor.self, from: data)
                completion(.success(doctor))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func rejectDoctor(doctorID: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let urlString = "\(baseURL)/doctors/\(doctorID)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
                return
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Server error"])))
                return
            }
            
            completion(.success(true))
        }
        
        task.resume()
    }
}
