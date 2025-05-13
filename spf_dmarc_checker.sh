#!/bin/bash

# Multi-domain or single-domain SPF and DMARC Checker

print_usage() {
  echo "Usage:"
  echo "  $0 domain_list.txt         # Scan a list of domains"
  echo "  $0 example.com             # Scan a single domain"
  exit 1
}

scan_domain() {
  local domain=$1
  echo ""
  echo "Domain: $domain"
  echo "-------------------------------------------"

  # Fetch SPF Record
  spf_record=$(dig +short TXT "$domain" | grep "v=spf1")
  if [ -n "$spf_record" ]; then
    echo "[+] SPF Record Found:"
    echo "    $spf_record"

    if echo "$spf_record" | grep -qE '^"v=spf1'; then
      echo "[+] SPF syntax looks correct."
    else
      echo "[-] SPF syntax might be incorrect."
    fi
  else
    echo "[-] No SPF Record found."
  fi

  echo ""

  # Fetch DMARC Record
  dmarc_record=$(dig +short TXT _dmarc."$domain" | grep "v=DMARC1")
  if [ -n "$dmarc_record" ]; then
    echo "[+] DMARC Record Found:"
    echo "    $dmarc_record"

    if echo "$dmarc_record" | grep -qE '^"v=DMARC1'; then
      echo "[+] DMARC syntax looks correct."
      policy=$(echo "$dmarc_record" | grep -o "p=[a-z]*" | cut -d= -f2)
      echo "[+] DMARC Policy: $policy"
    else
      echo "[-] DMARC syntax might be incorrect."
    fi
  else
    echo "[-] No DMARC Record found."
  fi

  echo "-------------------------------------------"
}

# Entry Point
if [ $# -ne 1 ]; then
  print_usage
fi

input=$1

if [[ -f "$input" ]]; then
  echo "Starting SPF and DMARC scan for domains in: $input"
  echo "========================================================="
  while read -r domain; do
    [ -z "$domain" ] && continue
    scan_domain "$domain"
  done < "$input"
else
  echo "Starting SPF and DMARC scan for single domain: $input"
  echo "========================================================="
  scan_domain "$input"
fi

echo ""
echo "Scan completed."
