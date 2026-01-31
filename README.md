# Nginx Log Analyser

Here, we are using "AWK" to break down the columns and extract the necessary information.

```
if [ -z "$1" ]; then
    echo "Usage: $0 <path>"
    exit 1
fi

```

Here, we analyse if the arguement is provided or not

```
if [ -f "$1" ]; then
    echo "File not present"
    exit 1
fi

```

Here, we analyse if the file is provided or not

```
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -5 | awk '{print $2 " - " $1 " requests"}'

```

And, finally we print the extracted values

Project URL = https://roadmap.sh/projects/nginx-log-analyser
