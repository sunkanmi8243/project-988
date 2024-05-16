<?php

namespace App\Enums;

use App\Traits\EnumOperation;

enum DocumentStatus: string
{
    use EnumOperation;

    case DRAFT = 'Draft';
    case PREWRITING = 'Prewriting';
    case PUBLISHED = 'Published'; //
    case INREVIEW = 'InReview'; //Allow others to review your work
    case EDITING = 'Editing'; //Allow others to review your work
    case ARCHIVED = 'Archived'; // archived Document
    case HOLD = 'Hold';
}
