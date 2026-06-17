// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// ═══════════════════════════════════════════════════
// EduProof Tanzania
// Blockchain Certificate Verification System
// Built on Avalanche C-Chain
// Any Tanzanian institution can issue and verify
// ═══════════════════════════════════════════════════

contract EduProofTanzania {

    // ── OWNER ───────────────────────────────────────
    // The deployer — EduProof platform admin
    address public owner;

    // ── CERTIFICATE STRUCTURE ───────────────────────
    // Everything stored for one certificate
    struct Certificate {
        string  recipientName;    // full name
        string  recipientId;      // unique ID — the key
        string  courseName;       // course or program name
        string  institution;      // issuing institution
        string  certificateType;  // Degree/Bootcamp/Hackathon/Training
        uint256 issueYear;        // year of completion
        uint256 issuedAt;         // blockchain timestamp
        bool    exists;           // true = real certificate
        bool    revoked;          // true = cancelled by admin
    }

    // ── STORAGE ─────────────────────────────────────
    // recipientId → Certificate
    // Any institution's ID system works as the key
    mapping(string => Certificate) private certificates;

    // Track approved institutions
    mapping(address => string) public institutions;
    mapping(address => bool)   public approvedIssuers;

    uint256 public totalCertificates;

    // ── EVENTS ──────────────────────────────────────
    event CertificateIssued(
        string  recipientId,
        string  recipientName,
        string  courseName,
        string  institution,
        string  certificateType,
        uint256 issueYear,
        uint256 issuedAt
    );

    event CertificateRevoked(
        string  recipientId,
        string  institution,
        uint256 revokedAt
    );

    event IssuerApproved(
        address issuer,
        string  institutionName
    );

    // ── SECURITY ────────────────────────────────────
    modifier onlyOwner() {
        require(msg.sender == owner,
            "Not authorised: EduProof admin only");
        _;
    }

    modifier onlyApprovedIssuer() {
        require(
            msg.sender == owner || approvedIssuers[msg.sender],
            "Not authorised: approved institution only"
        );
        _;
    }

    // ── CONSTRUCTOR ─────────────────────────────────
    constructor() {
        owner = msg.sender;
        // Owner (deployer) is automatically an approved issuer
        approvedIssuers[msg.sender] = true;
        institutions[msg.sender] = "EduProof Tanzania";
    }

    // ── APPROVE INSTITUTION ─────────────────────────
    // Owner approves new institutions to issue certificates
    // e.g. SJUIT, Andela, ALX, bootcamps, hackathon orgs
    function approveInstitution(
        address issuer,
        string memory institutionName
    ) public onlyOwner {
        approvedIssuers[issuer] = true;
        institutions[issuer]    = institutionName;
        emit IssuerApproved(issuer, institutionName);
    }

    // ── ISSUE CERTIFICATE ───────────────────────────
    // Any approved institution can issue
    // Institution name pulled from their wallet registration
    function issueCertificate(
        string memory recipientName,
        string memory recipientId,
        string memory courseName,
        string memory certificateType,
        uint256 issueYear
    ) public onlyApprovedIssuer {

        // Block duplicate certificates for same ID
        require(
            !certificates[recipientId].exists,
            "Certificate already issued for this ID"
        );

        // Get institution name from approved issuers mapping
        string memory institution = msg.sender == owner
            ? institutions[owner]
            : institutions[msg.sender];

        // Build and store certificate
        certificates[recipientId] = Certificate({
            recipientName:   recipientName,
            recipientId:     recipientId,
            courseName:      courseName,
            institution:     institution,
            certificateType: certificateType,
            issueYear:       issueYear,
            issuedAt:        block.timestamp,
            exists:          true,
            revoked:         false
        });

        totalCertificates++;

        emit CertificateIssued(
            recipientId,
            recipientName,
            courseName,
            institution,
            certificateType,
            issueYear,
            block.timestamp
        );
    }

    // ── VERIFY CERTIFICATE ──────────────────────────
    // Anyone can verify — no wallet needed
    // Employer types recipient ID → gets full result
    function verifyCertificate(string memory recipientId)
        public view
        returns (
            string  memory recipientName,
            string  memory rid,
            string  memory courseName,
            string  memory institution,
            string  memory certificateType,
            uint256        issueYear,
            uint256        issuedAt,
            bool           isValid
        )
    {
        Certificate memory cert = certificates[recipientId];

        // Not found or revoked = invalid
        if (!cert.exists || cert.revoked) {
            return ("", "", "", "", "", 0, 0, false);
        }

        return (
            cert.recipientName,
            cert.recipientId,
            cert.courseName,
            cert.institution,
            cert.certificateType,
            cert.issueYear,
            cert.issuedAt,
            true
        );
    }

    // ── REVOKE CERTIFICATE ──────────────────────────
    // Admin can cancel fraudulent certificates
    function revokeCertificate(string memory recipientId)
        public onlyOwner
    {
        require(
            certificates[recipientId].exists,
            "Certificate does not exist"
        );
        certificates[recipientId].revoked = true;
        totalCertificates--;
        emit CertificateRevoked(recipientId, institutions[owner], block.timestamp);
    }

    // ── TOTAL CERTIFICATES ──────────────────────────
    function getTotalCertificates()
        public view returns (uint256) {
        return totalCertificates;
    }

    // ── CHECK IF APPROVED ISSUER ────────────────────
    function getInstitutionName(address issuer)
        public view returns (string memory) {
        return institutions[issuer];
    }
}
