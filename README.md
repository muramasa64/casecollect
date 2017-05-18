# Casecollect

Casecollect is a collector of AWS support cases and communications.

## Installation

Install it yourself as:

    $ gem install casecollect

## Usage

```
Commands:
  casecollect cases           # Collect AWS Support cases
  casecollect communications  # Collect AWS Support communications
  casecollect help [COMMAND]  # Describe available commands or one specific command

Options:
  p, [--profile=PROFILE]                                   # Load credentials by profile name from shared credentials file.
  k, [--access-key-id=ACCESS_KEY_ID]                       # AWS access key id.
  s, [--secret-access-key=SECRET_ACCESS_KEY]               # AWS secret access key.
  r, [--region=REGION]                                     # AWS region.
      [--shared-credentials-path=SHARED_CREDENTIALS_PATH]  # AWS shared credentials path.
  v, [--verbose], [--no-verbose]
```

## Examples

casecollect output tsv format.

```
$ casecollect cases > cases.tsv
$ casecollect communications > communications.tsv
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/muramasa64/casecollect. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

