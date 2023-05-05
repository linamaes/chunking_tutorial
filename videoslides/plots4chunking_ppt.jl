"""
## Edu pilot demo
## Script for plotting spatial and box chunks
"""

using PlotlyJS
using DiskArrays
using Images
using FileIO


 chunks = DiskArrays.GridChunks((1000,300,1),(100,60,1))
# size(chunks)
# chunks[1,1,1]
# typeof(chunks)

function spatialchunkfx(chunks::DiskArrays.GridChunks{3})
    
    dims = size(chunks)
    sizein = chunks[1,1,1]
    dim1 = sizein[1][end]
    dim2 = sizein[2][end]
    dim3 = sizein[3][end]
    if dim1<2
            return("The spatial chunk needs one unit dimension in one axis")
    elseif dim2<2
            return("The spatial chunk needs one unit dimension in one axis")
    elseif dim3!=1
            return("The spatial chunk needs one unit dimension in one axis")
    else
               
# define chunk coordinates
x = [1,2,3,4,5] # time steps
y = [0,dim1] # latitude
z = [ # longitude
        [0,dim2],
        [0,dim2]
    ]

colormap = [
    "rgb(230, 230, 20)",
    "rgb(250, 250, 192)",
    "rgb(150, 200, 115)",
    "rgb(200, 200, 50)",
    "rgb(192, 192, 192)",
    "rgb(80, 68, 22)",
    "rgb(222, 205, 135)"
 ]
   
# define each surface, in this example the spatial chunks
trace1 = PlotlyJS.surface(z=z, x=[x[1], x[1]], y=y, showscale=false, colorbar=false,
    colorscale=[[0, colormap[3]], [1, colormap[3]]], opacity=0.85)
trace2 = PlotlyJS.surface(z=z, x=[x[2],x[2]], y=y, showscale=false, colorbar=false,
    colorscale=[[0, colormap[4]], [1, colormap[4]]], opacity=0.85)
trace3 = PlotlyJS.surface(z=z, x=[x[3],x[3]], y=y, showscale=false, colorbar=false,
    colorscale=[[0, colormap[7]], [1, colormap[7]]], opacity=0.85)
trace4 = PlotlyJS.surface(z=z, x=[x[4],x[4]], y=y, showscale=false, colorbar=false,
    colorscale=[[0, colormap[2]], [1, colormap[1]]], opacity=0.85)
trace5 = PlotlyJS.surface(z=z, x=[x[5],x[5]], y=y, showscale=false, colorbar=false,
    colorscale=[[0, colormap[1]], [1, colormap[2]]], opacity=0.85)

config = PlotConfig(
        toImageButtonOptions=attr(
        format="svg", # one of png, svg, jpeg, webp
        filename="custom_image",
        height=500,
        width=700,
        scale=1 # Multiply title/legend/axis/canvas sizes by this factor
        ).fields
            )
    
# set the plot layout
layout = Layout(title_text="Spatial chunking",
    titlefont_size="25",
    showgrid=false, # width=700, height=700,
    layout_scene = "cube",
    scene = attr(xaxis_title="Chunk coord. (Time)", 
        yaxis_title="Chunk coord. (Lon.)", 
        zaxis_title="Chunk coord. (Lat.)",
        xaxis_nticks=5,
        #yaxis_nticks=4,
        zaxis_nticks=4,
        aspectratio=attr(x=0.7, y=1, z=0.65), 
        xaxis=attr(showbackground=false,
            gridcolor="rgb(230, 230, 230)"),
        yaxis=attr(showbackground=false,
            gridcolor="rgb(210, 210, 210)"),
        zaxis=attr(showbackground=false,
            gridcolor="rgb(210, 210, 210)", zerolinecolor="rgb(0, 0, 0)"),            
        aspectmode = "manual", zeroline=false),
    plot_bgcolor="#E5E5E5", paper_bgcolor="white",font_size=13,
    config=config)
    
    # plot
    p1 = PlotlyJS.plot([trace1, trace2, trace3, trace4, trace5], layout);
    PlotlyJS.savefig(p1, "img1.png", format="png")
    img = load(string("img1.png"));
    return(img)
     end    
end


# spatialchunkfx(chunks)
# size(chunks)
# chunks[1,1,1]
# typeof(chunks)


