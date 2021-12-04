ARG ROS_DISTRO=galactic
FROM tiryoh/ros2-desktop-vnc:${ROS_DISTRO}
ARG ROS_DISTRO

RUN set -x && \
  apt-get update -y -qq && \
  apt-get install -y -qq curl wget && \
  sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list' && \
  wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add - && \
  apt-get update -y -qq && \
  apt-get install -y -qq \
    # ros-${ROS_DISTRO}-rmf-demos-ign \
    ros-${ROS_DISTRO}-rmf-demos-gz \
    python3-pip && \
  apt-get autoremove -y -qq && \
  rm -rf /var/lib/apt/lists/*
RUN set -x && \
  pip install flask-socketio
RUN set -x && \
  # bash -c "source /opt/ros/galactic/setup.bash && ros2 run rmf_building_map_tools building_map_model_downloader /opt/ros/galactic/share/rmf_demos_maps/hotel/hotel.building.yaml -f -e ~/.ignition/"
  bash -c "source /opt/ros/galactic/setup.bash && ros2 run rmf_building_map_tools building_map_model_downloader /opt/ros/galactic/share/rmf_demos_maps/hotel/hotel.building.yaml -f -e ~/.gazebo/models"
