import json
from pathlib import Path
import sys
from typing import Any
from jinja2 import Environment, FileSystemLoader, Template
import yaml
from jsonschema import validate


TEMPLATE = "template.jinja"
TEMPLATE_BASE_DIR = "templates"
RESUME_BODY = "resources/resume.json"
JSON_SCHEMA = "resources/schema.json"
OUTPUT_PATH = "output/main.tex"

TEMPLATE_OPT = {
    "variable_start_string": "$placeholder{",
    "variable_end_string": "}",
    "trim_blocks": True,
    "lstrip_blocks": True,
}


class LatexGen:
    def __init__(
        self,
        resume: str = None,
        template_dir: str = None,
        template_path: str = None,
        out: str = None,
    ) -> None:
        self.resume_body = resume or RESUME_BODY
        self.template = template_path or TEMPLATE
        self.template_dir = template_dir or TEMPLATE_BASE_DIR
        self.output = out or OUTPUT_PATH

    # def template_type(self):
    #     pass

    def validate_json(self) -> None:
        read_schema = self.read_file(JSON_SCHEMA)
        resume_instance = self.read_file(self.resume_body)
        validate(instance=resume_instance, schema=read_schema)

    def validate_file(self) -> Any:
        if not Path(self.resume_body).exists():
            raise FileNotFoundError(f"File {self.resume_body} does not exist.")
        file_ext = Path(self.resume_body).suffix
        if file_ext not in (".json", ".yaml", ".yml"):
            raise TypeError(f"File type '{file_ext}' is not currently supported.")

    @staticmethod
    def read_file(file_path) -> Any:
        try:
            with open(file_path, encoding="utf-8") as f:
                return (
                    json.load(f)
                    if Path(file_path).suffix == ".json"
                    else yaml.safe_load(f)
                )
        except ValueError:
            sys.exit("Input file is not a valid JSON/YAML.")

    def build_template(self) -> Template:
        env = Environment(
            loader=FileSystemLoader(Path(self.template_dir).resolve()), **TEMPLATE_OPT
        )
        return env.get_template(self.template)

    def render(self) -> None:
        # check that file excist and the file is a supported type
        self.validate_file()
        context = self.read_file(self.resume_body)
        print(context)
        content = self.build_template().render(context)
        with open(self.output, "w") as f:
            f.write(content)


if __name__ == "__main__":
    LatexGen().render()
    print("complete....")
