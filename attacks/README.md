# Attack log

Every attack we run against our own lab, one row each. Copy `TEMPLATE.md` to `NN-short-name.md` for the write-up.

| # | Attack | ATT&CK | Attacker → target | Blocked? | Detected? | Fix | Write-up |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 01 | Network scan from Guest | T1046 | London → Accra Guest | | | | |
| 02 | Router admin brute force | T1110 | London → Accra Mgmt | | | | |
| 03 | Guest → Staff pivot | T1021 | London → Accra | | | | |
| 04 | Known-bad domain lookup | T1071.004 | Accra Staff | | | | |
| 05 | Network scan from Guest | T1046 | Accra → London Guest | | | | |
| 06 | Router admin brute force | T1110 | Accra → London Mgmt | | | | |
| 07 | IoT → Staff pivot | T1021 | Accra → London | | | | |
| 08 | Rogue device joins Staff | T1200 | London | | | | |

Use ✅ / ❌ / ⚠️ (partial). Add rows as you invent new tests.
