# Skriverier
Dette repositorium indeholder mine tanker og skriverier, der endnu er i gang med at blive ordentligt udtænkt.

Jeg vil stræbe efter at skriverierne er tilgængelige på både dansk og engelsk, men mit fokus er først og fremmest på dansk. Jeg kan godt lide at bruge danske gloser i stedet for at blande dansk og engelsk. Det betyder også, at jeg nogle gange kommer til at fordanske ting, hvor man nok bare vil (og burde) låne det engelske udtryk. Det danske sprog har allerede indkorporeret flere engelske udtryk, men jeg vil prøve at bruge en mere dansk-agtig glose. Det er vel sådan man ændrer sproget.

Strukturen af dette repositorium er sat op til at følge strukturen nødvendig for Hugo. Det er en Static Site Generator (SSG) (generator til statiske sider -- her har jeg allerede fejlet) meget magen til Zola og Jekyll.

Skriverierne bliver derfor tilføjet under `content/posts/`, hvor der til hvert skriveri vil være en dansk udgave `skriveri.md` og en engelsk udgave `skriveri.en.md`.

# Katex
Hent den nyeste udgave fra https://github.com/KaTeX/KaTeX/releases. Pak det ud og læg `katex.min.css` filen så den kan findes på `.../css/katex.min.css` og skrifttyperne (i folderen `fonts`) `.../fonts/...`. I `.css` filen forventes en relativ url. Det skal ændres for at det virker. (Man burde overveje at ændre dette, det skrifttyperne udelukkende er til Katex.) Så `url(fonts/...)` skal blive til `url(/fonts/...)`.
