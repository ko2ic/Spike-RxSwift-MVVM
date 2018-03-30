//
//  FileUploadDto.swift
//  RakuRen
//
//  Created by マイン・グエン・フー on 2017/07/12.
//  Copyright © 2017年 eole. All rights reserved.
//

/// アップロードする前ファイルDto
public struct FileUploadDto {

    public let name: String
    public let fileName: String
    public let type: MimeType
    public let fileData: Data

    public init(name: String, fileName: String, type: MimeType, fileData: Data) {
        self.fileName = fileName
        self.type = type
        self.fileData = fileData
        self.name = name
    }

    public func isNotAcceptedImageType() -> Bool {
        return self.type != .jpeg && self.type != .png && self.type != .gif
    }
}
