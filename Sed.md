
* Get submatch 1 for all lines
    *   
        ```bash
        echo -e "Bla\nBla\nImportant1: One \nBla\nImportant2: Two\nBla\nBla" | \
           sed -n 's/^Important1: *\([^ ]*\) */\1/p'

        OUTPUT:
        one
        ```
    *   `-n` means silent


* Replace a multi-line string
  https://unix.stackexchange.com/questions/26284/how-can-i-use-sed-to-replace-a-multi-line-string?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
    *
    ```bash
    sed '/^a test$/{
       $!{ N        # append the next line when not on the last line
         s/^a test\nPlease do not$/not a test\nBe/
                    # now test for a successful substitution, otherwise
                    #+  unpaired "a test" lines would be mis-handled
         t sub-yes  # branch_on_substitute (goto label :sub-yes)
         :sub-not   # a label (not essential; here to self document)
                    # if no substituion, print only the first line
         P          # pattern_first_line_print
         D          # pattern_ltrunc(line+nl)_top/cycle
         :sub-yes   # a label (the goto target of the 't' branch)
                    # fall through to final auto-pattern_print (2 lines)
       }    
     }' alpha.txt         
     ```








* Multiline pattern
  *
  ```bash
   sed -n '/[{]/,/[}]/{
   p
   /[}]/a\
    end of block matching brace

   }' *.txt 
  ```
  * `-n` means 'no default print lines as processed'.
    * `'p'` means now print the line.
    * `/[{]/,/[}]/` is a range expression. It means scan until you find something that matches the first pattern (/[{]/) AND then scan until you find the 2nd pattern (/[}]/) THEN perform whatever actions you find in between the { } in the sed code. In this case 'p' and the debugging code. (not explained here, use it, mod it or take it out as works best for you).


* Read a file
  * `sed -i -e '/fox/{r f.html' -e 'd}'`
  
  
* Append (line after pattern)
  * 
  ```bash
  sed -i '/pattern/a \
  line1 \
  line2' inputfile
  ```
  * `sed -i '/SearchPattern/aNew Text' SomeFile.txt`
  
  
* Prepend (line before pattern)
  * 
  ```bash
  sed -i '/pattern/i \
  line1 \
  line2' inputfile
  ```
  
  


* Cheat
  ```
  :  # label
  =  # line_number
  a  # append_text_to_stdout_after_flush
  b  # branch_unconditional             
  c  # range_change                     
  d  # pattern_delete_top/cycle          
  D  # pattern_ltrunc(line+nl)_top/cycle 
  g  # pattern=hold                      
  G  # pattern+=nl+hold                  
  h  # hold=pattern                      
  H  # hold+=nl+pattern                  
  i  # insert_text_to_stdout_now         
  l  # pattern_list                       
  n  # pattern_flush=nextline_continue   
  N  # pattern+=nl+nextline              
  p  # pattern_print                     
  P  # pattern_first_line_print          
  q  # flush_quit                        
  r  # append_file_to_stdout_after_flush 
  s  # substitute                                          
  t  # branch_on_substitute              
  w  # append_pattern_to_file_now         
  x  # swap_pattern_and_hold             
  y  # transform_chars    
  ```
