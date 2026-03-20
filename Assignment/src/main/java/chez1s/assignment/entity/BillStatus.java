package chez1s.assignment.entity;

/**
 * Bill lifecycle statuses.
 * Stored in DB as the enum name (e.g. "WAITING") via @Enumerated(STRING).
 */
public enum BillStatus {
    PENDING,
    WAITING,
    PAID,
    FINISHED,
    CANCELLED
}
