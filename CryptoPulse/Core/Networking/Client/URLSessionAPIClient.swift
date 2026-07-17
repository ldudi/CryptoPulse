//
//  URLSessionAPIClient.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 15/07/26.
//
//
//import Foundation
//
//  URLSessionAPIClient.swift
//

import Foundation

final class URLSessionAPIClient: APIClient {

    // MARK: - Properties

    private let session: URLSession

    private let configuration: APIConfiguration

    private let retryPolicy: RetryPolicy

    // MARK: - Init

    init(
        session: URLSession = .shared,
        configuration: APIConfiguration = .live,
        retryPolicy: RetryPolicy = .default
    ) {

        self.session = session

        self.configuration = configuration

        self.retryPolicy = retryPolicy
    }

    // MARK: - Request

    func request<Response: Decodable>(
        _ endpoint: Endpoint<Response>
    ) async throws -> Response {

        var currentAttempt = 0

        while true {

            do {

                let request = try RequestBuilder.build(
                    endpoint: endpoint,
                    configuration: configuration
                )

                let (data, response) = try await session.data(
                    for: request
                )

                guard let httpResponse = response as? HTTPURLResponse else {

                    throw NetworkError.invalidResponse
                }

                try ResponseValidator.validate(
                    httpResponse
                )

                if Response.self == EmptyResponse.self {

                    return EmptyResponse() as! Response
                }

                do {

                    return try JSONDecoder.apiDecoder.decode(
                        Response.self,
                        from: data
                    )

                } catch let error as DecodingError {

                    print("===================================")
                    print("DECODING ERROR")
                    print("===================================")

                    switch error {

                    case .keyNotFound(let key, let context):

                        print("❌ Key not found:", key.stringValue)
                        print(context.debugDescription)
                        print(context.codingPath)

                    case .typeMismatch(let type, let context):

                        print("❌ Type mismatch:", type)
                        print(context.debugDescription)
                        print(context.codingPath)

                    case .valueNotFound(let type, let context):

                        print("❌ Value not found:", type)
                        print(context.debugDescription)
                        print(context.codingPath)

                    case .dataCorrupted(let context):

                        print("❌ Data corrupted")
                        print(context.debugDescription)

                    @unknown default:
                        print(error)
                    }

                    throw error
                }

            }

            catch {

                if let networkError = error as? NetworkError {

                    throw networkError
                }

                if let decodingError = error as? DecodingError {

                    throw NetworkError.decoding(decodingError)
                }

                if let urlError = error as? URLError {

                    switch urlError.code {

                    case .timedOut:

                        throw NetworkError.timeout

                    case .cancelled:

                        throw NetworkError.cancelled

                    default:

                        break
                    }
                }

                currentAttempt += 1

                if let statusCode = extractStatusCode(from: error),

                   retryPolicy.shouldRetry(
                    attempt: currentAttempt,
                    statusCode: statusCode
                   ) {

                    let delay = retryPolicy.delay(
                        for: currentAttempt
                    )

                    try await Task.sleep(
                        for: .seconds(delay)
                    )

                    continue
                }

                throw NetworkError.requestFailed(error)
            }
        }
    }

    // MARK: - Helpers

    private func extractStatusCode(
        from error: Error
    ) -> Int? {

        guard case let NetworkError.serverError(code) = error else {

            return nil
        }

        return code
    }
}
