FROM ros:noetic-ros-base-focal

LABEL maintainer="Marco Gabriele Fedozzi <5083365@studenti.unige.it>"

ENV HOME=/root
ENV ROS_WS=${HOME}/ws
RUN mkdir -p $ROS_WS/src

SHELL ["/bin/bash", "-c"]
USER root

# Build and source your ros packages 
WORKDIR $ROS_WS
# Install catkin_tools
RUN apt-get update && apt-get install git curl wget qt5-default -y
# install CoppeliaSim from tar
COPY *.tar.xz ${HOME}
WORKDIR ${HOME}
RUN tar -xf *.tar.xz && rm *.tar.xz

# Initialize the workspace
WORKDIR $ROS_WS
RUN source /opt/ros/noetic/setup.bash && \
		catkin_make \
    && echo "source ${ROS_WS}/devel/setup.bash" >> ${HOME}/.bashrc \
		&& echo "source /opt/ros/noetic/setup.bash" >> ${HOME}/.bashrc 

RUN source ${HOME}/.bashrc && rosdep update && rosdep install --from-paths src --rosdistro noetic --ignore-src -y

ENTRYPOINT ["bash"]