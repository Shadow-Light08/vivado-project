# #!/bin/bash

# function encrypt() {
#     local text="$1"
#     local shift="$2"
#     echo "$text" | tr 'A-Za-z' 'N-ZA-Mn-za-m' | tr 'A-Za-z' $(echo {A..Z} {A..Z} | sed -r "s/ //g;s/(.{${shift}})/\1\n/;:a;s/\n{2}//g;ta") | tr 'A-Za-z' 'N-ZA-Mn-za-m'
# }

# function decrypt() {
#     local text="$1"
#     local shift="$2"
#     echo "$text" | tr 'A-Za-z' 'N-ZA-Mn-za-m' | tr 'A-Za-z' $(echo {A..Z} {A..Z} | sed -r "s/ //g;s/(.{26-${shift}})/\1\n/;:a;s/\n{2}//g;ta") | tr 'A-Za-z' 'N-ZA-Mn-za-m'
# }

# if [[ "$1" == "-s" ]]; then
#     if [[ "$3" == "-k" ]]; then
#         if [[ "$4" -ge 0 ]]; then
#             encrypt "$2" "$4"
#         else
#             decrypt "$2" "$4"
#         fi
#     fi
# elif [[ "$1" == "-d" && "$2" == "-s" ]]; then
#     if [[ "$4" == "-k" ]]; then
#         decrypt "$3" "$5"
#     fi
# elif [[ "$1" == "-if" ]]; then
#     input_file="$2"
#     shift 2
#     if [[ "$1" == "-of" ]]; then
#         output_file="$2"
#         shift 2
#     fi
#     if [[ "$1" == "-k" ]]; then
#         key="$2"
#         shift 2
#     fi
#     if [[ "$1" == "-d" ]]; then
#         decrypt "$(cat $input_file)" "$key" > "$output_file"
#     else
#         encrypt "$(cat $input_file)" "$key" > "$output_file"
#     fi
# fi



#!/bin/bash

# 加密函数
encrypt() {
    local text="$1"
    local shift="$2"
    local encrypted=""
    local char
    for (( i=0; i<${#text}; i++ )); do
        char="${text:$i:1}"
        if [[ "$char" =~ [a-z] ]]; then
            encrypted+=$(printf "\\$(printf '%03o' $(( ( $(printf '%d' "'$char") - 97 + shift ) % 26 + 97 )) )")
        elif [[ "$char" =~ [A-Z] ]]; then
            encrypted+=$(printf "\\$(printf '%03o' $(( ( $(printf '%d' "'$char") - 65 + shift ) % 26 + 65 )) )")
        else
            encrypted+="$char"
        fi
    done
    echo "$encrypted"
}

# 解密函数
decrypt() {
    local text="$1"
    local shift="$2"
    local decrypted=""
    local char
    for (( i=0; i<${#text}; i++ )); do
        char="${text:$i:1}"
        if [[ "$char" =~ [a-z] ]]; then
            decrypted+=$(printf "\\$(printf '%03o' $(( ( $(printf '%d' "'$char") - 97 - shift + 26 ) % 26 + 97 )) )")
        elif [[ "$char" =~ [A-Z] ]]; then
            decrypted+=$(printf "\\$(printf '%03o' $(( ( $(printf '%d' "'$char") - 65 - shift + 26 ) % 26 + 65 )) )")
        else
            decrypted+="$char"
        fi
    done
    echo "$decrypted"
}

# 主脚本
mode="" #加/解密模式
text="" #明文
shift=0
input_file=""
output_file=""
# 识别bash命令的字符信息
while [[ $# -gt 0 ]]; do
    case "$1" in
        -s)
            text="$2"
            shift 2
            ;;
        -k)
            shift="$2"
            shift 2
            ;;
        -d)
            mode="decrypt"
            shift
            ;;
        -if)
            input_file="$2"
            shift 2
            ;;
        -of)
            output_file="$2"
            shift 2
            ;;
        *)
            echo "Invalid option: $1"
            exit 1
            ;;
    esac
done

if [[ -n "$input_file" ]]; then
    text=$(cat "$input_file")
fi

if [[ "$mode" == "decrypt" ]]; then
    result=$(decrypt "$text" "$shift")
else
    result=$(encrypt "$text" "$shift")
fi

if [[ -n "$output_file" ]]; then
    echo "$result" > "$output_file"
else
    echo "$result"
fi
