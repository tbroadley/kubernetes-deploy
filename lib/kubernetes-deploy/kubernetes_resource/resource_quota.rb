# frozen_string_literal: true
module KubernetesDeploy
  class ResourceQuota < GenericResource
    TIMEOUT = 30.seconds

    def sync
      raw_json, _err, st = kubectl.run("get", type, @name, "--output=json")
      @status = st.success? ? "Available" : "Unknown"
      @found = st.success?
      @rollout_data = if @found
        JSON.parse(raw_json)
      else
        {}
      end
    end

    def deploy_succeeded?
      @rollout_data.dig("spec", "hard") == @rollout_data.dig("status", "hard")
    end
  end
end
