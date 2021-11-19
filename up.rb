require 'sinatra'
require 'digest'

set :environment,:production

get '/' do
    images_name=Dir.glob("public/files/*")
    @images_path=[]
   # @images_hash=[] #どうやって表示しよう

    images_name.each do |a|
        c=estimateDigest(a)
        print("#{c}\n")
        #@images_hash.push(c)
        @images_path << a.gsub("public/files/","")
        @images_path << ("戦闘力：#{c}")
    end
    erb :index
end

def estimateDigest(x)
    digest=Digest::SHA256.file(x)
    a=(digest.hexdigest.to_i(16)).to_s(2) #10進数に変換してからさらに2進数に変換する
    c=(a[1,32]).to_i(2) #先頭32bitをとる、そして10進数に戻す
    return c
end

post '/upload' do
    s=params[:file]
    if s!=nil
        save_path="./public/files/#{params[:file][:filename]}"
        File.open(save_path,'wb') do |f|
            g=params[:file][:tempfile]
            f.write g.read
        end
    else
        puts "Upload failed"
    end
    redirect '/'
end
