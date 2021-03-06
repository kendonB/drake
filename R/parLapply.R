run_parLapply <- function(config) { # nolint
  eval(parse(text = "require(drake)"))
  if (config$jobs < 2) {
    return(run_lapply(config = config))
  }
  console_parLapply(config) # nolint
  config$cluster <- makePSOCKcluster(config$jobs)
  on.exit(stopCluster(cl = config$cluster))
  clusterExport(cl = config$cluster, varlist = "config",
    envir = environment())
  if (identical(config$envir, globalenv()))
    clusterExport(cl = config$cluster, varlist = ls(globalenv(),
      all.names = TRUE), envir = globalenv())
  clusterCall(cl = config$cluster, fun = function(){
    eval(parse(text = "require(drake)"))
  })
  clusterCall(cl = config$cluster, fun = do_prework, config = config,
    verbose_packages = FALSE)
  run_parallel(
    config = config,
    worker = worker_parLapply # nolint
  )
}

worker_parLapply <- function(targets, meta_list, config) { # nolint
  prune_envir_parLapply(targets = targets, config = config) # nolint
  values <- parLapply(cl = config$cluster, X = targets, fun = drake_build,
    meta_list = meta_list, config = config)
  assign_to_envir_parLapply( # nolint
    target = targets,
    value = values,
    config = config
  )
}

prune_envir_parLapply <- function(targets = targets, config = config) { # nolint
  prune_envir(targets = targets, config = config)
  if (identical(config$envir, globalenv()))
    clusterCall(cl = config$cluster, fun = prune_envir, targets = targets,
      config = config)
}

assign_to_envir_parLapply <- # nolint
  function(target, value, config) {
  assign_to_envir(target = target, value = value, config = config)
  if (identical(config$envir, globalenv()))
    clusterCall(cl = config$cluster, fun = assign_to_envir,
      target = target, value = value, config = config)
}
