defmodule Pathfinder.CorsPolicy do
  @behaviour :cowboy_cors_policy

  @spec policy_init(:cowboy_req.req()) :: {:ok, :cowboy_req.req(), any}
  def policy_init(req) do
    {:ok, req, :undefined}
  end

  @spec allowed_origins(:cowboy_req.req(), any) :: {:*, any}
  def allowed_origins(_, state) do
    {:*, state}
  end

  @spec allowed_headers(:cowboy_req.req(), any) :: {[binary()], any}
  def allowed_headers(_, state) do
    {[
       "accept",
       "access-control-allow-headers",
       "authorization",
       "content-type",
       "x-request-id",
       "x-requested-with"
     ], state}
  end

  @spec allowed_methods(:cowboy_req.req(), any) :: {[binary], any}
  def allowed_methods(_, state) do
    {["GET", "POST", "PUT", "DELETE", "OPTIONS"], state}
  end
end
