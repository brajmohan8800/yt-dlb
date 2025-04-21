<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get the URL from the form input
    $url = filter_var($_POST['url'], FILTER_SANITIZE_URL);

    if (filter_var($url, FILTER_VALIDATE_URL) === false) {
        // If URL is not valid, redirect with error
        header('Location: index.html?error=Invalid URL');
        exit;
    }

    // Set the download command with yt-dlp
    // Using -f best to download the best available format (both video and audio in one)
    $downloadCommand = "yt-dlp -f best -o 'downloads/%(title)s.%(ext)s' $url";

    // Execute the download command
    $output = shell_exec($downloadCommand);

    // Check if the video was downloaded successfully
    if ($output) {
        // Extract the video title from the output
        preg_match('/\[download\] Destination: (.+)/', $output, $matches);
        if (isset($matches[1])) {
            $videoFile = $matches[1];

            // Serve the video file for download
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename="' . basename($videoFile) . '"');
            header('Content-Length: ' . filesize($videoFile));
            readfile($videoFile);

            // Delete the video file after it has been downloaded
            unlink($videoFile);  // Delete the file

            exit;
        } else {
            header('Location: index.html?error=Failed to download video');
            exit;
        }
    } else {
        // If the video couldn't be downloaded, show an error
        header('Location: index.html?error=Failed to execute download command');
        exit;
    }
}
?>
