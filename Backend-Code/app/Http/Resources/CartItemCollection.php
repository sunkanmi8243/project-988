<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\ResourceCollection;

class CartItemCollection extends ResourceCollection
{
    /**
     * Transform the resource collection into an array.
     *
     * @return array<int|string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'status' => true,
            'message' => 'success',
            'total' => $this->collection[0]->cart?->total(),
            'subtotal' => $this->collection[0]?->cart?->subtotal(),
            'tax' => $this->collection[0]?->cart?->tax(),
            'data' => $this->collection,
        ];
    }
}
