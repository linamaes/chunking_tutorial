"""
## Edu pilot demo
## Script for plotting box chunks
"""

using PlotlyJS
using DiskArrays
using Images
using FileIO

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

# img = load(string(pwd(),"/NFDI4Earth/v002/","test3.png"))
# save(string(tempname(),".png"), img)
# try1 = load(string(tempname(),".png"))
# PlotlyJS.savefig(img, "test4.png", format="png")


#chunks = DiskArrays.GridChunks((100,300,400),(30,60,3))
# # size(chunks)
# # chunks[1,1,1]
# # typeof(chunks)
#test = boxchunkfx(chunks)
# display(test)



# # plot(rand(10, 4), Plotconfig=Dict(:staticPlot => true))

# pwd()

