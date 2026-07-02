
struct EventEnvelope {
  1: required Uuid        eventId        // consumers dedupe on this
  2: required string      eventType
  3: required i32         version
  4: required TimestampMs occurredAt
  5: required string      producer
  6: required Uuid        correlationId
  7: optional Uuid        causationId
  8: required binary      payload        // serialized payload struct below
}

struct MissionCompletedV1 {
  1: required Uuid        missionId
  2: required Uuid        projectId
  3: required Uuid        mpoId
  4: required TimestampMs completedAt
  5: optional string      telemetryRef
  6: required bool        mediaExpected
}

struct MediaIngestedV1 {
  1: required Uuid        mediaBatchId
  2: required Uuid        missionId
  3: required i32         itemCount
  4: required i64         totalBytes
  5: required string      storageRef
  6: optional string      checksum
  7: required TimestampMs ingestCompletedAt
}

struct SampleApprovedV1 {
  1: required Uuid        mediaBatchId
  2: required Uuid        projectId
  3: required Uuid        clientId
  4: required Uuid        approvedBy
  5: required TimestampMs approvedAt
  6: optional string      notes
}

struct InvoiceRequestedV1 {
  1: required Uuid        invoiceRequestId
  2: required Uuid        projectId
  3: required Uuid        clientId
  4: required list<Uuid>  deliverableIds
  5: required Money       amount
  6: required Uuid        requestedBy
  7: required TimestampMs requestedAt
}
