# # from distutils.core import setup
# # from distutils.extension import Extension
# # from Cython.Distutils import build_ext

# # ext_modules = [Extension("helloworld", ["helloworld.pyx"])]

# # setup(
# #     name='Dhanrakshak',
# #     cmdclass={'build_ext': build_ext},
# #     ext_modules=ext_modules
# # )
# # coding: utf-8
# import os

# from setuptools import setup, find_packages

# from Cython.Build import cythonize


# EXCLUDE_FILES = [
#     './Dhanrakshak.py'
# ]


# def get_ext_paths(root_dir, exclude_files):
#     """get filepaths for compilation"""
#     paths = []

#     for root, dirs, files in os.walk(root_dir):
#         for filename in files:
#             if os.path.splitext(filename)[1] != '.py':
#                 continue

#             file_path = os.path.join(root, filename)
#             if file_path in exclude_files:
#                 continue

#             paths.append(file_path)
#     return paths


# setup(
#     name='Dhanrakshak',
#     version='0.1.0',
#     packages=find_packages(),
#     ext_modules=cythonize(
#         get_ext_paths('.', EXCLUDE_FILES),
#         compiler_directives={'language_level': 3}
#     )
# )
from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
ext_modules = [
    Extension("ir",  ["helpers/sensors/ir.py"]),
    Extension("level_sensor",  ["helpers/sensors/level_sensor.py"]),
    Extension("limit_switch",  ["helpers/sensors/limit_switch.py"]),
    Extension("stepper",  ["helpers/sensors/stepper.py"]),
    Extension("relay",  ["helpers/sensors/relay.py"]),
    Extension("note_manager",  ["helpers/managers/note_manager.py"]),
    Extension("coin_manager",  ["helpers/managers/coin_manager.py"]),
    Extension("config",  ["helpers/config.py"]),
    Extension("detector", ["helpers/detector.py"]),

]
setup(
    name='Dhanrakshak',
    cmdclass={'build_ext': build_ext},
    ext_modules=ext_modules
)
