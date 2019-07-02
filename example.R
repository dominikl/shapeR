library(shapeRO)
library(romero.gateway)

# ID of the project in OMERO
# (needs the CSV file attached to it, or alternatively
# specify a CSV file annotation with csv_file_id parameter)
projId <- 1458

server <- OMEROServer(host = "localhost", username = "user", password = "xyz")
server <- connect(server)

proj <- loadObject(server, "ProjectData", projId)

shape <- shapeR(project = proj)
shape <- detect.outline(shape, create_rois = FALSE)

shape <- generateShapeCoefficients(shape)
shape <- enrich.master.list(shape)

# Attach the results as CSV to the Project:
#csvFile <- "/tmp/Results_from_shapeR.csv"
#write.csv(shape@master.list, file = csvFile)
#attachFile(proj, csvFile)

# Attach the results as OMERO table to the Project:
results <- na.omit(shape@master.list)
attachDataframe(proj, results, "Results from shapeR")

# Workaround to set the namespace, which makes it
# directly usable by OMERO.parade
gateway <- getGateway(server)
ctx <- getContext(server)
dm <- gateway$getFacility(DataManagerFacility$class)
dataframes <- availableDataframes(proj)
apply(dataframes, 1, function(d) {
  fa <- loadObject(server, "omero.gateway.model.FileAnnotationData", as.integer(d['AnnotationID']))
  ns <- fa@dataobject$getNameSpace()
  if (length(ns)==0) {
    fa@dataobject$setNameSpace("openmicroscopy.org/omero/bulk_annotations")
    fa <- dm$saveAndReturnObject(ctx, fa@dataobject)
  }
})

# Disconnect again
disconnect(server)

