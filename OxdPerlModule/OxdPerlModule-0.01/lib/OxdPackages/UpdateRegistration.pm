#!/usr/bin/perl
# UpdateRegistration.pm, a number as an object

##########################################
# Oxd client update site registration class
#
# Class is connecting to oXD-server via socket, and updating registered site data in gluu server.
#
# @package		Gluu-oxd-library
# @subpackage	Libraries
# @category	Relying Party (RP) and User Managed Access (UMA)
# @author		Ourdesignz
# @author		inderpal6785@gmail.com
# @see	        OxdClientSocket
# @see	        OxdClient
# @see	        OxdConfig
#######################################

use JSON::PP;

package UpdateRegistration;	
    
    use vars qw($VERSION);
    $VERSION = '0.01'; 
     
	use OxdPackages::OxdClient;
	use base qw(OxdClient Class::Accessor);
	#use base 'OxdClient';
	use strict;
	our @ISA = qw(OxdClient);    # inherits from OxdClient
	
	sub new {
		my $class = shift;
		
		my $self = {
			# @var string $request_oxd_id                          This parameter you must get after registration site in gluu-server
			_request_oxd_id => shift,
			
			# @var string $request_authorization_redirect_uri      Site authorization redirect uri
			_request_authorization_redirect_uri => shift,
			
			# @var string $request_post_logout_redirect_uri             Site logout redirect uri
			_request_post_logout_redirect_uri => shift,
			
			# @var string $request_client_name                     OpenID provider client name
			_request_client_name => shift,
			
			# @var array $request_acr_values                       Gluu login acr type, can be basic, duo, u2f, gplus and etc.
			_request_acr_values => shift,
			
			# @var string $request_client_jwks_uri
			_request_client_jwks_uri => shift,
			
			# @var string $request_client_token_endpoint_auth_method
			_request_client_token_endpoint_auth_method => shift,
			
			# @var array $request_client_request_uris
			_request_client_request_uris => shift,
			
			# @var array $request_client_logout_uris
			_request_client_logout_uris => shift,
			
			# @var array $request_contacts
			_request_contacts => shift,
			
			# @var array $request_scope                            For getting needed scopes from gluu-server
			_request_scope => shift,
			
			# @var array $request_grant_types                     OpenID Token Request type
			_request_grant_types => shift,
			
			# @var array $request_ui_locales
			_request_ui_locales => shift,
			
			# @var array $request_claims_locales
			_request_claims_locales => shift,
			
			# @var array $request_grant_types                     OpenID Token Request type
			_request_client_sector_identifier_uri => shift,
			
			# @var array $request_response_types                   OpenID Authentication response types
			_request_response_types => shift,
			
			# Response parameter from oXD-server
			# It is basic parameter for other protocols
			# @var string $response_oxd_id
			_response_oxd_id => shift,
		
		};
		
		bless $self, $class;
		return $self;
	}  
	
    
    # @return array
    sub getRequestClientSectorIdentifierUri
    {
        my( $self ) = @_;
		return $self->{_request_client_sector_identifier_uri};
    }

    # @param array $request_client_sector_identifier_uri
    sub setRequestClientSectorIdentifierUri
    {  
		my ( $self, $request_client_sector_identifier_uri ) = @_;
		$self->{_request_client_sector_identifier_uri} = $request_client_sector_identifier_uri if defined($request_client_sector_identifier_uri);
		return $self->{_request_client_sector_identifier_uri};
	}

    # @return array
    sub getRequestClaimsLocales
    {  
		my( $self ) = @_;
		return $self->{_request_claims_locales};
    }

    # @param array $request_claims_locales
    sub setRequestClaimsLocales
    {   
		my ( $self, $request_claims_locales ) = @_;
		$self->{_request_claims_locales} = $request_claims_locales if defined($request_claims_locales);
		return $self->{_request_claims_locales};
	}

    # @return array
    sub getRequestUiLocales
    {   
		my( $self ) = @_;
		return $self->{_request_ui_locales};
    }

    # @param array $request_ui_locales
    sub setRequestUiLocales
    {  
		my ( $self, $request_ui_locales ) = @_;
		$self->{_request_ui_locales} = $request_ui_locales if defined($request_ui_locales);
		return $self->{_request_ui_locales};
	}

    # @return array
    sub getRequestClientLogoutUris
    {   
		my( $self ) = @_;
		return $self->{_request_client_logout_uris};
    }

    # @param array $request_client_logout_uris
    # @return void
    sub setRequestClientLogoutUris
    {
        my ( $self, $request_client_logout_uris ) = @_;
		$self->{_request_client_logout_uris} = $request_client_logout_uris if defined($request_client_logout_uris);
		return $self->{_request_client_logout_uris};
	}

    
    # @return array
    sub getRequestResponseTypes
    {   
		my( $self ) = @_;
		return $self->{_request_response_types};
    }

    
    # @param array $request_response_types
    # @return void
    sub setRequestResponseTypes
    {   
		my ( $self, $request_response_types ) = @_;
		$self->{_request_response_types} = $request_response_types if defined($request_response_types);
		return $self->{_request_response_types};
	}

    
    # @return array
    sub getRequestGrantTypes
    {   
		my( $self ) = @_;
		return $self->{_request_grant_types};
    }

    
    # @param array $request_grant_types
    # @return void
    sub setRequestGrantTypes
    {
        my ( $self, $request_grant_types ) = @_;
		$self->{_request_grant_types} = $request_grant_types if defined($request_grant_types);
		return $self->{_request_grant_types};
	}

    
    # @return array
    sub getRequestScope
    {   
		my( $self ) = @_;
		return $self->{_request_scope};
    }

    
    # @param array $request_scope
    # @return void
    sub setRequestScope
    {   
		my ( $self, $request_scope ) = @_;
		$self->{_request_scope} = $request_scope if defined($request_scope);
		return $self->{_request_scope};
	}

    
    # @return string
    sub getRequestPostLogoutRedirectUri
    {   
		my( $self ) = @_;
		return $self->{_request_post_logout_redirect_uri};
    }

    
    # @param string $request_post_logout_redirect_uri
    # @return void
    sub setRequestPostLogoutRedirectUri
    {   
		my ( $self, $request_post_logout_redirect_uri ) = @_;
		$self->{_request_post_logout_redirect_uri} = $request_post_logout_redirect_uri if defined($request_post_logout_redirect_uri);
		return $self->{_request_post_logout_redirect_uri};
	}

    
    # @return string
    sub getRequestClientJwksUri
    {
		my( $self ) = @_;
		return $self->{_request_client_jwks_uri};
	}

    
    # @param string $request_client_jwks_uri
    # @return void
    
    sub setRequestClientJwksUri
    {   
		my ( $self, $request_client_jwks_uri ) = @_;
		$self->{_request_client_jwks_uri} = $request_client_jwks_uri if defined($request_client_jwks_uri);
		return $self->{_request_client_jwks_uri};
	}

    
    # @return string
    sub getRequestClientTokenEndpointAuthMethod
    {  
		my( $self ) = @_;
		return $self->{_request_client_token_endpoint_auth_method};
    }

    
    # @param string $request_client_token_endpoint_auth_method
    # @return void
    sub setRequestClientTokenEndpointAuthMethod
    {   
		my ( $self, $request_client_token_endpoint_auth_method ) = @_;
		$self->{_request_client_token_endpoint_auth_method} = $request_client_token_endpoint_auth_method if defined($request_client_token_endpoint_auth_method);
		return $self->{_request_client_token_endpoint_auth_method};
	}

    
    # @return array
    sub getRequestClientRequestUris
    {
		my( $self ) = @_;
		return $self->{_request_client_request_uris};
	}

    
    # @param array $request_client_request_uris
    # @return void
    
    sub setRequestClientRequestUris
    {   
		my ( $self, $request_client_request_uris ) = @_;
		$self->{_request_client_request_uris} = $request_client_request_uris if defined($request_client_request_uris);
		return $self->{_request_client_request_uris};
	}

    
    # @return string
    sub getRequestAuthorizationRedirectUri
    {   
		my( $self ) = @_;
		return $self->{_request_authorization_redirect_uri};
    }

    
    # @param string $request_authorization_redirect_uri
    # @return void
    sub setRequestAuthorizationRedirectUri
    {
        my ( $self, $request_authorization_redirect_uri ) = @_;
		$self->{_request_authorization_redirect_uri} = $request_authorization_redirect_uri if defined($request_authorization_redirect_uri);
		return $self->{_request_authorization_redirect_uri};
	}

    
    # @return array
    
    sub getRequestAcrValues
    {
        my( $self ) = @_;
		return $self->{_request_acr_values};
    }

    
    # @param array $request_acr_values
    # @return void
    
    sub setRequestAcrValues
    {
		my ( $self, $request_acr_values ) = @_;
		$request_acr_values =  $request_acr_values ? $request_acr_values : 'basic';
		
		$self->{_request_acr_values} = $request_acr_values if defined($request_acr_values);
		return $self->{_request_acr_values};
	}

    
    # @return array
    
    sub getRequestContacts
    {
        my( $self ) = @_;
		return $self->{_request_contacts};
	}

    
    # @param array $request_contacts
    # @return void
    
    sub setRequestContacts
    {
		my ( $self, $request_contacts ) = @_;
		$self->{_request_contacts} = $request_contacts if defined($request_contacts);
		return $self->{_request_contacts};
	}

    
    # @return string
    
    sub getResponseOxdId
    {
		my( $self ) = @_;
		$self->{_response_oxd_id} = $self->getResponseData()->{oxd_id};
		
		return $self->{_response_oxd_id};
	}

    
    # @return string
    
    sub getRequestClientName
    {
		my( $self ) = @_;
		return $self->{_request_client_name};
	}

    
    # @param string $request_client_name
    
    sub setRequestClientName
    {
		my ( $self, $request_client_name ) = @_;
		$self->{_request_client_name} = $request_client_name if defined($request_client_name);
		return $self->{_request_client_name};
	}

    
    # @param string $response_oxd_id
    # @return void
    
    sub setResponseOxdId
    {
		my ( $self, $response_oxd_id ) = @_;
		$self->{_response_oxd_id} = $response_oxd_id if defined($response_oxd_id);
		return $self->{_response_oxd_id};
	}
    
    # @return string
    
    sub getRequestOxdId
    { 
		my( $self ) = @_;
		return $self->{_request_oxd_id};
		
    }

    
    # @param string $request_oxd_id
    # @return void
    
    sub setRequestOxdId
    {
		my ( $self, $request_oxd_id ) = @_;
		$self->{_request_oxd_id} = $request_oxd_id if defined($request_oxd_id);
		return $self->{_request_oxd_id};
	}

    
    # Protocol command to oXD server
    # @return void
    
    sub setCommand
    {
		my ( $self, $command ) = @_;
		$self->{_command} = 'update_site_registration';
		return $self->{_command};
	}
    
    # Protocol parameter to oXD server
    # @return void
    
    sub setParams
    {
        my ( $self, $params ) = @_;
		#use Data::Dumper;
		my $paramsArray = {
            "oxd_id" => $self->getRequestOxdId(),
            "authorization_redirect_uri" => $self->getRequestAuthorizationRedirectUri(),
            "post_logout_redirect_uri" => $self->getRequestPostLogoutRedirectUri(),
            "client_logout_uris"=> $self->getRequestClientLogoutUris(),
            "response_types"=> $self->getRequestResponseTypes(),
            "grant_types" => $self->getRequestGrantTypes(),
            "scope" => $self->getRequestScope(),
            "acr_values" => $self->getRequestAcrValues(),
            "client_name" => $self->getRequestClientName(),
            "client_secret_expires_at"=> 3080736637943,
            "client_jwks_uri" => $self->getRequestClientJwksUri(),
            "client_token_endpoint_auth_method" => $self->getRequestClientTokenEndpointAuthMethod(),
            "client_request_uris" => $self->getRequestClientRequestUris(),
            "client_sector_identifier_uri" => $self->getRequestClientSectorIdentifierUri(),
            "contacts" => $self->getRequestContacts(),
            "ui_locales"=> $self->getRequestUiLocales(),
            "claims_locales"=> $self->getRequestClaimsLocales()
        };
       
		$self->{_params} = $paramsArray;
		return $self->{_params};
        #print Dumper( $params );
        #return $paramsArray;
        
    }	

1;		# this 1; is neccessary for our class to work
