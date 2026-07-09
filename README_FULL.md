7-Zip Forensics Demo — Full Explanation
======================================

Overview
--------
This document explains the small 7-Zip forensic demonstration project, the control flow used when running the demo, and a line-by-line description of every script so you can explain each element to your professor.

Project structure
-----------------
- demo_compress/ — contains `compress.bat` and `sample_files/` used to create `sample.7z`.
- demo_list/ — contains `list_contents.bat` which runs `7z l` to inspect an archive.
- demo_hash/ — contains `hash.bat` to compute SHA-256 digests using `CertUtil`.
- demo_extract/ — contains `extract.bat` to extract archives into a safe folder.
- demo_search/ — contains `search_by_name.bat` to search archives for filenames/keywords.
- run_all_demos.bat — orchestrates the demo sequence.

Control flow (detailed)
-----------------------
1. Create an archive from example files with `demo_compress\compress.bat`.
   - Input: folder of files (defaults to `demo_compress/sample_files`).
   - Output: archive file (defaults to `demo_compress/sample.7z`).
   - Purpose: show how evidence can be packaged; supports header encryption (`-mhe=on`) to demonstrate concealment of filenames.

2. Inspect the archive with `demo_list\list_contents.bat`.
   - Input: archive path (defaults to `../demo_compress/sample.7z`).
   - Output: human-readable list of files, sizes, dates.
   - Purpose: explain metadata available in archives and how it can be used in an investigation.

3. Compute cryptographic hash with `demo_hash\hash.bat`.
   - Input: file or archive (defaults to `../demo_compress/sample.7z`).
   - Output: SHA-256 digest printed to console.
   - Purpose: demonstrate integrity verification and record a digest as part of chain of custody.

4. Extract with `demo_extract\extract.bat`.
   - Input: archive path and optional output folder.
   - Output: extracted files in a dedicated directory.
   - Purpose: show safe extraction practices and verify recovered content matches recorded hashes.

5. Search archives with `demo_search\search_by_name.bat`.
   - Input: search pattern (defaults to `secret`).
   - Output: prints which archives contain the pattern (if filenames visible).
   - Purpose: demonstrate how to find items of interest within archives; show encryption impact.

Script-by-script explanation (what each script does and why)
-----------------------------------------------------------

1) demo_compress\compress.bat
- Description: Packs files from a source directory into a 7z archive.
- Key lines:
  - `if not defined 7ZIP set "7ZIP=7z"` — sets the `7z` command; allows overriding via environment variable.
  - `"%7ZIP%" a -t7z "%OUT%" "%SRC_DIR%\*" -mhe=on` — archive creation; `-mhe=on` enables header encryption.
- Teaching points:
  - Show how encryption prevents exposure of filenames (header encryption) vs only password-protecting file contents.
  - Demonstrate how different `7z` switches affect archive format and metadata.

2) demo_list\list_contents.bat
- Description: Calls `7z l` to display archive contents.
- Key behavior:
  - When run against a non-encrypted header archive, you can see filenames and timestamps.
  - When the header is encrypted, `7z l` will not reveal file names without the password.
- Teaching points: show how metadata can be extracted without full extraction.

3) demo_hash\hash.bat
- Description: Uses `CertUtil -hashfile <file> SHA256` to compute SHA-256.
- Key behavior:
  - Quick, built-in Windows tool; output should be recorded in an evidence log.
- Teaching points: why SHA-256 is used, collision resistance, and recording hashes as part of chain-of-custody.

4) demo_extract\extract.bat
- Description: Uses `7z x` to extract files to a target folder.
- Key behavior:
  - Uses `-o` switch to direct output into a clean folder (default `extracted`).
  - Demonstrate verifying extracted content via hashes and timestamps.
- Teaching points: always extract to a controlled location and do not modify original archive.

5) demo_search\search_by_name.bat
- Description: Iterates `.7z` files and searches their `7z l` output for a pattern.
- Implementation note:
  - Uses `findstr /I` to match case-insensitively; relies on visible filenames in `7z l` output.
- Teaching points: if headers are encrypted, filenames won't be visible and searching this way will fail — this is an intentional demo to illustrate trade-offs.

Demonstration checklist (what to show step-by-step to your professor)
--------------------------------------------------------------------
1. Show folder `demo_compress/sample_files` and open `sample1.txt` / `sample2.txt`.
2. Run `demo_compress\compress.bat` and show the created `sample.7z`.
3. Run `demo_list\list_contents.bat` to show internal file metadata.
4. Run `demo_hash\hash.bat` and record the SHA-256 value.
5. Run `demo_extract\extract.bat` to extract files into `demo_extract\extracted` and show the recovered files.
6. Re-run `demo_hash\hash.bat` on the archive and/or compute hashes of extracted files to demonstrate integrity.
7. Run `demo_search\search_by_name.bat secret` to locate items of interest (explain behavior if header encryption is enabled).

Common questions and suggested answers
-------------------------------------
- Q: "Why hash before extracting?"
  - A: To prove the archive's integrity at the time it was collected; later comparisons verify no tampering.
- Q: "What does header encryption do?"
  - A: It encrypts the archive directory (filenames, sizes, and timestamps), preventing metadata disclosure without the password.
- Q: "Can we search encrypted archives?"
  - A: Not by filename using `7z l` if the header is encrypted; you need the password or other analysis techniques.

Troubleshooting
---------------
- If `7z` command is not found, install 7-Zip and ensure `7z.exe` is on PATH or set `7ZIP` env var.
- If `findstr` shows no matches, confirm the archive's header is not encrypted and that you used the correct search pattern.

Next improvements (optional)
---------------------------
- Provide PowerShell equivalents of each batch script.
- Add a `verify_all.bat` to compute and record hashes for all demo artifacts into `hashes.txt`.
- Add script logging to create a simple audit trail (timestamped logs).

Contact
-------
If you want, I can produce a short presentation (slides) summarizing these steps, or add PowerShell scripts and an automated verification script.


