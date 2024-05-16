<?php

namespace App\Traits;

use App\Enums\DocumentStatus;
use App\Models\Review;
use Illuminate\Database\Eloquent\Relations\MorphMany;

trait Reviews
{
    public function reviews(): MorphMany
    {
        return $this->morphMany(Review::class, 'reviewable');
    }

    public function rate($rate, $comment = null, $user = null, DocumentStatus $status = DocumentStatus::DRAFT)
    {
        if ($rate > 5 || $rate < 1) {
            throw new \InvalidArgumentException('Rating must be between 1-5');
        }

        return $this->reviews()
            ->firstOrNew([
                'user_id' => $user ? $user->id : auth('sanctum')->id(),
            ])
            ->fill([
                'star' => $rate,
                'comment' => $comment,
                'status' => $status,
            ])
            ->save();
    }

    public function review()
    {
        return $this->reviews->avg('star');
    }
}
