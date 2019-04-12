# Use Raspbian stretch as base image
FROM niekvb/python-3.7.3:raspbian-stretch

# Install prerequisites for compiling OpenCV 3.4.3
RUN apt-get update && apt-get install -y build-essential cmake pkg-config libjpeg-dev libtiff5-dev libjasper-dev \
  libpng12-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev && apt-get \
  install -y libgtk2.0-dev libgtk-3-dev libatlas-base-dev gfortran
RUN pip3.7 install numpy scipy

# Download and extract OpenCV source
WORKDIR /usr/src/opencv/
RUN wget https://github.com/opencv/opencv/archive/3.4.3.tar.gz && tar xzf 3.4.3.tar.gz

# Compile OpenCV source code
WORKDIR /usr/src/opencv/opencv-3.4.3/build/
RUN cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D INSTALL_PYTHON_EXAMPLES=ON \
  -D BUILD_EXAMPLES=ON ..

# Build and install OpenCV
RUN make -j4 && make install && ldconfig

# Remove OpenCV source code
RUN rm -R /usr/src/opencv/

CMD ["/bin/echo", "Entrypoint is undefined! Use this image as base for other Docker images..."]
