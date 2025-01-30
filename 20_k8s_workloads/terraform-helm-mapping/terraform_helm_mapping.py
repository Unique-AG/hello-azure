import os
import json
import argparse
import logging
from jinja2 import Environment, FileSystemLoader, TemplateError
from typing import Dict

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(levelname)s: %(message)s')

def load_terraform_outputs(terraform_output_path: str) -> Dict[str, any]:
    """Load and parse the Terraform outputs from a JSON file."""
    if not os.path.exists(terraform_output_path):
        logging.error(f"Terraform output file '{terraform_output_path}' does not exist.")
        raise FileNotFoundError(terraform_output_path)

    try:
        with open(terraform_output_path) as f:
            terraform_outputs = json.load(f)
        return {key: value['value'] for key, value in terraform_outputs.items()}
    except json.JSONDecodeError as e:
        logging.error(f"Failed to decode JSON from '{terraform_output_path}': {e}")
        raise

def render_template(template_file: str, template_values: Dict[str, any]) -> str:
    """Render a Jinja2 template with the provided values."""
    template_dir = os.path.dirname(template_file)
    template_name = os.path.basename(template_file)

    try:
        env = Environment(loader=FileSystemLoader(template_dir))
        template = env.get_template(template_name)
        return template.render(template_values)
    except TemplateError as e:
        logging.error(f"Jinja2 template error: {e}")
        raise

def save_rendered_yaml(output_yaml_path: str, rendered_yaml: str) -> None:
    """Save the rendered YAML to a file."""
    try:
        with open(output_yaml_path, 'w') as f:
            f.write(rendered_yaml)
        logging.info(f"YAML file generated successfully at '{output_yaml_path}'.")
    except IOError as e:
        logging.error(f"Failed to write YAML to '{output_yaml_path}': {e}")
        raise

def generate_yaml(terraform_output_path: str, template_file: str, output_yaml_path: str) -> None:
    """Generate a YAML file from Terraform outputs using a Jinja2 template."""
    try:
        template_values = load_terraform_outputs(terraform_output_path)
        rendered_yaml = render_template(template_file, template_values)
        save_rendered_yaml(output_yaml_path, rendered_yaml)
    except Exception as e:
        logging.error(f"An unexpected error occurred: {e}")

def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    helmfiles_dir = os.path.join(script_dir, os.path.pardir, 'helm')

    default_terraform_output_path = os.path.join(script_dir, 'terraform_output.json')
    default_template_file = os.path.join(helmfiles_dir, 'terraform-outputs.yaml.jinja')
    default_output_yaml_path = os.path.join(helmfiles_dir, 'terraform-outputs.yaml')

    parser = argparse.ArgumentParser(description='Generate YAML from Terraform outputs using a Jinja2 template.')
    parser.add_argument('--terraform-output-path', type=str, default=default_terraform_output_path,
                        help='Path to the Terraform output JSON file (default: %(default)s)')
    parser.add_argument('--template-file', type=str, default=default_template_file,
                        help='Path to the Jinja2 template file (default: %(default)s)')
    parser.add_argument('--output-yaml-path', type=str, default=default_output_yaml_path,
                        help='Path to the output YAML file (default: %(default)s)')

    args = parser.parse_args()

    generate_yaml(args.terraform_output_path, args.template_file, args.output_yaml_path)

if __name__ == '__main__':
    main()
