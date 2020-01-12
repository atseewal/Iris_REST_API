#' Echo the parameter that was sent it
#' @param msg The message to echo back.
#' @get /echo

function(msg = "") {
	list(msg = paste0("The message is: '", msg, "'"))
}

#' Plot out data from the iris dataset
#' @param spec If provided, filter the data to noly this species (e.g. 'setosa')
#' @get /plot
#' @png

function(spec) {
	myData <- iris
	title <- "All Species"
	
	# Filter if the species was specified
	if(!missing(spec)) {
		title <- paste0("Only the '", spec, "' Species")
		myData <- subset(iris, Species == spec)
	}
	
	plot(
		myData$Sepal.Length,
		myData$Petal.Length,
		main = title,
		xlab = "Sepal Length",
		ylab = "Petal Length"
	)
}

#' Display the Hello World Page
#' @get /hello
#' @html

function() {
	"<html><h1>Hello World!</h1></html>"
}

#' Use Least Squares regression to predict a car's MSRP
#' @param hp the horsepower of the vehicle
#' @param cylinder the number of cylinders of the vehicle
#' @get /MSRP

function(hp, cylinder) {
	# Load the previously trained model: MSRP_mod
	MSRP_mod <- readRDS("Models/MSRP_mod.rds")
	
	# Assign the request parameters to the new data: input
	input <- data.frame(HP = as.numeric(hp), Cylinders = cylinder)
	
	# Predict the MSRP of the vehicle, rounded to the nearest penny
	round(predict(MSRP_mod, newdata = input), 2)
}

#' Log information about the incoming requests
#' @filter logger

function(req) {
	cat(as.character(Sys.time()), "-",
	    req$REQUEST_METHOD, req$PATH_INFO, "-",
	    req$HTTP_USER_AGENT, "@", req$REMOTE_ADDR, "\n")
	plumber::forward()
}
