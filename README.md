# Nginx Log Analyser

A Bash/AWK script that parses Nginx access logs and reports the **top-5 IPs, most-requested paths, and most-common HTTP status codes** — no dependencies, runs anywhere.

## Sample Output

```
--- Top 5 IP Addresses by Request Count ---
192.168.1.1 - 142 requests
10.0.0.5    - 98 requests
172.16.0.3  - 74 requests
10.0.0.8    - 61 requests
192.168.1.9 - 45 requests

----- Top 5 most requested paths ---------
/index.html       - 320 requests
/api/v1/users     - 210 requests
/static/style.css - 180 requests
/favicon.ico      - 95 requests
/api/v1/login     - 87 requests

----- Top 5 most response status codes ---
200 - 1024 requests
404 - 312  requests
301 - 98   requests
500 - 24   requests
403 - 11   requests
```

## Usage

```bash
chmod +x deploy.sh
./deploy.sh <path-to-nginx-access.log>
```

**Example:**

```bash
./deploy.sh /var/log/nginx/access.log
# or use the included sample log
./deploy.sh nginx-access.log
```

## How It Works

The script uses standard POSIX tools — `awk`, `sort`, and `uniq` — to parse the [Common Log Format](https://en.wikipedia.org/wiki/Common_Log_Format) used by Nginx:

| Column | Field |
|---|---|
| `$1` | Client IP address |
| `$7` | Requested URL path |
| `$9` | HTTP response status code |

Each metric follows the same pipeline:

```bash
awk '{print $FIELD}' "$LOG_FILE" \   # extract column
  | sort \                            # sort for uniq
  | uniq -c \                         # count occurrences
  | sort -rn \                        # sort descending by count
  | head -5 \                         # take top 5
  | awk '{print $2 " - " $1 " requests"}'  # format output
```

## Requirements

- Bash 3+
- `awk`, `sort`, `uniq` (standard on all Unix/Linux/macOS systems)

## Reference

Built following the [roadmap.sh Nginx Log Analyser](https://roadmap.sh/projects/nginx-log-analyser) project spec.
