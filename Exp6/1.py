def decrypt(ciphertext, n):
    decrypted = []
    for char in ciphertext:
        if char.isalpha():
            offset = 65 if char.isupper() else 97
            decrypted.append(chr((ord(char) - offset - n) % 26 + offset))
        else:
            decrypted.append(char)
    return ''.join(decrypted)

ciphertext = """Yfqp nx hmjfu
Bmjwj ymjwj nx f xmjqq ymjwj nx f bfd
Xmtb rj ymj htij"""

n = 5
print(decrypt(ciphertext, n))
