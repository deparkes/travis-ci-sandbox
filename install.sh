        sudo apt-get update
        # You may want to periodically update this, although the conda update
        # conda line below will keep everything up-to-date.  We do this
        # conditionally because it saves us some downloading if the version is
        # the same.
        if [[ "$TRAVIS_PYTHON_VERSION" == "2.7" ]]; then
          wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O miniconda.sh;
        else
          wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh;
        fi
        bash miniconda.sh -b -p $HOME/miniconda
        export PATH="$HOME/miniconda/bin:$PATH"
        hash -r
        conda config --set always_yes yes --set changeps1 no
        conda update -q conda
        # Useful for debugging any issues with conda
        conda info -a

        # Replace dep1 dep2 ... with your dependencies
        conda create -q -n test-environment python=$TRAVIS_PYTHON_VERSION
        conda install -c conda-forge -n test-environment wxpython 
        source activate test-environment
        python --version