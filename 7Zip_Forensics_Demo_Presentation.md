# 7-Zip Forensics Demo Presentation

---
## Slide 1: Title Slide

**7-Zip Application Forensics Demo**

A Practical Demonstration of the Digital Evidence Lifecycle

*<Your Name>*
*<Your Course/Professor Name>*
*<Date>*

---
## Slide 2: What is Application Forensics?

**Definition:** The practice of collecting, analyzing, and interpreting data produced by software applications to investigate incidents and provide evidence.

**Focuses on Application Artifacts:**
*   Logs
*   Configuration files
*   Caches & Temporary Files
*   **Archives (like .7z)**
*   Metadata

**Core Goals:**
1.  **Identify** relevant evidence.
2.  **Preserve** its integrity.
3.  **Analyze** its content and meaning.
4.  **Report** findings reproducibly.

---
## Slide 3: The Evidence Lifecycle

This project simulates a simplified, end-to-end forensic workflow.

**Collection** -> **Preservation** -> **Verification** -> **Triage & Analysis** -> **Recovery** -> **Reporting**

*(This would be a great place for a simple flow diagram)*

---
## Slide 4: Project Overview: `7zip_app`

A set of scripts demonstrating forensic tasks using the 7-Zip command-line tool.

*   `demo_compress`: Package evidence files into an archive.
*   `demo_list`: Inspect archive metadata.
*   `demo_hash`: Verify evidence integrity.
*   `demo_extract`: Perform a controlled extraction.
*   `demo_search`: Triage archives for keywords.

The entire process is orchestrated by `run_all_demos.bat` for reproducibility.

---
## Slide 5: Demo Step 1: Collection & Preservation

**Script:** `demo_compress\compress.bat`

**Forensic Concept:** Simulates collecting files from a source and packaging them into a secure evidence container.

**Action:**
```batch
"%7ZIP%" a -t7z "%OUT%" "%SRC_DIR%\*" -mhe=on
```
*   Creates `sample.7z` from the `sample_files` directory.
*   The `-mhe=on` switch enables **Header Encryption**.

**Teaching Point:** Header encryption conceals filenames and timestamps, demonstrating a trade-off between confidentiality and ease of analysis.

---
## Slide 6: Demo Step 2: Metadata Inspection

**Script:** `demo_list\list_contents.bat`

**Forensic Concept:** Triage and initial analysis. An investigator inspects metadata to understand the evidence without altering it.

**Action:**
*   Runs `7z l` to list the contents of `sample.7z`.

**Teaching Point:**
*   With header encryption **ON**, filenames, sizes, and dates are hidden. The investigator cannot see what is inside without a password.
*   With it **OFF**, all metadata is visible, guiding the next steps.

---
## Slide 7: Demo Step 3: Integrity Verification

**Script:** `demo_hash\hash.bat`

**Forensic Concept:** Establishing a Chain of Custody.

**Action:**
*   Uses the built-in Windows `CertUtil` to compute a SHA-256 digest of `sample.7z`.

**Teaching Point:**
*   A hash is a unique digital fingerprint. It's computed immediately after collection.
*   If the hash value ever changes, it proves the evidence has been tampered with.
*   This is fundamental for evidence admissibility.

---
## Slide 8: Demo Step 4: Controlled Recovery

**Script:** `demo_extract\extract.bat`

**Forensic Concept:** Safe and auditable evidence recovery.

**Action:**
*   Uses `7z x` with the `-o` switch to extract files into a clean, dedicated directory (`extracted`).

**Teaching Point:** Never extract evidence into the same folder or modify the original archive. This prevents contamination and preserves the original artifact for future verification.

---
## Slide 9: Demo Step 5: Searching & Triage

**Script:** `demo_search\search_by_name.bat`

**Forensic Concept:** Quickly searching across evidence containers for items of interest (e.g., files containing "secret").

**Action:**
*   Searches the output of `7z l` for a given text pattern.

**Teaching Point:** This triage technique is fast but depends on visible metadata. If header encryption is enabled, this search will fail, forcing the investigator to use other methods.

---
## Slide 10: Summary & Key Takeaways

1.  **The Forensic Lifecycle:** This demo walked through a complete, simplified evidence lifecycle (Collect, Preserve, Verify, Analyze, Recover).
2.  **Encryption vs. Analysis:** Features like 7-Zip's header encryption create a critical trade-off between privacy and the ability for an investigator to perform analysis.
3.  **Process is Key:** Forensic soundness depends on process. Hashing for integrity and extracting to controlled locations are non-negotiable steps.
4.  **Tools Matter:** The switches and capabilities of the tools used (like `7z`) directly impact the forensic workflow.

---
## Slide 11: Questions & Discussion

**Q: "Why hash the archive *before* extracting?"**
A: To prove the integrity of the evidence container at the time it was collected. This allows you to verify it wasn't tampered with before you began your analysis.

**Q: "What does header encryption do that a password doesn't?"**
A: It encrypts the archive's "table of contents" (filenames, sizes, timestamps), preventing anyone from even knowing what files are inside without the password.

**Q: "Can you search encrypted archives?"**
A: Not by filename if the header is encrypted. You would need the password to decrypt the archive first or rely on other forensic techniques.