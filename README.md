# mktat2
Build a Docker container to run the iron processing


First run ./mkbasedockerfile to generate a Docker file with neurodocker including FSL, ANTs, and a python environment including s3fs and awscli.

Then run ./buildbase.sh to make the base container.

Finally, run ./buildtat2.sh to make the final container.
