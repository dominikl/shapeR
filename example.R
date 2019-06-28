library(shapeRO)
library(romero.gateway)

# ID of the project in OMERO
projId <- 1458

# File(!) ID of the CSV file
csvId <- as.integer(295329)

server <- OMEROServer(host = "localhost", username = "user", password = "xyz")
server <- connect(server)

proj <- loadObject(server, "ProjectData", projId)

shape <- shapeR(project = proj, csv_file_id = csvId)
shape <- detect.outline(shape, create_rois = TRUE)

shape <- generateShapeCoefficients(shape)
shape <- enrich.master.list(shape)

# Attach the results to the Project:
csvFile <- "/tmp/Results.csv"
write.csv(shape@master.list, file = csvFile)
attachFile(proj, csvFile)

# Disconnect again
disconnect(server)