function boxchunkfx(chunks::DiskArrays.GridChunks{3})
    # define cube facet colors
    facecolor = repeat([
    	"rgb(250, 250, 250)",
    	"rgb(192, 192, 192)",
    	"rgb(150, 200, 115)",
    	"rgb(200, 200, 50)",
    	"rgb(230, 230, 20)",
        "rgb(230, 230, 10)"
    	#"rgb(255, 140, 0)"
    ], inner=[2])

    dims = size(chunks)
    if dims[1]<2
            return("The box chunk needs more than one unit dimension in all axes")
    elseif dims[2]<2
            return("The box chunk needs more than one unit dimension in all axes")
    elseif dims[3]<2
            return("The box chunk needs more than one unit dimension in all axes")
    else
        #     return("Box chunk") 
    
    
    sizein = chunks[1,1,1]
    dim1 = sizein[1][end]
    dim2 = sizein[2][end]
    dim3 = sizein[3][end]
    
    
    # for better illustration we ommit 10% of the actual chunck size

    z = Int(round(dim1*0.9))
    y = Int(round(dim2*0.9))
    x = Int(round(dim3*0.9))
    
    # initial chunk coordinates
    x0 = [1, 1, x, x, 1, 1, x, x]
    y0 = [1, y, y, 1, 1, y, y, 1]
    z0 = [1, 1, 1, 1, z, z, z, z] 

    # connections
    i0 = [7, 0, 0, 0, 4, 4, 2, 6, 4, 0, 3, 7]
    j0 = [3, 4, 1, 2, 5, 6, 5, 5, 0, 1, 2, 2]
    k0 = [0, 7, 2, 3, 6, 7, 1, 2, 5, 5, 7, 6]
        
    t1 = PlotlyJS.mesh3d( x=x0, y=y0,z=z0,
        i=i0, j=j0, k=k0, facecolor=facecolor, opacity=1)
  
    t2 = PlotlyJS.mesh3d(
        x=x0, y=map(x->x+dim2, y0), z=z0,
        i=i0, j=j0, k=k0, facecolor=facecolor, opacity=1)

    t3 = PlotlyJS.mesh3d(
        x=x0, y=map(x->x+(dim2*2), y0), z=z0,
        i=i0, j=j0, k=k0, facecolor=facecolor, opacity=1)  
    
    t4 = PlotlyJS.mesh3d(
            x=x0, y=map(x->x+(dim2*3),y0), z=z0,
            i=i0, j=j0, k=k0, facecolor=facecolor, opacity=1)    

    t5 = PlotlyJS.mesh3d(
            x=map(x->x+dim3,x0), y=y0, z=z0,
            i=i0, j=j0, k=k0, facecolor=facecolor, opacity=1)    

    t6 = PlotlyJS.mesh3d(
            x=map(x->x+dim3,x0), y=map(x->x+dim2,y0), z=z0,
            i=i0, j=j0, k=k0, facecolor=facecolor, opacity=1)    

    t7 = PlotlyJS.mesh3d(
            x=map(x->x+dim3,x0), y=map(x->x+(dim2*2),y0), z=z0,
            i=i0, j=j0, k=k0, facecolor=facecolor, opacity=1)
                
    t8 = PlotlyJS.mesh3d(
            x=map(x->x+dim3,x0), y=map(x->x+(dim2*3),y0), z=z0,
            i=i0, j=j0, k=k0, facecolor=facecolor, opacity=1)  
          
    t9 = PlotlyJS.mesh3d(
            x=x0, y=y0, z=map(x->x+dim1,z0),
            i=i0, j=j0, k=k0, facecolor=facecolor, opacity=1)    
    t10 = PlotlyJS.mesh3d(
            x=x0, y=map(x->x+dim2,y0), z=map(x->x+dim1,z0),
            i=i0, j=j0, k=k0, facecolor=facecolor, opacity=1)    
        
    t11 = PlotlyJS.mesh3d(
            x=x0, y=map(x->x+(dim2*2),y0), z=map(x->x+dim1,z0),
            i=i0, j=j0, k=k0, facecolor=facecolor, opacity=1)    
    
    t12 = PlotlyJS.mesh3d(
            x=x0, y=map(x->x+(dim2*3),y0), z=map(x->x+dim1,z0),
            i=i0, j=j0, k=k0, facecolor=facecolor, opacity=1)    
        
    t13 = PlotlyJS.mesh3d(
            x=map(x->x+dim3,x0), y=y0, z=map(x->x+dim1,z0),
            i=i0, j=j0, k=k0, facecolor=facecolor, opacity=1)    
    
    t14 = PlotlyJS.mesh3d(
            x=map(x->x+dim3,x0), y=map(x->x+dim2,y0), z=map(x->x+dim1,z0),
            i=i0, j=j0, k=k0, facecolor=facecolor, opacity=1)    
    
    t15 = PlotlyJS.mesh3d(
            x=map(x->x+dim3,x0), y=map(x->x+(dim2*2),y0), z=map(x->x+dim1,z0),
            i=i0, j=j0, k=k0, facecolor=facecolor, opacity=1)    
    
    t16 = PlotlyJS.mesh3d(
            x=map(x->x+dim3,x0), y=map(x->x+(dim2*3),y0), z=map(x->x+dim1,z0),
            i=i0, j=j0, k=k0, facecolor=facecolor, opacity=1)    

            
