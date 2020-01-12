# Iris_REST_API
Working with plumber in R to create a REST API

## Instructions to Run
To start the plumber.R REST API, run the following code:

```r
# Translate plumber.R into a Plumber API: pr
pr <- plumber::plumb("plumber.R")

# Bring the API to life
pr$run()
```

While the REST API is running, the swagger UI will be available at http://127.0.0.1:9098/__swagger__/ (This URL may be on a different IP or port depending on the machine settings and if it is run locally or on the _RStudio_ server). The swagger UI is helpful for exploring the endpoints available in the API.

## Get Requests
To send a get request, query as you normally would with any other REST API. See the example below:

>http://127.0.0.1:9098/plot?spec=setosa

If the endpoint you provided exists in `plumber.R`, the API will attempt to run the code provided at the endpoint with any parameters provided.

In this example, the endpoint is `plot` and the parameter is `setosa`. In the `plumber.R` file, this will call the function defined below the `plot` endpoint with the parameter `setosa`.

The way the function is written, the `spec` argument will take any species type defined in the `iris` data set. Any value for `spec` not defined in the `iris` data set will result in an error and the page will return a __500__ error

## File Types to Return

There are multiple options for what file type to return. They can be specified in the header where each endpoint is defined like so:

```r
#' @html
```
or
```r
#' @png
```
