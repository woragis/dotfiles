# Function to interpret sequences of dots as multiple directory traversals
function multicd --description 'Navigate up multiple directories using dots'
    # Check if the argument is just a series of dots
    if string match -qr '^\.+$' $argv[1]
        # Count the number of dots
        set -l dot_count (string length $argv[1])
        
        # If more than 2 dots, interpret as multiple directory traversals
        if test $dot_count -gt 2
            # Calculate number of parent directories to traverse
            set -l parent_count (math $dot_count - 1)
            
            # Build the path with appropriate number of ../
            set -l target_path ""
            for i in (seq $parent_count)
                set target_path "$target_path../"
            end
            
            # Remove trailing slash for clean path
            set target_path (string trim -r -c / $target_path)
            
            # Execute the cd command
            cd $target_path
            return
        end
    end
    
    # If not a series of dots or just 1-2 dots, use normal cd
    cd $argv
end

# Add the function to the list of cd commands
function cd --wraps cd --description 'Change directory or navigate up with dots'
    if test (count $argv) -eq 1; and string match -qr '^\.+$' $argv[1]
        multicd $argv
    else
        builtin cd $argv
    end
end