config = PlotConfig(
        toImageButtonOptions=attr(
        format="svg", # one of png, svg, jpeg, webp
        filename="custom_image",
        height=500,
        width=700,
        scale=1 # Multiply title/legend/axis/canvas sizes by this factor
        ).fields
            )

    layout = Layout(title_text="Box chunking",
        titlefont_size="25",
        scene=attr(
        xaxis_title="Chunk coord. (Time)", 
        yaxis_title="Chunk coord. (Lon.)", 
        zaxis_title="Chunk coord. (Lat.)",
        xaxis_nticks=4,
        #yaxis_nticks=4,
        zaxis_nticks=4,
        aspectratio=attr(x=0.7, y=1, z=0.65), 
        xaxis=attr(showbackground=false,
            gridcolor="rgb(230, 230, 230)", zerolinecolor="rgb(210, 210, 210)",
            backgroundcolor="rgb(255, 255, 255)"),
        yaxis=attr(showbackground=false,
            gridcolor="rgb(210, 210, 210)", zerolinecolor="rgb(210, 210, 210)",
            backgroundcolor="rgb(255, 255, 255)"),
        zaxis=attr(showbackground=true,
            gridcolor="rgb(210, 210, 210)", zerolinecolor="rgb(0, 0, 0)",
            backgroundcolor="rgb(255, 255, 255)"),
        aspectmode = "manual"))
        p2 = PlotlyJS.plot([t1, t2, t3, t4, t5, t6, t7, t8, 
        t9,t10, t11, t12, t13, t14, t15, t16], layout, 
        config=config) #, PlotConfig(staticPlot=true, responsive=false));
        PlotlyJS.savefig(p2, "img2.png", format="png")
        img = load(string("img2.png"))
        #display(p2)
        return(img)        
        end
end

using CairoMakie, GeoMakie
Makie.theme(:fonts)

function timeseriesfx(xin, ymin, ymax, titlen)
    f = Figure(fontsize = 25, fonts = (; regular = "Dejavu"))
    ax = Makie.Axis(f[1, 1],
        title = titlen,
        xlabel = "Time (Month-Year)",
        ylabel = "Air temperature (°C)",
        limits = (nothing, (ymin, ymax)),
        xlabelsize=25, ylabelsize=25
    ) 
    ax.xticks = (1:20:460, string.(tax2)[1:20:460])
    ax.xticklabelrotation = π/2
    lines!(ax, 1:460, xin, linewidth=2.5, color=:orange)
    return(f)
    end

function geoplotsfx(xin, titlen)
    lons = -180:0.25:180
    lats = -90:0.25:90
    fig = Figure(fontsize = 18, fonts = (; regular = "Dejavu"))
    ax = GeoAxis(fig[1,1]; coastlines = true, 
    title = titlen,
    xlabelsize=20, ylabelsize=20)
    sf = GeoMakie.surface!(ax, lons, lats, xin; shading = false,
    colormap = (Reverse(:roma), 0.95,), colorrange=(-40,40))
    cb1 = Colorbar(fig[1,2], sf; label = "Air temperature (°C)", height = Relative(0.65))
    return(fig)
end

using Pkg.Artifacts
function Pkg.Artifacts.find_artifacts_toml(path::String)
    if !isdir(path)
        path = dirname(path)
    end
    # Run until we hit the root directory.
    while dirname(path) != path || isempty(path)
        for f in Pkg.Artifacts.artifact_names
            artifacts_toml_path = joinpath(path, f)
            if isfile(artifacts_toml_path)
                return abspath(artifacts_toml_path)
            end
        end

        # Does a `(Julia)Project.toml` file exist here, in the absence of an Artifacts.toml?
        # If so, stop the search as we've probably hit the top-level of this package,
        # and we don't want to escape out into the larger filesystem.
        for f in Base.project_names
            if isfile(joinpath(path, f))
                return nothing
            end
        end

        # Move up a directory
        path = dirname(path)
    end

    # We never found anything, just return `nothing`
    return nothing
end