# Image Uploader
You can drag and drop images to Chatterino or paste them from clipboard to upload them to an external service.

By default, the image uploader is turned off. You can enable by checking the `Chatterino Settings -> External Tools -> Image Uploader -> Enable image uploader` option and configuring per one of the below options.

Note to advanced users: This module sends multipart-form requests via POST method, so uploading via SFTP/FTP won't work.
However, popular hosts like [imgur.com](https://imgur.com) and [s-ul.eu](https://s-ul.eu) are supported. Scroll down to see example cofiguration.

## Configuration Explanation
|Row|Description|
|-|-|
|Request URL|Link to an API endpoint, which is requested by chatterino. Any needed URL parameters should be included here.|
|Form field|Name of a field, which contains image data.|
|Extra headers|Extra headers, that will be included in the request. Header name and value must be separated by colon (`:`). Multiple headers need to be separated with semicolons (`;`).<br>Example: `Authorization: supaKey ; NextHeader: value`.|
|Image link|Schema that tells where is the link in service's response. Leave empty if server's response is just the link itself. Refer to json properties by `{property}`. Supports dot-notation, example: `{property.anotherProperty}`.|
|Deletion link|Same as above.|

## Examples
### i.nuuls.com

|Row|Description|
|-|-|
|Request URL|`https://i.nuuls.com/upload`|
|Form field|`attachment`|

Other fields empty.

### imgur.com
|Row|Description|
|-|-|
|Request URL|`https://api.imgur.com/3/image`|
|Form field|`image`|
|Extra headers|`Authorization: Client-ID c898c0bb848ca39`|
|Image link|`{data.link}`|
|Deletion link|`https://imgur.com/delete/{data.deletehash}`|

You can also upload images to your imgur account by putting the following as `Extra headers`:

Replace `XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX` with the token which you can obtain [here](https://zneix.eu/imgurauth).

`Authorization: Bearer XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX`

### s-ul.eu
Replace `XXXXXXXXXXXXXXX` with your API key from s-ul.eu. It can be found on [your account's configuration page](https://s-ul.eu/account/configurations).

|Row|Description|
|-|-|
|Request URL|`https://s-ul.eu/api/v1/upload?wizard=true&key=XXXXXXXXXXXXXXX`|
|Form field|`file`|
|Extra headers||
|Image link|`{url}`|
|Deletion link|`https://s-ul.eu/delete.php?file={filename}&key=XXXXXXXXXXXXXXX`|

### [i.fourtf.com](https://github.com/fourtf/i)
This is not a hosted service, but rather a service that can be self-hosted. Click on the URL for more information.
Replace `XXXXXXXXXXXXXXX` with your Base64-encoded user and password

|Row|Description|
|-|-|
|Request URL|`https://i.yourwebsite.com/upload`|
|Form field|`file`|
|Extra headers|`Authorization: Basic XXXXXXXXXXXXXXX`|
|Image link||
|Deletion link||


### [catbox.moe](https://catbox.moe/)
it's not possible yet to upload to catbox.moe due to how their upload method is constructed - it requires you to put extra form fields, which unfortunately can't be done in Chatterino's uploader yet

