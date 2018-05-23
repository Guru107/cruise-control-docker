FROM openjdk:8-jdk

ARG commit=589b06cd9059beb1c3c8e3981a2ebef5c82fca0e

RUN cd /home && git clone https://github.com/linkedin/cruise-control.git && cd cruise-control && git checkout ${commit}
WORKDIR /home/cruise-control

VOLUME ["./config","./logs"]

RUN ./gradlew jar copyDependantLibs
EXPOSE 9090
ENTRYPOINT [ "./kafka-cruise-control-start.sh" ]
CMD ["config/cruisecontrol.properties"]