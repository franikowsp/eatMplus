read_coefficients <- function(fit) {
  parameters <- fit$results$parameters
  
  par_names <- names(parameters)
  
  parameters %>% 
    purrr::reduce(dplyr::left_join,
                  by = dplyr::join_by("paramHeader", "param", "est", "BetweenWithin")) %>% 
    tibble::as_tibble() %>%
    dplyr::mutate(
      op = dplyr::case_when(
        stringr::str_detect(paramHeader, "(\\.ON|Intercepts)") ~ "~",
        stringr::str_detect(paramHeader, "(\\.WITH|Residual.Variances)") ~ "~~",
        stringr::str_detect(paramHeader, "(\\.BY)") ~ "=~",
        .default = NA_character_
      ),
    )
    dplyr::rename(dplyr::any_of(c(
      param_header = paramHeader,
      parameter = param,
      estimate = "est",
      
    )))
}
