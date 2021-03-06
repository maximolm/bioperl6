use Bio::Role::Describe;
use Bio::Role::Identify;

class Bio::PrimarySeq does Bio::Role::Describe does Bio::Role::Identify {

has Str $.seq is rw;
has Str $.alphabet is rw;
has Int $!seq_length is ro;
has Bool $.is_circular is rw;

=begin length

 Title   : length
 Usage   : $len = $seq.length();
 Function: Get the length of the sequence in number of symbols (bases
           or amino acids).

           You can also set this attribute, even to a number that does
           not match the length of the sequence string. This is useful
           if you don''t want to set the sequence too, or if you want
           to free up memory by unsetting the sequence. In the latter
           case you could do e.g.

               $seq.length($seq->length);
               #todo will not be undef but Mu I believe
               #$seq.seq(undef);

           Note that if you set the sequence to a value other than
           undef at any time, the length attribute will be
           invalidated, and the length of the sequence string will be
           reported again. Also, we won''t let you lie about the length.

 Example :
 Returns : integer representing the length of the sequence.
 Args    : Optionally, the value on set

=end length

multi method length() {

    if $!seq_length {
		 return $!seq_length;
    }
    #not sure which is more reliable in the end, graphs or chars
    #currently graphs does not work for Str
    my Int $len = $.seq.chars();

    
    return $len;
}

multi method length(Int $val){
    #not sure which is more reliable in the end, graphs or chars
    #currently graphs does not work for Str
	 my Int $len = $.seq.chars();
	 
	 if $val != $len {
            #need to have a throw here and die
            self.throw("You're trying to lie about the length: is $len but you say $val");
         }
	 
	$!seq_length = $val;
	
	return $val;
}

}