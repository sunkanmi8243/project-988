@props(['messages'])

@if ($messages)
    <div {{ $attributes->merge(['class' => 'text-danger']) }}>
        @foreach ((array) $messages as $message)
            <p>{{ $message }}</p>
        @endforeach
    </div>
@endif
