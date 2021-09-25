# Docker image

I made a docker image containing CoppeliaSim v4 EDU over a ros-noetic base image, to make it quicker to start working on the Flexible Automation labs. The image is automatically pulled by the bash scripts here presented, so you theoretically don't have to worry about it. For any issue with it simply open an issue post here on GitHub and I'll go on and do my best to fix it.

# How to use

All the scripts needed to launch the docker container are placed in the `scripts` folder. The `run_wsl.sh` script here presented is intended to use in a **WSL2** environment, while the `run_unix.sh` is intended to be used in a **Unix** system: both of them require `nvidia-container-toolkit`, NVIDIA CUDA acceleration enabled [1] and Docker version > 19.03. It runs a **new** container each time: remember that once you remove a container, all data not saved/exported somewhere **will be lost**. It can be simply launched with
```bash
bash run_<your-system-type>.sh
```

My suggestion is to save all your progresses in a github repo, making sure to keep it updated and re-pulling it in new containers.
Or you could always work in the same container, stopping it without removing it, and re-starting it with
```bash
docker start <your-container-name>
```
which is a workflow I would personally try to avoid.

Moreover, since this docker image does not contain a GUI, an XServer should be installed in the Windows host machine [2].
The `run_wsl.sh` script takes care of exporting the DISPLAY address of the XServer to the new container; if, instead, you want to always work in the same container, please notice your WSL address will change at each system boot, so you would need to manually export the new DISPLAY environment variable each time in the "old container" shell. Take note of that address value by running in a WSL window the following command
```bash
echo $(grep nameserver /etc/resolv.conf | awk '{print $2}'):0.0
```
and then, in your running "old container" simply run
```bash
export DISPLAY=<wsl-ip-value>
```

It's surely a bit more cumbersome IMHO... but you do you!

> [1] see [CUDA on WSL](https://docs.nvidia.com/cuda/wsl-user-guide/index.html) for info on how to install the necessary toolset

> [2] the one I personally use is [VcXsrv](https://sourceforge.net/projects/vcxsrv/), be sure to **select** *Disable access control* and **deselect** *Native opengl* in the third step of the launch wizard.

# WSL GUI Notes

On WSL the audio is exported using the new features of WSLg, included with the latest version of WSL (try to update it if you do not see it yet). While WSLg should theoretically also implement a sort of XServer, making the need of a third-party one superfluous, in my experience at the time of writing that solution presents issues when interfacing with a docker container, making windows unresponsive or crashing. Therefore, until a solution to that issue arise, an external XServer is still suggested.