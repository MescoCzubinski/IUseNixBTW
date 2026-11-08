{ pkgs, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
    loadModels = [ "qwen3.5:9b" "gemma4:e4b" ];
    environmentVariables = {
      OLLAMA_FLASH_ATTENTION = "1";
      OLLAMA_KV_CACHE_TYPE = "q8_0";
      OLLAMA_CONTEXT_LENGTH = "65536";
      OLLAMA_MAX_LOADED_MODELS = "1";
    };
  };

  environment.systemPackages = [ pkgs.alpaca ];
}
