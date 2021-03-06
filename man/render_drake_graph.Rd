% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_graph.R
\name{render_drake_graph}
\alias{render_drake_graph}
\title{Function \code{render_drake_graph}}
\usage{
render_drake_graph(graph_dataframes, file = character(0),
  layout = "layout_with_sugiyama", direction = "LR", hover = TRUE,
  main = graph_dataframes$default_title, selfcontained = FALSE,
  navigationButtons = TRUE, ncol_legend = 1, ...)
}
\arguments{
\item{graph_dataframes}{list of data frames generated by
\code{\link{dataframes_graph}()}.
There should be 3 data frames: \code{nodes}, \code{edges},
and \code{legend_nodes}.}

\item{file}{Name of HTML file to save the graph.
If \code{NULL} or \code{character(0)},
no file is saved and the graph is rendered and displayed within R.}

\item{layout}{name of an igraph layout to use,
such as 'layout_with_sugiyama'
or 'layout_as_tree'.
Be careful with 'layout_as_tree': the graph is a directed
acyclic graph, but not necessarily a tree.}

\item{direction}{an argument to \code{visNetwork::visHierarchicalLayout()}
indicating the direction of the graph.
Options include 'LR', 'RL', 'DU', and 'UD'.
At the time of writing this, the letters must be capitalized,
but this may not always be the case ;) in the future.}

\item{hover}{logical, whether to show the command that generated the target
when you hover over a node with the mouse. For imports, the label does not
change with hovering.}

\item{main}{title of the graph}

\item{selfcontained}{logical, whether
to save the \code{file} as a self-contained
HTML file (with external resources base64 encoded) or a file with
external resources placed in an adjacent directory. If \code{TRUE},
pandoc is required.}

\item{navigationButtons}{logical, whether to add navigation buttons with
\code{visNetwork::visInteraction(navigationButtons = TRUE)}}

\item{ncol_legend}{number of columns in the legend nodes}

\item{...}{arguments passed to \code{visNetwork()}.}
}
\value{
A visNetwork graph.
}
\description{
render a graph from the data frames
generated by \code{\link{dataframes_graph}()}
}
\examples{
\dontrun{
load_basic_example() # Load the canonical example for drake.
# Instead of jumpting right to vis_drake_graph(), get the data frames
# of nodes, edges, and legend nodes.
graph <- dataframes_graph(my_plan)
# You can pass the data frames right to render_drake_graph()
# (as in vis_drake_graph()) or you can create
# your own custom visNewtork graph.
render_drake_graph(graph, width = '100\%') # Width is passed to visNetwork.
}
}
