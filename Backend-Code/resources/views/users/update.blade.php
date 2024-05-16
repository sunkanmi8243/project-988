<x-app-layout>
    <div class="content">
        <div class="main">
            <div class="page-header">
                <h4 class="page-title">Update User</h4>
            </div>

            <div class="card">
                <div class="card-body">
                    <x-flash/>
                    <x-helper.message/>
                    <div class="mt-4">
                        <div class="row">
                            <form method="POST" action="{{ route('users.update', $user) }}">
                                @csrf
                                {{ method_field('PUT') }}
                                <div class="col-md-12">
                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <label for="status" class="form-label">Wallet Balance</label>
                                            <input type="number" min="0" class="form-control" value="{{ old('wallet_balance', $user->wallet_balance) }}" name="wallet_balance" id="wallet_balance">
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <label for="status" class="form-label">Status</label>
                                            <select name="status" id="status" class="form-select">
                                                @forelse($statuses as $key => $status)
                                                    <option {{ old('status', $user->status->value) == $status ? "selected" : "" }} value="{{ $status }}">{{ $status }}</option>
                                                @empty
                                                    <option >No record</option>
                                                @endforelse
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                    <div class="col-md-12">
                                        <div class="mb-3 pt-3">
                                            <button type="submit" class="btn btn-primary float-end">Update</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
        </div>
        <x-helper.footer/>
    </div>
</x-app-layout>
