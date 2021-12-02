
packagepath() = joinpath(@__DIR__,"..")
urdfpath() = joinpath(packagepath(), "models", "bob.urdf")
left_joint = nothing 
right_joint = nothing 
neck_joint = nothing
dimensions = SVector(0.3, 0.6, 0.3)


function default_background!(mvis)
    vis = mvis.visualizer
    setvisible!(vis["/Background"], true)
    setprop!(vis["/Background"], "top_color", RGBA(1.0, 1.0, 1.0, 1.0))
    setprop!(vis["/Background"], "bottom_color", RGBA(1.0, 1.0, 1.0, 1.0))
    setvisible!(vis["/Axes"], false)
end


function load_bob()
    robot = RigidBodyDynamics.parse_urdf(urdfpath(); floating=true) 
    vis = Visualizer()
    mvis = MechanismVisualizer(robot, URDFVisuals(urdfpath(), package_path=[packagepath()]))  
    state = rbd.MechanismState(robot)
    default_background!(mvis)
    settransform!(vis["world/base"], Translation(0.0,0.0,0.15))
    settransform!(vis["/Cameras/default"],
            compose(Translation(0.0, 0.0, 3.0), LinearMap(RotY(-pi  )))) 
    bobby = Robot([0.,0.,0.], [0.,0.,0.], [0.,0.,0.], [0.,0.,0.], 0.01, 0.3,
                 robot, mvis, state )
    return bobby 
end

