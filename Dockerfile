# docker build ./ -t hirano_v1
# docker run --gpus all -it --privileged --name hirano_v1 -p hirano_v1 /bin/bash

FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04

LABEL maintainer="Admin <admin@admin.com>"

CMD echo "now running..."

RUN apt-get update -y
RUN apt-get install -y vim git curl wget tmux openssh-server sudo
RUN apt-get install -y net-tools

# ssh
RUN mkdir /var/run/sshd
RUN echo 'root:kkk' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN git clone git://github.com/yyuu/pyenv.git ~/.pyenv
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
RUN echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc

RUN mkdir -p /usr/local/etc/bash_completion.d
RUN wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh 
RUN wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
RUN mv git-prompt.sh /usr/local/etc/bash_completion.d/
RUN mv git-completion.bash /usr/local/etc/bash_completion.d/

RUN git clone https://github.com/hkthirano/env.git
RUN mv env/.bash_profile /root/
RUN mv env/.tmux.conf /root/
RUN mv env/.vimrc /root/

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
