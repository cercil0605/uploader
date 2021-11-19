require 'digest'

digest=Digest::SHA256.file("aaa.png")
a=(digest.hexdigest.to_i(16)).to_s(2) #10進数に変換してからさらに2進数に変換する
c=(a[1,32]).to_i(2) #先頭32bitをとる、そして10進数に戻す
print(c)

