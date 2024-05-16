<ul>
    @foreach($errors->all() as $message)
        <li class="text-danger">{{ $message }}</li>
    @endforeach
</ul>
