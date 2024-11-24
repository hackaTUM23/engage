from argparse import Namespace
import yaml

class ConfigManager:
    _config = None

    @classmethod
    def get_config(cls, file_path="config.yaml"):
        if cls._config is None:
            with open(file_path, 'r') as file:
                cls._config = yaml.safe_load(file)
        print(cls._config)
        return Namespace(**cls._config)