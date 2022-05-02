#!/usr/bin/env coffee

全角半角 = '，,：:？?、/！!。.¥$￥$（(）)【[】]　 「\'」\'‘\'’\'『"』"“"”"《<》>「{」}'

len = 全角半角.length
i = 0

映射 = new Map()

while i<len
  映射.set(
    全角半角[i++]
    全角半角[i++]
  )


export default 映射

###
if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  for [k,v] from 映射.entries()
    console.log k,'→',v,k==v
  process.exit()
###
