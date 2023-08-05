
#' Generate one VCARD
#'
#' @param name name
#' @param cell cell phone number
#' @param org company or organization
#' @param email email
#' @param birthday date of birth (YYYY-MM-DD)
#' @param address address
#'
#' @return a VCARD
#' @export
#'
#' @examples
#' data = data.frame(
#'   name = c("张三","李四"),
#'   cell = c("13033339999","13800000000"),
#'   org = c("菜鸟","腾讯")
#' )
#' cards = lapply(1:nrow(data), function(i){
#'   vcard(name = data$name[[i]],
#'         cell = data$cell[[i]],
#'         birthday = data$birthday[[i]],
#'         address = data$address[[i]])
#' })
#'
#' con = file("contact.vcf", "a")
#' lapply(cards, xfun::write_utf8, con = con)
#' close(con)
vcard = function(name, cell = NULL, org = NULL, email = NULL, birthday = NULL, address = NULL){
  # see defination at https://datatracker.ietf.org/doc/html/rfc2426#ref-VCARD
  content = glue::glue("BEGIN:VCARD",
                     "VERSION:3.0",
                     .sep = "\n")

  if (!is.null(name)){
    content = glue::glue(content,
                         .sep = "\n",
                         "N:{name}",
                         "FN:{name}")
  }

  if (!is.null(cell)){
    content = glue::glue(.sep = "\n",
                         content,
                         "TEL;CELL:{cell}")
  }

  if(!is.null(org)){
    content = glue::glue(.sep = "\n",
                         content,
                         "ORG:{org}")
  }

  if(!is.null(email)){
    content = glue::glue(.sep = "\n",
                         content,
                         "EMAIL:{email}")
  }

  if (!is.null(birthday)){
    content = glue::glue(content,
                         .sep = "\n",
                         "BDAY:{birthday}")
  }

  if (!is.null(address)){
    content = glue::glue(content,
                         .sep = "\n",
                         "ADR:{address}")
  }

  content = glue::glue(.sep = "\n",
                       content,
                       "END:VCARD\n")

  return(content)
}
