# frozen_string_literal: true
module KubernetesDeploy
  class GenericResource < KubernetesResource
    def sync
      _, _err, st = kubectl.run("get", type, @name)
      @status = st.success? ? "Available" : "Unknown"
      @found = st.success?
    end

    def deploy_succeeded?
      exists?
    end

    def deploy_failed?
      false
    end

    def timeout_message
      UNUSUAL_FAILURE_MESSAGE
    end

    def exists?
      @found
    end
  end
end
