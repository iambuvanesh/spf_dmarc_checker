#!/bin/bash

# Multi-domain SPF and DMARC Checker

if [ $# -lt 1 ]; then
  echo "Usage: $0 domain_list.txt"
  exit 1
fi

domain_list=$1

if [ ! -f "$domain_list" ]; then
  echo "File not found: $domain_list"
  exit 1
fi

echo "Starting SPF and DMARC scan for domains in: $domain_list"
echo "========================================================="

while read -r domain; do
  [ -z "$domain" ] && continue  # Skip empty lines

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

done < "$domain_list"

echo ""
echo "Scan completed."
