<!DOCTYPE html>
<html>
    <head>
        <title>Laravel Cloudinary Image Upload</title>

    </head>
    <body>
        <h1>Upload Image to Cloudinary in Laravel</h1>
        <form action="{{ route('cloudinary.store') }}" method="POST" enctype="multipart/form-data">
            @csrf

            <input type="file" name="image" accept="image/*" required>

            <button type="submit">Upload</button>
        </form>
    </body>
</html>
