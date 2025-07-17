// ckeditor-upload-adapter.js

// Gắn plugin adapter vào CKEditor
function CustomUploadAdapterPlugin(editor) {
    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
        return new MyUploadAdapter(loader);
    };
}

// Lớp adapter xử lý upload ảnh về BE
class MyUploadAdapter {
    constructor(loader) {
        this.loader = loader;
    }

    async upload() {
        const file = await this.loader.file;
        const formData = new FormData();
        formData.append('file', file);

        try {
            const response = await fetch('/PenguinShop/api/upload-image', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) {
                throw new Error('Upload failed');
            }

            const result = await response.json();
            return {
                default: result.imageUrl
            };
        } catch (err) {
            console.error('Upload error:', err);
            throw err;
        }
    }

    abort() {
        // Xử lý nếu cần hủy upload
    }
}



