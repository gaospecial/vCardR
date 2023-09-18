
#' Generate one VCARD
#'
#' @param name name
#' @param cell cell phone number
#' @param org company or organization
#' @param email email
#' @param birthday date of birth (YYYY-MM-DD)
#' @param address address
#' @param address_work work address
#' @param address_home home address
#' @param qq qq number
#' @param note note
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
vcard = function(name,
                 cell = NULL,  # cell/mobile phone
                 org = NULL, # organization/company
                 email = NULL, # email
                 birthday = NULL, # birthday
                 qq = NULL, ## qq number
                 address = NULL, # address, will pass to home address
                 address_work = NULL, # work address
                 address_home = NULL,# home address
                 note = NULL # note
                 ){
  # see defination at https://datatracker.ietf.org/doc/html/rfc2426#ref-VCARD
  content = glue::glue("BEGIN:VCARD",
                     "VERSION:3.0",
                     .sep = "\n")

  if (!is.null(name)){
    content = glue::glue(content,
                         .sep = "\n",
                         "N;CHARSET=utf-8:{name}",
                         "FN;CHARSET=utf-8:{name}")
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
                         "EMAIL;TYPE=INTERNET:{email}")
  }

  if (!is.null(birthday)){
    content = glue::glue(content,
                         .sep = "\n",
                         "BDAY:{birthday}")
  }

  if (!is.null(qq)){
    content = glue::glue(content,
                         .sep = "\n",
                         "X-QQ:{qq}")
  }
  if (!is.null(address)){
    content = glue::glue(content,
                         .sep = "\n",
                         "ADR:{address}")
  }

  if (!is.null(address_home)){
    content = glue::glue(content,
                         .sep = "\n",
                         "ADR;TYPE=HOME:{address_home}")
  }

  if (!is.null(address_work)){
    content = glue::glue(content,
                         .sep = "\n",
                         "ADR;TYPE=WORK:{address_work}")
  }

  if (!is.null(note)){
    content = glue::glue(content,
                         .sep = "\n",
                         "NOTE;CHARSET=UTF-8:{note}")
  }

  content = glue::glue(.sep = "\n",
                       content,
                       "END:VCARD\n")

  return(content)
}
