# 🔍 SPF & DMARC Checker - `spf_dmarc_check.sh`

A lightweight bash-based tool to check **SPF (Sender Policy Framework)** and **DMARC (Domain-based Message Authentication, Reporting & Conformance)** records for one or more domains.

Helps domain owners and security researchers verify the presence and syntax of SPF & DMARC records to prevent spoofing and improve email authentication.

---

## 📌 What are SPF & DMARC?

- **SPF** allows domain owners to specify which IP addresses are authorized to send emails on behalf of their domain. It helps reduce spam and phishing.
- **DMARC** builds on SPF and DKIM to instruct email receivers how to handle unauthenticated emails, providing visibility and control over spoofed messages.

---

## 🛠️ How does `spf_dmarc_check.sh` work?

- Accepts a text file containing a list of domains.
- Uses the `dig` command to retrieve `TXT` records for SPF and DMARC.
- Parses the results to:
  - Check if SPF or DMARC records are present
  - Validate basic syntax
  - Extract DMARC policy (e.g. `p=none`, `p=reject`)

---

## ✅ Features

- 🔎 Bulk check domains from a file
- 📄 Detect and validate SPF & DMARC records
- 🛡️ Show DMARC policy details
- 🧪 Bash-only, lightweight, and fast
- ☑️ Ideal for bug bounty, recon, or security audits

---

## 📥 Installation

```bash
git clone https://github.com/iambuvanesh/spf_dmarc_check
cd spf_dmarc_check
chmod +x spf_dmarc_check.sh
````

---

## ⚙️ Usage

```bash
./spf_dmarc_check.sh domain_list.txt
```

### Example `domain_list.txt`:

```
example.com
sub.example.org
mydomain.net
```

---

## 🧰 Requirements

* Unix-based system (Linux/macOS)
* `dig` command-line tool

To install `dig` (on Debian/Ubuntu):

```bash
sudo apt install dnsutils
```

---

## ⚠️ Note

* This script performs **basic record discovery and syntax validation only**.
* It does **not validate DKIM** or simulate full mail flow.
* For complete domain email security, further testing and monitoring are recommended.

---

## 🤝 Contributing

Contributions are welcome! You can:

* 🐞 Report bugs or request features via [Issues](https://github.com/iambuvanesh/spf_dmarc_check/issues)
* 📚 Improve the documentation
* 💻 Submit pull requests with enhancements
* 📢 Share the tool with others in the infosec and bug bounty community

Please review `CONTRIBUTING.md` before submitting a pull request.

---

## 📄 License

Licensed under the **MIT License**.
See `LICENSE` for more information.

---

## 🙌 Acknowledgments

Thanks to the open-source community and all contributors who help make tools like this available to everyone 💙

```

---

