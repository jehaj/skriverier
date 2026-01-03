# Copilot Instructions for Skriverier

This project is a personal blog built with the Hugo Static Site Generator.

## Architecture & Structure
- **Content**: Located in [content/posts/](content/posts/).
- **Multilingual**: Supports Danish (`dk`) and English (`en`).
    - Danish (default): `filename.md`
    - English: `filename.en.md`
- **Layouts**: Custom HTML templates in [layouts/](layouts/).
- **Assets**: CSS and JS are in [assets/](assets/), processed via Hugo Pipes.

## Project Conventions
- **Language**: The primary language is Danish. Prefer Danish terminology over English loanwords (e.g., use "statiske sider" instead of "static sites" where appropriate).
- **Front Matter**: Use TOML format (`+++`) for all content files.
- **Math Rendering**:
    - Uses KaTeX via Hugo's `transform.ToMath` (see [layouts/_default/_markup/render-passthrough.html](layouts/_default/_markup/render-passthrough.html)).
    - Delimiters: `\[ ... \]` or `$$ ... $$` for block math, `\( ... \)` for inline math.
    - KaTeX CSS and fonts are manually managed and ignored by git. Do not attempt to "fix" missing KaTeX files unless specifically asked.

## Developer Workflows
- **Development**: Run `hugo server -D` to preview with drafts.
- **New Post**: Use `hugo new posts/my-new-post.md`. Remember to create the English version `my-new-post.en.md` if needed.
- **KaTeX Updates**: Follow instructions in [README.md](README.md) for manual KaTeX asset management.

## Key Files
- [hugo.toml](hugo.toml): Main configuration.
- [layouts/_default/baseof.html](layouts/_default/baseof.html): Base template.
- [assets/css/main.css](assets/css/main.css): Main stylesheet.
