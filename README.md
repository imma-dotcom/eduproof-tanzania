# EduProof Tanzania — Blockchain Certificate Verification

A blockchain-based certificate verification system built on Avalanche, created for the SJUIT × Avalanche Blockchain Workshop 2026 Hackathon.

**Live contract:** [`0x4fBD4226A537f63b0d968Aea48fe219D7448D9f3`](https://testnet.snowtrace.io/address/0x4fBD4226A537f63b0d968Aea48fe219D7448D9f3) · Avalanche Fuji Testnet

---

## Problem Statement

Verifying academic and training certificates in Tanzania is slow and easy to forge. Employers and institutions have no fast, reliable way to confirm a certificate is genuine — verification usually means manually contacting the issuing institution, which can take days or never get a response at all. That gap lets fake certificates slip through, and it costs honest graduates time and credibility every time they need to prove a qualification.

## Solution Overview

EduProof Tanzania lets approved institutions — universities, bootcamps, hackathon organizers, and training programs — issue certificates directly onto the Avalanche Fuji Testnet. Each certificate is permanently and tamper-proof recorded on-chain, tied to a unique Recipient ID. Anyone — an employer, another institution, or the certificate holder — can verify a certificate instantly by entering that ID. No account, no wallet, no technical knowledge required to check one.

## Track Selected

Track 2: Education & Credentials

## Features

- On-chain certificate issuance, restricted to approved institution wallets
- Multi-institution support — any approved Tanzanian institution can issue under its own name
- Public verification with no wallet or account needed
- Four certificate types: Degree, Bootcamp, Hackathon, Training
- Owner-controlled institution approval and certificate revocation
- Clean, dark-themed single-page interface with no build step and no framework

## Tech Stack

| Layer | Technology |
|---|---|
| Smart Contract | Solidity ^0.8.0 |
| Blockchain | Avalanche Fuji Testnet (C-Chain, Chain ID 43113) |
| Development | Remix IDE |
| Wallet | Core Wallet |
| Frontend ↔ Blockchain | ethers.js v5.7.2 |
| Frontend | HTML / CSS / Vanilla JavaScript (no framework) |

## Smart Contract

- **Address:** `0x4fBD4226A537f63b0d968Aea48fe219D7448D9f3`
- **Network:** Avalanche Fuji Testnet (Chain ID 43113)
- **Explorer:** [View on Snowtrace](https://testnet.snowtrace.io/address/0x4fBD4226A537f63b0d968Aea48fe219D7448D9f3)

This is the third iteration of the contract. Earlier versions (`SJUITCertChain`, `SJUITCertificateV3`) proved the core idea for a single university before this version generalized it so any approved Tanzanian institution can issue under its own name.

### How Avalanche is used

Every certificate is a transaction on a Solidity smart contract deployed on the Avalanche C-Chain. Avalanche's fast finality confirms each certificate in seconds. Once written, a record cannot be silently edited — only revoked by the platform admin, and that revocation itself emits a permanent on-chain event with a timestamp. The approved-issuer model means no single institution controls the whole system.

## How to Run Locally

1. Clone this repository
2. Open `EduProofTanzania.html` directly in any browser — no build step, no dependencies to install
3. Install [Core Wallet](https://core.app/) or MetaMask browser extension
4. Connect your wallet — the app automatically prompts to switch to Avalanche Fuji Testnet
5. Get free testnet AVAX from the [Avalanche Fuji Faucet](https://core.app/tools/testnet-faucet/)
6. **Verify tab** — works with no wallet, anyone can check a certificate
7. **Issue tab** — requires an approved wallet to create a certificate
8. **Institutions tab** — owner only, approve new institution wallets

## Screenshots / Demo


1. Landing page
2. Wallet connected
3. Issue form filled in
4. Successful issuance confirmation
5. Verify result – real certificate
6. Verify result – fake / not-found ID

---

!![Landing Page](screenshots/landingpage.png)
![Wallet Connected](<screenshots/Wallet connected.png>)
![Issue Form Filled In](<screenshots/Issue form filled in.png>)
![Successful Issuance](<screenshots/Successful issuance confirmation.png>)
![Verify Real Certificate](<screenshots/Verify result — real certificate.png>)
![Verify Fake ID](<screenshots/Verify result — fake-not-found ID.png>)


## Team Members

Built and submitted individually by **Godwin Shirima** (@fyne\_\_tech) — SJUIT, Dar es Salaam, Tanzania.

Participated in the 4-week SJUIT × Avalanche Blockchain Workshop 2026, in collaboration with Ava Labs, featuring resource person Mr. Shaheer Karrim. Completed the official Avalanche Fundamentals course on build.avax.network.

## Future Improvements

- Move from testnet to Avalanche mainnet or a dedicated Avalanche L1 for production use
- Pursue official recognition through TCU (Tanzania Commission for Universities)
- Add an in-app revoke action for admins directly from the verify screen
- Add offline-friendly verification for low-connectivity areas
- Onboard additional institutions beyond SJUIT — other universities, bootcamps, and eventually the wider East African Community

---

*Built for the SJUIT × Avalanche Blockchain Workshop 2026 Hackathon · @fyne\_\_tech · Dar es Salaam, Tanzania 🇹🇿*
