property mytitle : "Commify"
property myversion : "1.0.2"
property prefitems : {"No quotes"}
property prefquotes : ""

-- called when the script icon is clicked
on run
	my main()
end run

-- main routine
on main()
	try
		set clipcont to the clipboard
		set validated to my validate(clipcont)
		
		if validated is false then
			return
		end if
		
		set menuitem to my dspmainmenu()
		if menuitem is missing value then
			return
		end if
		
		set usrchoice to my getquotecharacters(menuitem)
		if usrchoice is missing value then
			return
		else
			set {leadingquote, trailingquote, separator} to usrchoice
		end if
		
		set clipcontlines to paragraphs of clipcont
		set newtxtbody to my transform(clipcont, leadingquote, trailingquote, ", ")
		
		set the clipboard to newtxtbody
	on error errmsg number errnum
		my dsperrmsg(errmsg, errnum)
	end try
end main

-- roughly validates the contents of the clipboard
on validate(clipcont)
	if clipcont is missing value then
		set errmsg to "The clipboard is empty."
		my dsperrmsg(errmsg, "--")
		return false
	end if
	
	set clipcontlines to paragraphs of clipcont
	if length of clipcontlines < 2 then
		set errmsg to "The contents of the clipboard is only one line. It cannot be splitted into several lines."
		my dsperrmsg(errmsg, "--")
		return false
	end if
	
	return true
end validate

-- transforms rows of strings to a (quoted) list of strings
-- 1
-- 2
-- 3
-- => 1, 2, 3
on transform(txtbody, leadingquote, trailingquote, separator)
	set newtxtbody to ""
	set txtlines to paragraphs of txtbody
	
	set lentxtlines to length of txtlines
	repeat with i from 1 to lentxtlines
		set txtline to item i of txtlines
		
		if i < lentxtlines then
			set newtxtline to leadingquote & txtline & trailingquote & separator
		else
			set newtxtline to leadingquote & txtline & trailingquote
		end if
		
		set newtxtbody to newtxtbody & newtxtline
	end repeat
	
	return newtxtbody
end transform

-- returns the correct quote characters for the chosen menu item
on getquotecharacters(menuitem)
	set leadingquote to ""
	set trailingquote to ""
	set separator to ", "
	
	if menuitem is "Single quotes" then
		set leadingquote to "'"
		set trailingquote to "'"
	end if
	
	if menuitem is "Double quotes" then
		set leadingquote to "\""
		set trailingquote to "\""
	end if
	
	if menuitem is "Customize" then
		set usrchoice to my choosecustomquotes()
		return usrchoice
	end if
	
	return {leadingquote, trailingquote, separator}
end getquotecharacters

-- returns the text items of the given text (delimited by the given delimiter)
on gettxtitems(txt, delchar)
	considering case, diacriticals and punctuation
		set olddelims to AppleScript's text item delimiters
		set AppleScript's text item delimiters to {delchar}
		set txtitems to text items of txt
		set AppleScript's text item delimiters to olddelims
	end considering
	return txtitems
end gettxtitems

-- displays an error message
on dsperrmsg(errmsg, errnum)
	tell me
		activate
		display dialog "Sorry, an error coccured:" & return & return & errmsg & " (" & errnum & ")" buttons {"Never mind"} default button 1 with icon stop with title mytitle
	end tell
end dsperrmsg

-- lets the user choose its custom quote characters and separator
on choosecustomquotes()
	try
		tell me
			activate
			display dialog "Please choose a trailing & leading quote character as well as a separator, delimited by the character #:" & return & return & "(e.g. [#]#,)" default answer prefquotes buttons {"Cancel", "Enter"} default button 2 with icon note with title mytitle
			set dlgresult to result
		end tell
		if button returned of dlgresult is "Cancel" then
			return missing value
		else
			set usrinput to text returned of dlgresult
			-- no input, empty string
			if usrinput is "" then
				my choosecustomquotes()
			else
				set splitusrinput to my gettxtitems(usrinput, "#")
				if length of splitusrinput is not 3 then
					my choosecustomquotes()
				else
					set prefquotes to splitusrinput
					return splitusrinput
				end if
			end if
		end if
	on error errmsg number errnum
		return missing value
	end try
end choosecustomquotes

-- displays the main menu and returns chosen menu item
on dspmainmenu()
	set menuitems to {"No quotes", "Single quotes", "Double quotes", "行 行 行 行 行", "Customize"}
	choose from list menuitems with title mytitle default items prefitems cancel button name "Quit" OK button name "Select" with prompt "Please choose an option:" without multiple selections allowed and empty selection allowed
	set choice to result
	if choice is not false then
		set menuitem to item 1 of choice
		if menuitem is "行 行 行 行 行" then
			my dspmainmenu()
		else
			set prefitems to {menuitem}
			return menuitem
		end if
	else
		return missing value
	end if
end dspmainmenu