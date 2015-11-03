package MyRedis; 
use base qw(Mojo::Redis2);

our $url_list_key="url:list";
our $processed_url_key_pattern="url:";

sub init() {
	my ($self) = @_;
	$self->del($url_list_key);
}

sub push_url() {
	my ($self, $url) = @_;
	$self->sadd($url_list_key => $url);
}

sub get_url() {
	my ($self) = @_;
	my $url = '';
	while ($url eq '' && $self->scard($url_list_key) > 0) {
		$url = $self->spop($url_list_key);		
		print "URL : ", $url;
		if ($self->get("url:" . $url)) {
			$url = '';
		}
	}
	return $url;
}

sub processed_url() {
	my ($self, $url) = @_;
	$self->set("url:" . $url => 1);
}

sub check_url_processed() {
	my ($self, $url) = @_;
	return $self->get("url:" . $url);
}

sub get_count() {
	my ($self) = @_;
	return $self->scard("url:list");
}
