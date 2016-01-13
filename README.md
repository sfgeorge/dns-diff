# dns-diff

Compare nameservers' DNS records for a domain

## Usage

    ./dns-diff.sh <list-of-nameservers.txt> <list-of-dig-queries.txt>

* `<list-of-nameservers.txt>` Should be a newline-separated list of nameservers, prefixed with "@". To test your operating system's default nameserver resolver, simply include a blank line in this file.
* `<list-of-dig-queries.txt>` Should include a newline-separated list of any queries that can be accepted by the `dig` command.  Acceptable entries can include:
  * example.com
  * -t MX example.com
  * -t TXT example.com +noall +answer
  *  api.example.com +short

For example usage, try:

    ./dns-diff.sh nameservers-example.txt queries-example.txt

## Output

dns-diff will create a `dns-diff-results` directory within the current directory.  This will contain a directory of query results for each name server listed.  Use a recursive diff tool such as `diff -r <directory 1> <directory N>` to compare results.

