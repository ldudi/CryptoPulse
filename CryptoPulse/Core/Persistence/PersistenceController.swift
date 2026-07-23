import SwiftData

@MainActor
final class PersistenceController {

    let container: ModelContainer

    var context: ModelContext {
        container.mainContext
    }

    init(
        inMemory: Bool = false
    ) {

        let configuration = ModelConfiguration(
            isStoredInMemoryOnly: inMemory
        )

        do {

            container = try ModelContainer(
                for: AppSchema.schema,
                configurations: configuration
            )

        } catch {

            fatalError(
                "Failed to initialize SwiftData: \(error)"
            )
        }
    }

    func save() throws {

        guard context.hasChanges else {
            return
        }

        do {

            try context.save()

        } catch {

            throw PersistenceError.saveFailed(error)
        }
    }
}
