+++
title = "Typst, det nye skrivesystem"
date = 2025-01-22
+++

Jeg er gået over til at bruge Typst i stedet for LaTeX. 

Hvis du gerne vil have Typst koden til at genskrive f.eks. en opgave, så kan du bruge Mathpix til at få LaTeX koden. Dernæst kan Pandoc oversætte fra LaTeX til Typst med

```powershell
> Get-Clipboard | pandoc -f latex -t typst
```

```bash
$ wl-paste | pandoc -f latex -t typst
```

Gennem universitet har jeg det dobbelte antal gratis daglige skanninger.
