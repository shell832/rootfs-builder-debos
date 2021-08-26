pipeline {
  agent none
  options {
    buildDiscarder(logRotator(artifactNumToKeepStr: '30', numToKeepStr: '180'))
  }
  stages {
    stage('focal') {
      agent { label 'debos-amd64' }
      steps {
        sh './debos-podman focal/ubuntu-touch-hybris-rootfs.yaml --fakemachine-backend=kvm -m 2G --scratchsize 10G --cpus $(nproc --all) -e "http_proxy:http://$(ip route get 8.8.8.8 | head -1 | cut -d\' \' -f7):3142"'
        // NEEDS /etc/apt-cacher-ng/99-ubports.conf!
        archiveArtifacts(artifacts: ["*.tar.gz"], fingerprint: true, onlyIfSuccessful: true)
      }
    }
  }
  post {
    // Clean after build
    always {
      cleanWs(cleanWhenNotBuilt: false,
              deleteDirs: true,
              disableDeferredWipeout: true,
              notFailBuild: false)
    }
  }
}
