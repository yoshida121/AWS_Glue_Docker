FROM amazon/aws-glue-libs:glue_libs_2.0.0_image_01

COPY ./requirements.txt /work/requirements.txt
RUN python3 -m pip install --no-cache-dir -r /work/requirements.txt

ENV PATH $PATH:/home/aws-glue-libs/bin/:/usr/share/maven/bin:${SPARK_HOME}/bin/
ENV PYTHONPATH $PYTHONPATH:/home/jupyter/jupyter_default_dir

# PySparkからjupyter labを起動するためのオプション設定
ENV PYSPARK_DRIVER_PYTHON jupyter
ENV PYSPARK_DRIVER_PYTHON_OPTS ' lab --allow-root --NotebookApp.token="" --NotebookApp.password="" --no-browser --ip=0.0.0.0'

RUN mkdir /home/glue_user/workspace/.aws
COPY .aws/config /home/glue_user/workspace/.aws/
# RUN chmod 600  /home/glue_user/workspace/.aws/config
COPY .aws/credentials /home/glue_user/workspace/.aws/
# RUN chmod 600  /home/glue_user/workspace/.aws/credentials