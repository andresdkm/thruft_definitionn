
struct Money {
  1: required string amount
  2: required string currency
}

enum Role {
  ADMIN           = 1,
  OPS_MANAGER     = 2,
  MPO_PILOT       = 3,
  IMAGE_QA        = 4,
  FINANCE         = 5,
  CLIENT_VIEWER   = 6, 
  CLIENT_APPROVER = 7   
}

struct User {
  1: required Uuid       id
  2: required string     email
  3: required string     displayName
  4: required set<Role>  roles
  6: required bool       active
  7: required TimestampMs createdAt
}

struct Client {
  1: required Uuid   id
  2: required string legalName
  3: optional string taxId                
  4: optional string crmRef
  6: optional Uuid   userId   
  7: optional string billingProfileRef     
  8: required TimestampMs createdAt
  9: optional TimestampMs deletedAt     
}
/*****************************************/
enum ProjectStatus {
  DRAFT    = 1,
  ACTIVE   = 2,
  ON_HOLD  = 3,
  CLOSED   = 4
}
struct Project {
  1: required Uuid          id
  2: required Uuid          clientId
  3: required string        name
  4: required ProjectStatus status
  5: optional string        contractRef
  6: optional Money         budget
  7: required TimestampMs   createdAt
  8: optional TimestampMs   closedAt
}

/*******************************/

enum MissionStatus {
  SCHEDULED = 1,
  IN_FLIGHT = 2,
  COMPLETED = 3,
  VALIDATED = 4,
  CANCELLED = 5,
  ABORTED   = 6
}


struct Mission {
  1:  required Uuid          id
  2:  required Uuid          projectId
  4:  required MissionStatus status
  5:  optional string        flightPlanRef      
  6:  required TimestampMs   windowStart        
  7:  required TimestampMs   windowEnd
  8:  optional double        latitude           
  9:  optional double        longitude        
  10: optional TimestampMs   completedAt
  11: optional string        telemetryRef      
  12: required TimestampMs   createdAt
  13: optional TimestampMs   deletedAt     
}

/***************************************************************/
/** ingesting → processing → sample_ready → approved → delivered;
    rejected loops back to processing (rework) */
enum MediaBatchStatus {
  INGESTING    = 1,
  PROCESSING   = 2,
  SAMPLE_READY = 3,
  APPROVED     = 4,
  REJECTED     = 5,
  DELIVERED    = 6
}

struct MediaBatch {
  1: required Uuid             id
  2: required Uuid             missionId
  3: required MediaBatchStatus status
  4: required string           storageRef       
  5: optional i32              itemCount
  6: optional i64              totalBytes
  8: optional Uuid             approvedBy       // userId
  9: optional TimestampMs      approvedAt
  10: required TimestampMs     createdAt
}

/*************************************/

enum DeliverableStatus {
  PENDING   = 1,
  READY     = 2,
  DELIVERED = 3,
  ACCEPTED  = 4
}

struct Deliverable {
  1: required Uuid              id
  2: required Uuid              mediaBatchId
  3: required DeliverableStatus status
  4: required string            formatSpec       
  5: optional string            deliveryChannel  
  6: optional string            deliveredRef    
  7: optional TimestampMs       deliveredAt
  8: required TimestampMs       createdAt
}

enum InvoiceStatus {
  REQUESTED = 1,
  ISSUED    = 2,
  PAID      = 3,
  OVERDUE   = 4,
  VOID      = 5
}

struct Invoice {
  1: required Uuid          id
  2: required Uuid          projectId
  3: required Uuid          clientId
  4: required list<Uuid>    deliverableIds
  5: required InvoiceStatus status
  6: required Money         amount
  7: optional string        financeSaasRef   // id in the external system
  8: required TimestampMs   requestedAt
  9: optional TimestampMs   issuedAt
  10: optional TimestampMs  paidAt
}
