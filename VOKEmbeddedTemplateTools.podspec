Pod::Spec.new do |s|
  s.name             = "VOKEmbeddedTemplateTools"
  s.version          = "0.1.0"
  s.summary          = "Handle a zip file of mustache templates embedded into the Mach-O executable."

  s.description      = <<-DESC
                            Includes:
                            - a category on NSData for getting data embedded into the Mach-O executable (embedding done via "Other Linker Flags" `-sectcreate __TEXT __your_name "some_file_name"`)
                            - a category on [ZipZap](https://github.com/pixelglow/zipzap)'s `ZZArchive` to load an archive from data embedded into the Mach-O executable
                            - a [GRMustache](https://github.com/groue/GRMustache) `GRMustacheTemplateRepository` subclass that loads its templates from a `ZZArchive`

                            ***NOTE:*** The Mach-O executable embedded data reading doesn't seem to compile when pods are set to use frameworks.
                       DESC

  s.homepage         = "https://github.com/vokal/VOKEmbeddedTemplateTools"
  s.license          = 'MIT'
  s.author           = { "Isaac Greenspan" => "isaac.greenspan@vokal.io" }
  s.source           = { :git => "https://github.com/vokal/VOKEmbeddedTemplateTools.git", :tag => s.version.to_s }

  s.platform = :osx, '10.9'
  s.requires_arc = true

  s.subspec 'NSData+VOKMachOEmbedded' do |ss|
    ss.source_files = 'Pod/NSData+VOKMachOEmbedded.{h,m}'
  end

  s.subspec 'ZZArchive+VOKMachOEmbedded' do |ss|
    ss.source_files = 'Pod/ZZArchive+VOKMachOEmbedded.{h,m}'
    ss.dependency 'VOKEmbeddedTemplateTools/NSData+VOKMachOEmbedded'
    ss.dependency 'zipzap', '~> 8.0.3'
  end

  s.subspec 'VOKZZArchiveTemplateRepository' do |ss|
    ss.source_files = 'Pod/VOKZZArchiveTemplateRepository.{h,m}'
    ss.dependency 'zipzap', '~> 8.0.3'
    ss.dependency 'GRMustache', '~> 7.3.0'
  end
end
