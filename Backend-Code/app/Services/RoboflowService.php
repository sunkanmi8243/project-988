<?php

namespace App\Services;

use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Http;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpKernel\Exception\HttpException;

class RoboflowService
{
    public function analyzeImage(UploadedFile $uploadedFile): array
    {
        $query = http_build_query([
            'api_key' => config('services.roboflow.key'),
            'confidence' => 40,
        ]);

        $url = config('services.roboflow.url').'?'.$query;

        $response = Http::withHeader('Content-Type', 'application/x-www-form-urlencoded')
            ->post($url, base64_encode($uploadedFile->getContent()));

        if ($response->failed()) {
            throw new HttpException(Response::HTTP_INTERNAL_SERVER_ERROR, 'Unable to analyze image');
        }

        return $this->parseResponse($response->json());
    }

    private function parseResponse(array $response): array
    {
        if (! empty($response['predicted_classes'])) {
            return array_map(function ($prediction) {
                return str($prediction)->replace('-', ' ')->title();
            }, $response['predicted_classes']);
        }

        $predictions = collect($response['predictions'])
            ->filter(fn ($prediction) => $prediction['confidence'] >= 0.4)
            ->sortByDesc('confidence')
            ->take(3)
            ->keys()
            ->toArray();

        if (! empty($predictions)) {
            return array_map(function ($prediction) {
                return str($prediction)->replace('-', ' ')->title();
            }, $predictions);
        }

        return ['No predictions found'];
    }
}
