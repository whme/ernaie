from setuptools impor setup, find_packages


if __name__ == "__main__":

    setup(
        name="ernaie",
        version="0.0.1a0",
        author="whme",
        author_email="whme@bashless.de",
        description="The telperi language",
        include_package_data=True,
        packages=find_packages(),
        zip_safe=False
    )
