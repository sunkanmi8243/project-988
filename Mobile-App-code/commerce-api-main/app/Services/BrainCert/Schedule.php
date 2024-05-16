<?php

namespace App\Services\BrainCert;

use Illuminate\Support\Arr;

class Schedule
{
    /** @var array */
    protected $attendees;

    public function __construct()
    {
        $this->attendees = [];
    }

    public function __set($name, $value)
    {
        $name = $this->getFieldName($name);

        if (in_array($name, ['start.date', 'end.date', 'start.dateTime', 'end.dateTime'])) {
            $this->setDateProperty($name, $value);

            return;
        }

        if ($name == 'source') {
            $this->setSourceProperty($value);

            return;
        }

        Arr::set($this->googleEvent, $name, $value);
    }

    public function save(?string $method = null, $optParams = []): self
    {
        $method = $method ?? ($this->exists() ? 'update' : 'create');

        $api = self::getBrainCert();

        return $api->$method($this, $optParams);
    }

    public function exists(): bool
    {
        return $this->id != '';
    }

    protected function getFieldName(string $name): string
    {
        return [
            'title' => 'title',
            'timezone' => 'timezone',
            'start_time' => 'start_time',
            'end_time' => 'end_time',
            'date' => 'date',
            'currency' => 'currency',
            'ispaid' => 'ispaid',
            'is_recurring' => 'is_recurring',
            'repeat' => 'repeat',
            'weekdays' => 'weekdays',
            'end_classes_count' => 'end_classes_count',
            'end_date' => 'end_date',
            'seat_attendees' => 'seat_attendees',
            'record' => 'record',
            'isRecordingLayout' => 'isRecordingLayout',
            'isVideo' => 'isVideo',
            'isBoard' => 'isBoard',
            'isLang' => 'isLang',
            'isRegion' => 'isRegion',
            'isCorporate' => 'isCorporate',
            'isScreenshare' => 'isScreenshare',
            'isPrivateChat' => 'isPrivateChat',
            'description' => 'description',
            'keyword' => 'keyword',
            'format' => 'format',

        ][$name] ?? $name;
    }

    protected static function getBrainCert(): BrainCertSDK
    {
        return new BrainCertSDK();
    }
}
