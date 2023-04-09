# Latex CV Generator

Latex-cv-gen is a latex cv generator that uses `Jinja2` for templating. It allows the user to generate `se-resume` (but really any latex cv if you provide your own template) using a `json` or `yaml` (also `yml`) file containing contents to be generated as the `cv`.

If the user provides a json file, the file is validated against a schema that includes everything that's expected in the json body. At the moment of writing this, all fields are mandatory. A less stringent measure is applied if a yaml file is supplied instead and no schema validation is done.