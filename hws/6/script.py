from textwrap import fill

for block in range(32):
    print(f"mux32 OUT_BLOCK_{block} (")
    ins = ["0" for _ in range(32)]
    for i in range(0, block + 1):
        ins[i] = f"in[{block - i}]"
    ins = [f".in{i}({n})" for i, n in enumerate(ins)]
    ins.append(".switch(shamt)")
    ins.append(f".out(out[{block}])")
    s = ", ".join(ins)
    print(fill(s, width=80))
    print(");")
    print()
